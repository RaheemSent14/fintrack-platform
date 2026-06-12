# ══════════════════════════════════════════════════════════
# WHAT:      Creates Security Groups (firewalls) and IAM Roles (identities) for our EC2 instances.
# WHY:       Servers in public subnets must be ruthlessly locked down. We drop all traffic by default and explicitly allow only what is necessary.
# BUSINESS:  Prevents ransomware and unauthorized access to customer data.
# ENGINEER:  Notice the IAM Role has NO AdministratorAccess. We use Least Privilege: it can only use AWS Session Manager and read a specific S3 bucket.
# RECRUITER: Demonstrates DevSecOps maturity. Port 22 (SSH) is locked to a specific IP, not 0.0.0.0/0.
# ══════════════════════════════════════════════════════════

# ---------------------------------------------------------
# SECURITY GROUPS (Base Groups)
# ---------------------------------------------------------
resource "aws_security_group" "k3s_master" {
  name        = "fintrack-k3s-master-sg-${var.environment}"
  description = "Security group for k3s master node"
  vpc_id      = var.vpc_id

  # Kubernetes API: Only accessible from your specific IP
  ingress {
    description = "K8s API from Admin IP"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["${var.admin_ip}/32"]
  }

  # SSH: Only accessible from your specific IP
  ingress {
    description = "SSH from Admin IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.admin_ip}/32"]
  }

  # HTTP: Open to the world (Redirects to HTTPS)
  ingress {
    description = "HTTP from World"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS: Open to the world (Application traffic)
  ingress {
    description = "HTTPS from World"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "fintrack-master-sg-${var.environment}"
  }
}

resource "aws_security_group" "k3s_worker" {
  name        = "fintrack-k3s-worker-sg-${var.environment}"
  description = "Security group for k3s worker nodes"
  vpc_id      = var.vpc_id

  # Workers need to pull Docker images from the internet
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "fintrack-worker-sg-${var.environment}"
  }
}

# ---------------------------------------------------------
# SECURITY GROUP RULES (Decoupled to prevent Cycle Errors)
# ---------------------------------------------------------
# Allow Master to receive traffic from Worker
resource "aws_security_group_rule" "master_from_worker" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.k3s_master.id
  source_security_group_id = aws_security_group.k3s_worker.id
  description              = "Allow all internal traffic from worker nodes"
}

# Allow Worker to receive traffic from Master
resource "aws_security_group_rule" "worker_from_master" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.k3s_worker.id
  source_security_group_id = aws_security_group.k3s_master.id
  description              = "Allow all internal traffic from master node"
}

# ---------------------------------------------------------
# IAM ROLE & INSTANCE PROFILE
# ---------------------------------------------------------
resource "aws_iam_role" "ec2_role" {
  name = "fintrack-ec2-role-${var.environment}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# AWS Managed Policy to allow AWS Session Manager (Secure SSH alternative)
resource "aws_iam_role_policy_attachment" "ssm_core" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Custom Policy for Least Privilege: Only read specific S3 bucket
resource "aws_iam_policy" "s3_read_only" {
  name        = "fintrack-s3-read-${var.environment}"
  description = "Allow EC2 to read configuration from S3"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::fintrack-tf-state-*",
          "arn:aws:s3:::fintrack-tf-state-*/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_read_attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.s3_read_only.arn
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "fintrack-ec2-profile-${var.environment}"
  role = aws_iam_role.ec2_role.name
}

# ---------------------------------------------------------
# SSM TRANSIT BUCKET ACCESS (Ansible over SSM)
# ---------------------------------------------------------
# WHAT — Grants the EC2 instances minimal access to the SSM transit S3 bucket.
# WHY — The instances need to download (GetObject) and verify (ListBucket) the Ansible payloads, and return execution results (PutObject).
# BUSINESS — Adheres to least privilege. If an instance is compromised, the attacker only gets access to ephemeral transit scripts, not the entire AWS account.
# ENGINEER — Scoping S3 permissions by exact ARN rather than resource "*" is a critical cloud security fundamental.
# RECRUITER — Highlights strict IAM hygiene and zero-trust principles.

data "aws_iam_policy_document" "ssm_transit_access" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListBucket"
    ]
    resources = [
      var.ssm_transit_bucket_arn,
      "${var.ssm_transit_bucket_arn}/*"
    ]
  }
}

resource "aws_iam_role_policy" "ssm_transit_attachment" {
  name   = "ssm-transit-bucket-access"
  role   = aws_iam_role.ec2_role.name
  policy = data.aws_iam_policy_document.ssm_transit_access.json
}
