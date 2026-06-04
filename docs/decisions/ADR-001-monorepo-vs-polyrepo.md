# ADR-001: Use Monorepo Architecture for FinTrack

**Date:** 2026-06-03
**Status:** Accepted

## Context
FinTrack has a 3-person engineering team. We need a repository structure that minimizes operational overhead while keeping infrastructure (Terraform) and application code synchronized.

## Decision
We will use a Monorepo containing all application source code, infrastructure, configuration management, and Kubernetes manifests.

## Consequences
- **Positive:** Atomic commits (we can update an app feature and its required AWS infrastructure in a single PR). Single CI/CD pipeline to maintain. Easier dependency tracking.
- **Negative:** The repository will grow large over time. Strict path-based filtering in GitHub Actions is required to avoid running Terraform checks when only the README changes.

## Alternatives Considered
- **Polyrepo (separate repos for app, infra, frontend):** Rejected due to the management overhead of coordinating PRs across multiple repositories for a small team.
