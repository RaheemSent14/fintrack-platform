# ADR-005: Omitting NAT Gateway for Cost Savings

**Date:** 2026-06-05
**Status:** Accepted

## Context
Standard enterprise architectures place worker nodes in Private Subnets. To allow these nodes to download updates or Docker images, a NAT Gateway is deployed in the Public Subnet to route outbound traffic safely.

## Decision
We are explicitly omitting the NAT Gateway and deploying our k3s worker nodes directly into Public Subnets.

## Consequences
- **Positive (FinOps):** Saves ~$32/month. This is mandatory to keep the portfolio project within our $50/month hard constraint.
- **Negative (SecOps):** The worker nodes have public IP addresses, making them theoretically reachable from the internet.
- **Mitigation:** We rely entirely on aggressive Security Groups. The worker SG drops all inbound traffic globally (`0.0.0.0/0`) and only accepts internal cluster traffic from the master node SG.
- **Future State:** If FinTrack scales and acquires a larger cloud budget or regulatory compliance requirements (e.g., PCI-DSS), a NAT Gateway must be retrofitted immediately.
