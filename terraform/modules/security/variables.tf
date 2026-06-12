# terraform/modules/security/variables.tf

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "admin_ip" {
  type        = string
  description = "The public IP address of the administrator (your laptop) for SSH and K8s API access"
}

variable "ssm_transit_bucket_arn" {
  type        = string
  description = "ARN of the SSM transit bucket for Ansible access"
}
