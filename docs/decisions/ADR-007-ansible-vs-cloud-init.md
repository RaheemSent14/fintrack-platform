# ADR-007: Ansible vs. EC2 User-Data (Cloud-Init)

## Status
Proposed

## Context
We needed a way to configure our k3s cluster nodes (OS hardening, software installation). We evaluated using EC2 `user_data` (cloud-init) versus Ansible.

## Decision
We have chosen **Ansible** for configuration management over EC2 user-data.

## Rationale
1. **Idempotency:** Cloud-init runs once at boot. Ansible can be run repeatedly to enforce state (e.g., if a file is tampered with, Ansible fixes it).
2. **Observability:** Ansible provides detailed logs/output for every task. Cloud-init logs are harder to centralize.
3. **Debuggability:** We can run Ansible locally on a dev machine to test configurations before applying to production. Testing `user_data` requires destroying and recreating EC2 instances, which is slow and expensive.

## Consequences
- **Pros:** Full control, better security posture, easier to audit.
- **Cons:** Added complexity of maintaining a separate configuration repository.
