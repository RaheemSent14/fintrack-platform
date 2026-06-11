# ══════════════════════════════════════════════════════════
# WHAT:      Root outputs for the production environment.
# WHY:       Exposes critical connection information for post-deployment configuration (Ansible).
# ══════════════════════════════════════════════════════════

output "fintrack_master_ip" {
  value = module.compute.master_public_ip
}

output "fintrack_worker_ip" {
  value = module.compute.worker_public_ip
}

output "fintrack_k3s_private_key" {
  value     = module.compute.private_key_pem
  sensitive = true
}
