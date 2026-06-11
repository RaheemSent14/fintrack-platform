output "master_public_ip" {
  value = aws_eip.master.public_ip
}

output "worker_public_ip" {
  value = aws_instance.worker.public_ip
}

# We output the private key so we can save it locally later
output "private_key_pem" {
  value     = tls_private_key.k3s.private_key_pem
  sensitive = true
}
