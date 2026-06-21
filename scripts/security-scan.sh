#!/bin/bash
# ══════════════════════════════════════════════════════════
# WHAT:      Runs Checkov static analysis against our Terraform code.
# WHY:       Finding security flaws (like open ports or unencrypted buckets) in code is 100x cheaper and faster than finding them in production.
# BUSINESS:  Demonstrates proactive risk mitigation. We don't wait for a penetration test to find our mistakes.
# ENGINEER:  If Checkov flags a "false positive" (e.g., complaining about no NAT Gateway when we explicitly chose not to use one to save money), we learn how to use inline suppression comments to document the accepted risk.
# ══════════════════════════════════════════════════════════

set -e

# Ensure the security docs directory exists
mkdir -p docs/security

echo "🔍 Checking if Checkov is installed..."
if ! command -v checkov &> /dev/null; then
    echo "📦 Installing Checkov via Homebrew..."
    brew install checkov
fi

echo "🛡️ Running Checkov scan on the terraform directory..."
# Run the scan and output both to the terminal and a markdown file
checkov -d terraform/ -o cli | tee docs/security/terraform-scan-results.md

echo "✅ Scan complete! Results saved to docs/security/terraform-scan-results.md"
