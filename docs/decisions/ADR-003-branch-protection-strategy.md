# ADR-003: Branch Protection Rules for main and develop

**Date:** 2026-06-03
**Status:** Accepted

## Context
Direct commits to production branches bypass security scanning, peer review, and automated testing, directly threatening our 99.9% SLO.

## Decision
We will enforce GitHub Branch Protection on `main` and `develop`.

**Required GitHub UI Configuration:**
1. **Require pull request reviews before merging:** Minimum 1 approval.
2. **Require status checks to pass:** CI pipelines must turn green before the merge button unlocks.
3. **Require branches to be up to date:** Prevents merging stale code that conflicts with recent commits.
4. **Do not allow bypassing:** Admin privileges cannot override these rules.

## Consequences
- **Positive:** Zero unreviewed code reaches production. Enforces an audit trail.
- **Negative:** Emergency hotfixes take slightly longer to deploy because they must pass CI.
