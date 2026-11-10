# Future delivery workflows

Source: [Foundation Specification v1.0](../../docs/product-requirements/TRAVEL_CONCIERGE_PROJECT_FOUNDATION_SPEC_v1.0.md),
sections 8/8.1, 11-15. Placeholder only; there are no runnable workflows.

The target names are `ci.yml`, `security.yml`, `evaluations.yml`,
`deploy-staging.yml`, `deploy-production.yml`, and `dependency-updates.yml`.
They are intentionally absent until real checks, package/build conventions, and
release gates are designed (OPEN-14/17). GitHub Actions is the agreed approach;
no successful CI, deployment, security scan, or evaluation is claimed.

Future cloud access should use short-lived OIDC credentials. Production approval,
cloud costs, and financial operations require explicit owner authorization.
