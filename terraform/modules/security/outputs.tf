output "master_sg_id" {
  value = aws_security_group.k3s_master.id
}

output "worker_sg_id" {
  value = aws_security_group.k3s_worker.id
}

output "ec2_instance_profile_name" {
  value = aws_iam_instance_profile.ec2_profile.name
}
