# Security Findings Log (Checkov)

| Finding ID | Resource | Status | Justification |
| :--- | :--- | :--- | :--- |
| **CKV_AWS_79** | EC2 Instances | **FIXED** | Enforced IMDSv2 via Terraform `metadata_options` to prevent SSRF credential theft. |
| **CKV_AWS_126** | EC2 Instances | ACCEPTED RISK | Detailed monitoring disabled to avoid CloudWatch custom metric charges (strict FinOps constraint). |
| **CKV_AWS_8** | EC2 Instances | ACCEPTED RISK | Default AWS managed EBS keys used. Custom KMS key skipped to save $1/month. |
| **CKV_AWS_135** | EC2 Instances | ACCEPTED RISK | EBS Optimization is not uniformly supported or free on all micro instances. |
| **CKV_AWS_130** | Public Subnets | ACCEPTED RISK | Subnets auto-assign public IPs by design so worker nodes can pull Docker images without a NAT Gateway. |
