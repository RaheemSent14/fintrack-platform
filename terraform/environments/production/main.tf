# ══════════════════════════════════════════════════════════
# WHAT:      The root execution file for the Production environment.
# WHY:       This file calls the reusable modules and passes variables between them (e.g., passing the VPC ID from the networking module to the security module).
# ══════════════════════════════════════════════════════════

module "networking" {
  source = "../../modules/networking"

  environment           = var.environment
  vpc_cidr              = "10.0.0.0/16"
  public_subnet_a_cidr  = "10.0.1.0/24"
  public_subnet_b_cidr  = "10.0.2.0/24"
  private_subnet_a_cidr = "10.0.10.0/24"
  private_subnet_b_cidr = "10.0.20.0/24"
}

module "ssm_transit" {
  source = "../../modules/ssm-transit"

  bucket_name = "fintrack-ansible-ssm-transit-us-east-1-rs"
  tags = {
    Environment = var.environment
    Project     = "fintrack"
  }
}

module "security" {
  source = "../../modules/security"

  environment            = var.environment
  vpc_id                 = module.networking.vpc_id
  admin_ip               = var.admin_ip
  ssm_transit_bucket_arn = module.ssm_transit.bucket_arn
}

module "compute" {
  source = "../../modules/compute"

  environment        = var.environment
  public_subnet_a_id = module.networking.public_subnet_a_id
  public_subnet_b_id = module.networking.public_subnet_b_id
  master_sg_id       = module.security.master_sg_id
  worker_sg_id       = module.security.worker_sg_id
  iam_profile_name   = module.security.ec2_instance_profile_name
}

module "budget_alerts" {
  source = "../../modules/budget-alerts"

  environment = var.environment
  alert_email = var.alert_email
}
