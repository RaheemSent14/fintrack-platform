variable "bucket_name" {
  type        = string
  description = "Globally unique name for the SSM transit bucket"
  default     = "fintrack-ansible-ssm-transit-us-east-1-rs"
}

variable "tags" {
  type        = map(string)
  description = "Standard project tags"
}
