# ADR-004: Modular Terraform Architecture

**Date:** 2026-06-05
**Status:** Accepted

## Context
As FinTrack grows, we will need multiple environments (staging, production, disaster recovery). If we write all Terraform code in a single `main.tf` file, duplicating an environment requires copying thousands of lines of code, leading to configuration drift.

## Decision
We will use a Modular Terraform approach. Core infrastructure (Networking, Compute, Security) will be written as reusable, parameter-driven modules in `terraform/modules/`. Environments in `terraform/environments/` will simply call these modules and pass specific variables.

## Consequences
- **Positive:** Maximum reusability. Strict parity between staging and production. Easier unit testing of individual components.
- **Negative:** Slightly steeper learning curve to trace variables as they pass from the root environment down into the modules.
