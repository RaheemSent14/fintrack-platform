# ADR-002: GitFlow Branching Strategy

**Date:** 2026-06-03
**Status:** Accepted

## Context
We need a branching strategy that protects production while allowing features to be built and tested asynchronously.

## Decision
We will adopt a strict GitFlow model. `main` is production. `develop` is integration. All work happens in `feature/*` branches.

## Consequences
- **Positive:** Clear environment promotion (`develop` -> `main`). Strict separation between work-in-progress and production-ready code.
- **Negative:** Slower time-to-market compared to Trunk-Based Development due to PR overhead.

## Alternatives Considered
- **Trunk-Based Development:** Rejected. While highly effective for mature, high-velocity teams with robust automated testing, our current CI/CD maturity requires manual gates before hitting production.
