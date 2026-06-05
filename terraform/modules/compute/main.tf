# ══════════════════════════════════════════════════════════
# WHAT:      Deploys the EC2 instances (servers) and provisions SSH keys.
# WHY:       We need compute power to run our Kubernetes (k3s) cluster.
# BUSINESS:  These are the actual engines that will serve FinTrack's 10,000 users.
# ENGINEER:  Notice we generate the SSH key in Terraform instead of the console. Everything must be reproducible. We also pin the AMI dynamically so it doesn't break when AWS updates images.
# RECRUITER: Demonstrates proper use of data sources, dynamic IP allocation (EIP), and automated bootstrapping (user_data).
# ══════════════════════════════════════════════════════════

# 1. Dynamically fetch the latest Ubuntu 22.04 LTS AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical's official AWS account ID

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

# 2. Generate a secure SSH key pair
resource "tls_private_key" "k3s" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "k3s" {
  key_name   = "fintrack-k3s-key-${var.environment}"
  public_key = tls_private_key.k3s.public_key_openssh
}

# 3. Master Node (Control Plane)
resource "aws_instance" "master" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro" # AWS Free Tier (Forced Pivot)
  subnet_id              = var.public_subnet_a_id
  vpc_security_group_ids = [var.master_sg_id]
  key_name               = aws_key_pair.k3s.key_name
  iam_instance_profile   = var.iam_profile_name

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required" # Enforces IMDSv2
    http_put_response_hop_limit = 1
  }

  # Bootstrapping script
  user_data = <<-EOF
              #!/bin/bash
              sudo snap install amazon-ssm-agent --classic
              sudo systemctl enable amazon-ssm-agent
              sudo systemctl start amazon-ssm-agent
              EOF

  tags = {
    Name = "fintrack-k3s-master-${var.environment}"
    Role = "control-plane"
  }
}

# 4. Elastic IP for the Master Node (so the API address never changes)
resource "aws_eip" "master" {
  instance = aws_instance.master.id
  domain   = "vpc"

  tags = {
    Name = "fintrack-master-eip-${var.environment}"
  }
}

# 5. Worker Node (Runs the application)
resource "aws_instance" "worker" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro" # AWS Free Tier (Forced Pivot)
  subnet_id              = var.public_subnet_b_id
  vpc_security_group_ids = [var.worker_sg_id]
  key_name               = aws_key_pair.k3s.key_name
  iam_instance_profile   = var.iam_profile_name

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required" # Enforces IMDSv2
    http_put_response_hop_limit = 1
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo snap install amazon-ssm-agent --classic
              sudo systemctl enable amazon-ssm-agent
              sudo systemctl start amazon-ssm-agent
              EOF

  tags = {
    Name = "fintrack-k3s-worker-${var.environment}"
    Role = "worker"
  }
}
