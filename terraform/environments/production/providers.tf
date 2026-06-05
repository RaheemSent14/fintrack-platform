# ══════════════════════════════════════════════════════════
# WHAT:      Configures the AWS provider, sets the remote backend, and enforces global tags.
# WHY:       Centralizes our AWS connection settings and ensures every resource gets tagged automatically without repeating code.
# BUSINESS:  Cost allocation. If a resource isn't tagged, finance doesn't know who to bill. Default tags solve this at the root.
# ENGINEER:  The backend block is what tells Terraform to use the S3 bucket we just created instead of a local file.
# RECRUITER: Shows understanding of FinOps (cost tracking) and IaC best practices (version pinning, remote state).
# ══════════════════════════════════════════════════════════

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "fintrack-tf-state-raheem14"
    key            = "production/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "fintrack-tf-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Project     = "fintrack"
      ManagedBy   = "terraform"
      Environment = "production"
      Owner       = "raheem"
      CostCenter  = "portfolio"
      Repository  = "fintrack-platform"
    }
  }
}
