#!/bin/bash
# ══════════════════════════════════════════════════════════
# WHAT:      Bootstraps the AWS S3 bucket and DynamoDB table for Terraform remote state.
# WHY:       Terraform needs a secure, locked, centralized place to store its understanding of the cloud (state). We must build this with the CLI before Terraform can run.
# BUSINESS:  Prevents "split-brain" infrastructure where two engineers deploy conflicting changes, causing downtime.
# ENGINEER:  State locking is mandatory for CI/CD pipelines. If a GitHub Action and a human apply at the same time, DynamoDB blocks one to save the environment.
# RECRUITER: Demonstrates enterprise-grade IaC setup, not just a localized tutorial script.
# ══════════════════════════════════════════════════════════

set -e

# We use your GitHub handle or initials to ensure the S3 bucket name is globally unique
UNIQUE_ID="raheem14" # Change this if it throws a "Bucket already exists" error
BUCKET_NAME="fintrack-tf-state-${UNIQUE_ID}"
TABLE_NAME="fintrack-tf-locks"
REGION="us-east-1" # Using us-east-1 as it typically has the highest Free Tier availability

echo "🚀 Starting FinTrack Remote State Bootstrap..."

# 1. Create the S3 Bucket
echo "📦 Creating S3 bucket: ${BUCKET_NAME}..."
aws s3api create-bucket \
    --bucket ${BUCKET_NAME} \
    --region ${REGION}

# 2. Enable Bucket Versioning
# WHY: If someone accidentally deletes or corrupts the state file, we can rollback to the previous version and save production.
echo "🔄 Enabling versioning..."
aws s3api put-bucket-versioning \
    --bucket ${BUCKET_NAME} \
    --versioning-configuration Status=Enabled

# 3. Block Public Access
# WHY: The state file contains plain-text passwords, architecture maps, and IPs. If this is public, we are compromised.
echo "🔒 Blocking public access..."
aws s3api put-public-access-block \
    --bucket ${BUCKET_NAME} \
    --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"

# 4. Create DynamoDB Table for State Locking
# WHY: Provides a locking mechanism so two applies cannot run concurrently.
echo "🔑 Creating DynamoDB locking table..."
aws dynamodb create-table \
    --table-name ${TABLE_NAME} \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --billing-mode PAY_PER_REQUEST \
    --region ${REGION}

echo "✅ Success! Remote state infrastructure created."
echo "Bucket: ${BUCKET_NAME}"
echo "Table:  ${TABLE_NAME}"
