

       _               _
   ___| |__   ___  ___| | _______   __
  / __| '_ \ / _ \/ __| |/ / _ \ \ / /
 | (__| | | |  __/ (__|   < (_) \ V /
  \___|_| |_|\___|\___|_|\_\___/ \_/

By Prisma Cloud | version: 3.2.530
Update available 3.2.530 -> 3.2.533
Run pip3 install -U checkov to update


terraform scan results:

Passed checks: 38, Failed checks: 15, Skipped checks: 0

Check: CKV_AWS_41: "Ensure no hard coded AWS access key and secret key exists in provider"
	PASSED for resource: aws.default
	File: /environments/production/providers.tf:28-41
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/secrets-policies/bc-aws-secrets-5
Check: CKV_AWS_386: "Reduce potential for WhoAMI cloud image name confusion attack"
	PASSED for resource: module.compute.aws_ami.ubuntu
	File: /modules/compute/main.tf:10-18
	Calling File: /environments/production/main.tf:25-34
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-supply-chain-policies/bc-aws-386
Check: CKV_AWS_88: "EC2 instance should not have public IP."
	PASSED for resource: module.compute.aws_instance.master
	File: /modules/compute/main.tf:32-52
	Calling File: /environments/production/main.tf:25-34
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/public-policies/public-12
Check: CKV_AWS_46: "Ensure no hard-coded secrets exist in EC2 user data"
	PASSED for resource: module.compute.aws_instance.master
	File: /modules/compute/main.tf:32-52
	Calling File: /environments/production/main.tf:25-34
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/secrets-policies/bc-aws-secrets-1
Check: CKV_AWS_88: "EC2 instance should not have public IP."
	PASSED for resource: module.compute.aws_instance.worker
	File: /modules/compute/main.tf:65-84
	Calling File: /environments/production/main.tf:25-34
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/public-policies/public-12
Check: CKV_AWS_46: "Ensure no hard-coded secrets exist in EC2 user data"
	PASSED for resource: module.compute.aws_instance.worker
	File: /modules/compute/main.tf:65-84
	Calling File: /environments/production/main.tf:25-34
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/secrets-policies/bc-aws-secrets-1
Check: CKV_AWS_130: "Ensure VPC subnets do not assign public IP by default"
	PASSED for resource: module.networking.aws_subnet.private_a
	File: /modules/networking/main.tf:60-69
	Calling File: /environments/production/main.tf:6-15
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-vpc-subnets-do-not-assign-public-ip-by-default
Check: CKV_AWS_130: "Ensure VPC subnets do not assign public IP by default"
	PASSED for resource: module.networking.aws_subnet.private_b
	File: /modules/networking/main.tf:71-80
	Calling File: /environments/production/main.tf:6-15
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-vpc-subnets-do-not-assign-public-ip-by-default
Check: CKV_AWS_24: "Ensure no security groups allow ingress from 0.0.0.0:0 to port 22"
	PASSED for resource: module.security.aws_security_group.k3s_master
	File: /modules/security/main.tf:12-63
	Calling File: /environments/production/main.tf:17-23
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/networking-1-port-security
Check: CKV_AWS_277: "Ensure no security groups allow ingress from 0.0.0.0:0 to port -1"
	PASSED for resource: module.security.aws_security_group.k3s_master
	File: /modules/security/main.tf:12-63
	Calling File: /environments/production/main.tf:17-23
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-security-group-does-not-allow-all-traffic-on-all-ports
Check: CKV_AWS_25: "Ensure no security groups allow ingress from 0.0.0.0:0 to port 3389"
	PASSED for resource: module.security.aws_security_group.k3s_master
	File: /modules/security/main.tf:12-63
	Calling File: /environments/production/main.tf:17-23
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/networking-2
Check: CKV_AWS_260: "Ensure no security groups allow ingress from 0.0.0.0:0 to port 80"
	PASSED for resource: module.security.aws_security_group.k3s_worker
	File: /modules/security/main.tf:65-81
	Calling File: /environments/production/main.tf:17-23
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-security-groups-do-not-allow-ingress-from-00000-to-port-80
Check: CKV_AWS_24: "Ensure no security groups allow ingress from 0.0.0.0:0 to port 22"
	PASSED for resource: module.security.aws_security_group.k3s_worker
	File: /modules/security/main.tf:65-81
	Calling File: /environments/production/main.tf:17-23
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/networking-1-port-security
Check: CKV_AWS_277: "Ensure no security groups allow ingress from 0.0.0.0:0 to port -1"
	PASSED for resource: module.security.aws_security_group.k3s_worker
	File: /modules/security/main.tf:65-81
	Calling File: /environments/production/main.tf:17-23
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-security-group-does-not-allow-all-traffic-on-all-ports
Check: CKV_AWS_25: "Ensure no security groups allow ingress from 0.0.0.0:0 to port 3389"
	PASSED for resource: module.security.aws_security_group.k3s_worker
	File: /modules/security/main.tf:65-81
	Calling File: /environments/production/main.tf:17-23
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/networking-2
Check: CKV_AWS_260: "Ensure no security groups allow ingress from 0.0.0.0:0 to port 80"
	PASSED for resource: module.security.aws_security_group_rule.master_from_worker
	File: /modules/security/main.tf:87-95
	Calling File: /environments/production/main.tf:17-23
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-security-groups-do-not-allow-ingress-from-00000-to-port-80
Check: CKV_AWS_24: "Ensure no security groups allow ingress from 0.0.0.0:0 to port 22"
	PASSED for resource: module.security.aws_security_group_rule.master_from_worker
	File: /modules/security/main.tf:87-95
	Calling File: /environments/production/main.tf:17-23
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/networking-1-port-security
Check: CKV_AWS_23: "Ensure every security group and rule has a description"
	PASSED for resource: module.security.aws_security_group_rule.master_from_worker
	File: /modules/security/main.tf:87-95
	Calling File: /environments/production/main.tf:17-23
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/networking-31
Check: CKV_AWS_277: "Ensure no security groups allow ingress from 0.0.0.0:0 to port -1"
	PASSED for resource: module.security.aws_security_group_rule.master_from_worker
	File: /modules/security/main.tf:87-95
	Calling File: /environments/production/main.tf:17-23
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-security-group-does-not-allow-all-traffic-on-all-ports
Check: CKV_AWS_25: "Ensure no security groups allow ingress from 0.0.0.0:0 to port 3389"
	PASSED for resource: module.security.aws_security_group_rule.master_from_worker
	File: /modules/security/main.tf:87-95
	Calling File: /environments/production/main.tf:17-23
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/networking-2
Check: CKV_AWS_260: "Ensure no security groups allow ingress from 0.0.0.0:0 to port 80"
	PASSED for resource: module.security.aws_security_group_rule.worker_from_master
	File: /modules/security/main.tf:98-106
	Calling File: /environments/production/main.tf:17-23
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-security-groups-do-not-allow-ingress-from-00000-to-port-80
Check: CKV_AWS_24: "Ensure no security groups allow ingress from 0.0.0.0:0 to port 22"
	PASSED for resource: module.security.aws_security_group_rule.worker_from_master
	File: /modules/security/main.tf:98-106
	Calling File: /environments/production/main.tf:17-23
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/networking-1-port-security
Check: CKV_AWS_23: "Ensure every security group and rule has a description"
	PASSED for resource: module.security.aws_security_group_rule.worker_from_master
	File: /modules/security/main.tf:98-106
	Calling File: /environments/production/main.tf:17-23
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/networking-31
Check: CKV_AWS_277: "Ensure no security groups allow ingress from 0.0.0.0:0 to port -1"
	PASSED for resource: module.security.aws_security_group_rule.worker_from_master
	File: /modules/security/main.tf:98-106
	Calling File: /environments/production/main.tf:17-23
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-security-group-does-not-allow-all-traffic-on-all-ports
Check: CKV_AWS_25: "Ensure no security groups allow ingress from 0.0.0.0:0 to port 3389"
	PASSED for resource: module.security.aws_security_group_rule.worker_from_master
	File: /modules/security/main.tf:98-106
	Calling File: /environments/production/main.tf:17-23
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/networking-2
Check: CKV_AWS_274: "Disallow IAM roles, users, and groups from using the AWS AdministratorAccess policy"
	PASSED for resource: module.security.aws_iam_role.ec2_role
	File: /modules/security/main.tf:111-126
	Calling File: /environments/production/main.tf:17-23
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/bc-aws-274
Check: CKV_AWS_61: "Ensure AWS IAM policy does not allow assume role permission across all services"
	PASSED for resource: module.security.aws_iam_role.ec2_role
	File: /modules/security/main.tf:111-126
	Calling File: /environments/production/main.tf:17-23
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/bc-aws-iam-45
Check: CKV_AWS_60: "Ensure IAM role allows only specific services or principals to assume it"
	PASSED for resource: module.security.aws_iam_role.ec2_role
	File: /modules/security/main.tf:111-126
	Calling File: /environments/production/main.tf:17-23
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/bc-aws-iam-44
Check: CKV_AWS_274: "Disallow IAM roles, users, and groups from using the AWS AdministratorAccess policy"
	PASSED for resource: module.security.aws_iam_role_policy_attachment.ssm_core
	File: /modules/security/main.tf:129-132
	Calling File: /environments/production/main.tf:17-23
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/bc-aws-274
Check: CKV_AWS_288: "Ensure IAM policies does not allow data exfiltration"
	PASSED for resource: module.security.aws_iam_policy.s3_read_only
	File: /modules/security/main.tf:135-155
	Calling File: /environments/production/main.tf:17-23
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/bc-aws-288
Check: CKV_AWS_290: "Ensure IAM policies does not allow write access without constraints"
	PASSED for resource: module.security.aws_iam_policy.s3_read_only
	File: /modules/security/main.tf:135-155
	Calling File: /environments/production/main.tf:17-23
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/bc-aws-290
Check: CKV_AWS_287: "Ensure IAM policies does not allow credentials exposure"
	PASSED for resource: module.security.aws_iam_policy.s3_read_only
	File: /modules/security/main.tf:135-155
	Calling File: /environments/production/main.tf:17-23
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/bc-aws-287
Check: CKV_AWS_63: "Ensure no IAM policies documents allow "*" as a statement's actions"
	PASSED for resource: module.security.aws_iam_policy.s3_read_only
	File: /modules/security/main.tf:135-155
	Calling File: /environments/production/main.tf:17-23
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/iam-48
Check: CKV_AWS_289: "Ensure IAM policies does not allow permissions management / resource exposure without constraints"
	PASSED for resource: module.security.aws_iam_policy.s3_read_only
	File: /modules/security/main.tf:135-155
	Calling File: /environments/production/main.tf:17-23
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/bc-aws-289
Check: CKV_AWS_62: "Ensure IAM policies that allow full "*-*" administrative privileges are not created"
	PASSED for resource: module.security.aws_iam_policy.s3_read_only
	File: /modules/security/main.tf:135-155
	Calling File: /environments/production/main.tf:17-23
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/bc-aws-iam-45
Check: CKV_AWS_355: "Ensure no IAM policies documents allow "*" as a statement's resource for restrictable actions"
	PASSED for resource: module.security.aws_iam_policy.s3_read_only
	File: /modules/security/main.tf:135-155
	Calling File: /environments/production/main.tf:17-23
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/bc-aws-355
Check: CKV_AWS_286: "Ensure IAM policies does not allow privilege escalation"
	PASSED for resource: module.security.aws_iam_policy.s3_read_only
	File: /modules/security/main.tf:135-155
	Calling File: /environments/production/main.tf:17-23
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/bc-aws-286
Check: CKV_AWS_274: "Disallow IAM roles, users, and groups from using the AWS AdministratorAccess policy"
	PASSED for resource: module.security.aws_iam_role_policy_attachment.s3_read_attach
	File: /modules/security/main.tf:157-160
	Calling File: /environments/production/main.tf:17-23
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/bc-aws-274
Check: CKV_AWS_79: "Ensure Instance Metadata Service Version 1 is not enabled"
	FAILED for resource: module.compute.aws_instance.master
	File: /modules/compute/main.tf:32-52
	Calling File: /environments/production/main.tf:25-34
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-general-policies/bc-aws-general-31

		32 | resource "aws_instance" "master" {
		33 |   ami                    = data.aws_ami.ubuntu.id
		34 |   instance_type          = "t3.micro" # AWS Free Tier
		35 |   subnet_id              = var.public_subnet_a_id
		36 |   vpc_security_group_ids = [var.master_sg_id]
		37 |   key_name               = aws_key_pair.k3s.key_name
		38 |   iam_instance_profile   = var.iam_profile_name
		39 |
		40 |   # Bootstrapping script
		41 |   user_data = <<-EOF
		42 |               #!/bin/bash
		43 |               sudo snap install amazon-ssm-agent --classic
		44 |               sudo systemctl enable amazon-ssm-agent
		45 |               sudo systemctl start amazon-ssm-agent
		46 |               EOF
		47 |
		48 |   tags = {
		49 |     Name = "fintrack-k3s-master-${var.environment}"
		50 |     Role = "control-plane"
		51 |   }
		52 | }

Check: CKV_AWS_126: "Ensure that detailed monitoring is enabled for EC2 instances"
	FAILED for resource: module.compute.aws_instance.master
	File: /modules/compute/main.tf:32-52
	Calling File: /environments/production/main.tf:25-34
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-logging-policies/ensure-that-detailed-monitoring-is-enabled-for-ec2-instances

		32 | resource "aws_instance" "master" {
		33 |   ami                    = data.aws_ami.ubuntu.id
		34 |   instance_type          = "t3.micro" # AWS Free Tier
		35 |   subnet_id              = var.public_subnet_a_id
		36 |   vpc_security_group_ids = [var.master_sg_id]
		37 |   key_name               = aws_key_pair.k3s.key_name
		38 |   iam_instance_profile   = var.iam_profile_name
		39 |
		40 |   # Bootstrapping script
		41 |   user_data = <<-EOF
		42 |               #!/bin/bash
		43 |               sudo snap install amazon-ssm-agent --classic
		44 |               sudo systemctl enable amazon-ssm-agent
		45 |               sudo systemctl start amazon-ssm-agent
		46 |               EOF
		47 |
		48 |   tags = {
		49 |     Name = "fintrack-k3s-master-${var.environment}"
		50 |     Role = "control-plane"
		51 |   }
		52 | }

Check: CKV_AWS_135: "Ensure that EC2 is EBS optimized"
	FAILED for resource: module.compute.aws_instance.master
	File: /modules/compute/main.tf:32-52
	Calling File: /environments/production/main.tf:25-34
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-general-policies/ensure-that-ec2-is-ebs-optimized

		32 | resource "aws_instance" "master" {
		33 |   ami                    = data.aws_ami.ubuntu.id
		34 |   instance_type          = "t3.micro" # AWS Free Tier
		35 |   subnet_id              = var.public_subnet_a_id
		36 |   vpc_security_group_ids = [var.master_sg_id]
		37 |   key_name               = aws_key_pair.k3s.key_name
		38 |   iam_instance_profile   = var.iam_profile_name
		39 |
		40 |   # Bootstrapping script
		41 |   user_data = <<-EOF
		42 |               #!/bin/bash
		43 |               sudo snap install amazon-ssm-agent --classic
		44 |               sudo systemctl enable amazon-ssm-agent
		45 |               sudo systemctl start amazon-ssm-agent
		46 |               EOF
		47 |
		48 |   tags = {
		49 |     Name = "fintrack-k3s-master-${var.environment}"
		50 |     Role = "control-plane"
		51 |   }
		52 | }

Check: CKV_AWS_8: "Ensure all data stored in the Launch configuration or instance Elastic Blocks Store is securely encrypted"
	FAILED for resource: module.compute.aws_instance.master
	File: /modules/compute/main.tf:32-52
	Calling File: /environments/production/main.tf:25-34
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-general-policies/general-13

		32 | resource "aws_instance" "master" {
		33 |   ami                    = data.aws_ami.ubuntu.id
		34 |   instance_type          = "t3.micro" # AWS Free Tier
		35 |   subnet_id              = var.public_subnet_a_id
		36 |   vpc_security_group_ids = [var.master_sg_id]
		37 |   key_name               = aws_key_pair.k3s.key_name
		38 |   iam_instance_profile   = var.iam_profile_name
		39 |
		40 |   # Bootstrapping script
		41 |   user_data = <<-EOF
		42 |               #!/bin/bash
		43 |               sudo snap install amazon-ssm-agent --classic
		44 |               sudo systemctl enable amazon-ssm-agent
		45 |               sudo systemctl start amazon-ssm-agent
		46 |               EOF
		47 |
		48 |   tags = {
		49 |     Name = "fintrack-k3s-master-${var.environment}"
		50 |     Role = "control-plane"
		51 |   }
		52 | }

Check: CKV_AWS_79: "Ensure Instance Metadata Service Version 1 is not enabled"
	FAILED for resource: module.compute.aws_instance.worker
	File: /modules/compute/main.tf:65-84
	Calling File: /environments/production/main.tf:25-34
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-general-policies/bc-aws-general-31

		65 | resource "aws_instance" "worker" {
		66 |   ami                    = data.aws_ami.ubuntu.id
		67 |   instance_type          = "t3.micro" # AWS Free Tier
		68 |   subnet_id              = var.public_subnet_b_id
		69 |   vpc_security_group_ids = [var.worker_sg_id]
		70 |   key_name               = aws_key_pair.k3s.key_name
		71 |   iam_instance_profile   = var.iam_profile_name
		72 |
		73 |   user_data = <<-EOF
		74 |               #!/bin/bash
		75 |               sudo snap install amazon-ssm-agent --classic
		76 |               sudo systemctl enable amazon-ssm-agent
		77 |               sudo systemctl start amazon-ssm-agent
		78 |               EOF
		79 |
		80 |   tags = {
		81 |     Name = "fintrack-k3s-worker-${var.environment}"
		82 |     Role = "worker"
		83 |   }
		84 | }
Check: CKV_AWS_126: "Ensure that detailed monitoring is enabled for EC2 instances"
	FAILED for resource: module.compute.aws_instance.worker
	File: /modules/compute/main.tf:65-84
	Calling File: /environments/production/main.tf:25-34
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-logging-policies/ensure-that-detailed-monitoring-is-enabled-for-ec2-instances

		65 | resource "aws_instance" "worker" {
		66 |   ami                    = data.aws_ami.ubuntu.id
		67 |   instance_type          = "t3.micro" # AWS Free Tier
		68 |   subnet_id              = var.public_subnet_b_id
		69 |   vpc_security_group_ids = [var.worker_sg_id]
		70 |   key_name               = aws_key_pair.k3s.key_name
		71 |   iam_instance_profile   = var.iam_profile_name
		72 |
		73 |   user_data = <<-EOF
		74 |               #!/bin/bash
		75 |               sudo snap install amazon-ssm-agent --classic
		76 |               sudo systemctl enable amazon-ssm-agent
		77 |               sudo systemctl start amazon-ssm-agent
		78 |               EOF
		79 |
		80 |   tags = {
		81 |     Name = "fintrack-k3s-worker-${var.environment}"
		82 |     Role = "worker"
		83 |   }
		84 | }
Check: CKV_AWS_135: "Ensure that EC2 is EBS optimized"
	FAILED for resource: module.compute.aws_instance.worker
	File: /modules/compute/main.tf:65-84
	Calling File: /environments/production/main.tf:25-34
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-general-policies/ensure-that-ec2-is-ebs-optimized

		65 | resource "aws_instance" "worker" {
		66 |   ami                    = data.aws_ami.ubuntu.id
		67 |   instance_type          = "t3.micro" # AWS Free Tier
		68 |   subnet_id              = var.public_subnet_b_id
		69 |   vpc_security_group_ids = [var.worker_sg_id]
		70 |   key_name               = aws_key_pair.k3s.key_name
		71 |   iam_instance_profile   = var.iam_profile_name
		72 |
		73 |   user_data = <<-EOF
		74 |               #!/bin/bash
		75 |               sudo snap install amazon-ssm-agent --classic
		76 |               sudo systemctl enable amazon-ssm-agent
		77 |               sudo systemctl start amazon-ssm-agent
		78 |               EOF
		79 |
		80 |   tags = {
		81 |     Name = "fintrack-k3s-worker-${var.environment}"
		82 |     Role = "worker"
		83 |   }
		84 | }
Check: CKV_AWS_8: "Ensure all data stored in the Launch configuration or instance Elastic Blocks Store is securely encrypted"
	FAILED for resource: module.compute.aws_instance.worker
	File: /modules/compute/main.tf:65-84
	Calling File: /environments/production/main.tf:25-34
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-general-policies/general-13

		65 | resource "aws_instance" "worker" {
		66 |   ami                    = data.aws_ami.ubuntu.id
		67 |   instance_type          = "t3.micro" # AWS Free Tier
		68 |   subnet_id              = var.public_subnet_b_id
		69 |   vpc_security_group_ids = [var.worker_sg_id]
		70 |   key_name               = aws_key_pair.k3s.key_name
		71 |   iam_instance_profile   = var.iam_profile_name
		72 |
		73 |   user_data = <<-EOF
		74 |               #!/bin/bash
		75 |               sudo snap install amazon-ssm-agent --classic
		76 |               sudo systemctl enable amazon-ssm-agent
		77 |               sudo systemctl start amazon-ssm-agent
		78 |               EOF
		79 |
		80 |   tags = {
		81 |     Name = "fintrack-k3s-worker-${var.environment}"
		82 |     Role = "worker"
		83 |   }
		84 | }
Check: CKV_AWS_130: "Ensure VPC subnets do not assign public IP by default"
	FAILED for resource: module.networking.aws_subnet.public_a
	File: /modules/networking/main.tf:33-43
	Calling File: /environments/production/main.tf:6-15
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-vpc-subnets-do-not-assign-public-ip-by-default

		33 | resource "aws_subnet" "public_a" {
		34 |   vpc_id                  = aws_vpc.main.id
		35 |   cidr_block              = var.public_subnet_a_cidr
		36 |   availability_zone       = "us-east-1a"
		37 |   map_public_ip_on_launch = true
		38 |
		39 |   tags = {
		40 |     Name = "fintrack-public-a-${var.environment}"
		41 |     Tier = "Public"
		42 |   }
		43 | }

Check: CKV_AWS_130: "Ensure VPC subnets do not assign public IP by default"
	FAILED for resource: module.networking.aws_subnet.public_b
	File: /modules/networking/main.tf:45-55
	Calling File: /environments/production/main.tf:6-15
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-vpc-subnets-do-not-assign-public-ip-by-default

		45 | resource "aws_subnet" "public_b" {
		46 |   vpc_id                  = aws_vpc.main.id
		47 |   cidr_block              = var.public_subnet_b_cidr
		48 |   availability_zone       = "us-east-1b"
		49 |   map_public_ip_on_launch = true
		50 |
		51 |   tags = {
		52 |     Name = "fintrack-public-b-${var.environment}"
		53 |     Tier = "Public"
		54 |   }
		55 | }

Check: CKV_AWS_260: "Ensure no security groups allow ingress from 0.0.0.0:0 to port 80"
	FAILED for resource: module.security.aws_security_group.k3s_master
	File: /modules/security/main.tf:12-63
	Calling File: /environments/production/main.tf:17-23
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-aws-security-groups-do-not-allow-ingress-from-00000-to-port-80

		Code lines for this resource are too many. Please use IDE of your choice to review the file.
Check: CKV_AWS_23: "Ensure every security group and rule has a description"
	FAILED for resource: module.security.aws_security_group.k3s_master
	File: /modules/security/main.tf:12-63
	Calling File: /environments/production/main.tf:17-23
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/networking-31

		Code lines for this resource are too many. Please use IDE of your choice to review the file.
Check: CKV_AWS_382: "Ensure no security groups allow egress from 0.0.0.0:0 to port -1"
	FAILED for resource: module.security.aws_security_group.k3s_master
	File: /modules/security/main.tf:12-63
	Calling File: /environments/production/main.tf:17-23
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/bc-aws-382

		Code lines for this resource are too many. Please use IDE of your choice to review the file.
Check: CKV_AWS_23: "Ensure every security group and rule has a description"
	FAILED for resource: module.security.aws_security_group.k3s_worker
	File: /modules/security/main.tf:65-81
	Calling File: /environments/production/main.tf:17-23
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/networking-31

		65 | resource "aws_security_group" "k3s_worker" {
		66 |   name        = "fintrack-k3s-worker-sg-${var.environment}"
		67 |   description = "Security group for k3s worker nodes"
		68 |   vpc_id      = var.vpc_id
		69 |
		70 |   # Workers need to pull Docker images from the internet
		71 |   egress {
		72 |     from_port   = 0
		73 |     to_port     = 0
		74 |     protocol    = "-1"
		75 |     cidr_blocks = ["0.0.0.0/0"]
		76 |   }
		77 |
		78 |   tags = {
		79 |     Name = "fintrack-worker-sg-${var.environment}"
		80 |   }
		81 | }

Check: CKV_AWS_382: "Ensure no security groups allow egress from 0.0.0.0:0 to port -1"
	FAILED for resource: module.security.aws_security_group.k3s_worker
	File: /modules/security/main.tf:65-81
	Calling File: /environments/production/main.tf:17-23
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/bc-aws-382

		65 | resource "aws_security_group" "k3s_worker" {
		66 |   name        = "fintrack-k3s-worker-sg-${var.environment}"
		67 |   description = "Security group for k3s worker nodes"
		68 |   vpc_id      = var.vpc_id
		69 |
		70 |   # Workers need to pull Docker images from the internet
		71 |   egress {
		72 |     from_port   = 0
		73 |     to_port     = 0
		74 |     protocol    = "-1"
		75 |     cidr_blocks = ["0.0.0.0/0"]
		76 |   }
		77 |
		78 |   tags = {
		79 |     Name = "fintrack-worker-sg-${var.environment}"
		80 |   }
		81 | }
