# ADR-006: Forced Adoption of t3.micro for Free Tier Compliance

**Date:** 2026-06-05
**Status:** Accepted

## Context
The initial architectural design specified `t2.micro` instances for the Kubernetes control plane and worker nodes to comply with the AWS Free Tier. During deployment, the AWS API rejected the `t2.micro` instance type (`InvalidParameterCombination`). AWS is actively phasing out `t2` hardware in specific regions and has mapped the 750-hour monthly Free Tier allocation to `t3.micro`.

## Decision
We updated the compute module to provision `t3.micro` instances to successfully deploy the cluster while maintaining a $0 compute footprint.

## Consequences
- **Positive:** Infrastructure deploys successfully. We benefit from the newer AWS Nitro System architecture and better burstable CPU performance at no extra cost.
- **Negative:** None, provided the specific AWS account aligns with the updated `t3` Free Tier policy.
