# WHAT — Creates a strictly private S3 bucket with 1-day lifecycle deletion for Ansible SSM file transit.
# WHY — Ansible over SSM needs a temporary staging ground for modules and scripts because SSM payloads have size limits.
# BUSINESS — Eliminates the need for public SSH access, reducing the risk of a breach and protecting user financial data.
# ENGINEER — Demonstrates isolated infrastructure patterns. The transit bucket is ephemeral and strictly controlled to prevent orphaned file costs.
# RECRUITER — Shows understanding of S3 security best practices (Public Access Block, SSE, Lifecycle rules) instead of default setups.

resource "aws_s3_bucket" "transit" {
  bucket = var.bucket_name
  tags   = var.tags
}

resource "aws_s3_bucket_public_access_block" "transit_public_block" {
  bucket                  = aws_s3_bucket.transit.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "transit_encryption" {
  bucket = aws_s3_bucket.transit.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "transit_lifecycle" {
  bucket = aws_s3_bucket.transit.id

  rule {
    id     = "expire-transit-files-1-day"
    status = "Enabled"

    expiration {
      days = 1
    }
  }
}
