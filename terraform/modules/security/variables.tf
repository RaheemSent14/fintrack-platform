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
