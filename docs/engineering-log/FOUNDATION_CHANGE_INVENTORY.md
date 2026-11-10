# Foundation file-change inventory

Date: 2026-11-10. Source: [Foundation Specification v1.0](../product-requirements/TRAVEL_CONCIERGE_PROJECT_FOUNDATION_SPEC_v1.0.md).

This inventory describes the uncommitted foundation task. Initial tracked files were the root README and ignore file; the supplied specification was already untracked.

The specification was relocated byte-for-byte from the repository root to its prescribed product-requirements location. This is not a tracked Git rename or a newly authored specification. No original file contents were deleted.

All blueprint directories are represented by documentation, a utility, or an empty leaf placeholder. Target application modules, package/build configuration, Dockerfiles, and executable workflows are deferred.

Total: **119 files** = **116 created**, **2 modified**, **1 existing source relocated unchanged**, **0 content deletions**. Of the created files, **98 are empty .gitkeep placeholders**.

## Git status

`git status --short` returned:

```text
 M .gitignore
 M README.md
?? .env.example
?? .github/
?? AGENTS.md
?? CONTRIBUTING.md
?? apps/
?? automation/
?? database/
?? docs/
?? evaluations/
?? infrastructure/
?? packages/
?? services/
?? specs/
?? tests/
```

Expanded with `--untracked-files=all`: 2 modified tracked files and 117 untracked
files (116 newly created and the existing relocated specification). There are no
staged entries or tracked deletions. Changes are intentionally uncommitted.

## Complete inventory

| Change | File |
| --- | --- |
| Created | [.env.example](../../.env.example) |
| Created | [.github/workflows/README.md](../../.github/workflows/README.md) |
| Modified | [.gitignore](../../.gitignore) |
| Created | [AGENTS.md](../../AGENTS.md) |
| Created | [apps/admin/src/approvals/.gitkeep](../../apps/admin/src/approvals/.gitkeep) |
| Created | [apps/admin/src/bookings/.gitkeep](../../apps/admin/src/bookings/.gitkeep) |
| Created | [apps/admin/src/customers/.gitkeep](../../apps/admin/src/customers/.gitkeep) |
| Created | [apps/admin/src/failed-transactions/.gitkeep](../../apps/admin/src/failed-transactions/.gitkeep) |
| Created | [apps/admin/src/operations/.gitkeep](../../apps/admin/src/operations/.gitkeep) |
| Created | [apps/admin/src/refunds/.gitkeep](../../apps/admin/src/refunds/.gitkeep) |
| Created | [apps/web/src/app/account/.gitkeep](../../apps/web/src/app/account/.gitkeep) |
| Created | [apps/web/src/app/approvals/.gitkeep](../../apps/web/src/app/approvals/.gitkeep) |
| Created | [apps/web/src/app/bookings/.gitkeep](../../apps/web/src/app/bookings/.gitkeep) |
| Created | [apps/web/src/app/checkout/.gitkeep](../../apps/web/src/app/checkout/.gitkeep) |
| Created | [apps/web/src/app/dashboard/.gitkeep](../../apps/web/src/app/dashboard/.gitkeep) |
| Created | [apps/web/src/app/family/.gitkeep](../../apps/web/src/app/family/.gitkeep) |
| Created | [apps/web/src/app/search/.gitkeep](../../apps/web/src/app/search/.gitkeep) |
| Created | [apps/web/src/app/trips/.gitkeep](../../apps/web/src/app/trips/.gitkeep) |
| Created | [apps/web/src/components/.gitkeep](../../apps/web/src/components/.gitkeep) |
| Created | [apps/web/src/features/.gitkeep](../../apps/web/src/features/.gitkeep) |
| Created | [apps/web/src/hooks/.gitkeep](../../apps/web/src/hooks/.gitkeep) |
| Created | [apps/web/src/lib/.gitkeep](../../apps/web/src/lib/.gitkeep) |
| Created | [automation/codegen/.gitkeep](../../automation/codegen/.gitkeep) |
| Created | [automation/README.md](../../automation/README.md) |
| Created | [automation/scaffolding/.gitkeep](../../automation/scaffolding/.gitkeep) |
| Created | [automation/scripts/.gitkeep](../../automation/scripts/.gitkeep) |
| Created | [automation/validation/Test-RepositoryFoundation.ps1](../../automation/validation/Test-RepositoryFoundation.ps1) |
| Created | [CONTRIBUTING.md](../../CONTRIBUTING.md) |
| Created | [database/migrations/.gitkeep](../../database/migrations/.gitkeep) |
| Created | [database/models/.gitkeep](../../database/models/.gitkeep) |
| Created | [database/repositories/.gitkeep](../../database/repositories/.gitkeep) |
| Created | [database/seeds/.gitkeep](../../database/seeds/.gitkeep) |
| Created | [docs/api/.gitkeep](../../docs/api/.gitkeep) |
| Created | [docs/architecture/SYSTEM_OVERVIEW.md](../../docs/architecture/SYSTEM_OVERVIEW.md) |
| Created | [docs/decisions/ADR-0001-monorepo-architecture.md](../../docs/decisions/ADR-0001-monorepo-architecture.md) |
| Created | [docs/development/LOCAL_SETUP.md](../../docs/development/LOCAL_SETUP.md) |
| Created | [docs/engineering-log/FOUNDATION_BASELINE.md](../../docs/engineering-log/FOUNDATION_BASELINE.md) |
| Created | [docs/engineering-log/FOUNDATION_CHANGE_INVENTORY.md](../../docs/engineering-log/FOUNDATION_CHANGE_INVENTORY.md) |
| Created | [docs/incident-response/.gitkeep](../../docs/incident-response/.gitkeep) |
| Created | [docs/limitations/KNOWN_LIMITATIONS.md](../../docs/limitations/KNOWN_LIMITATIONS.md) |
| Created | [docs/product-requirements/PROBLEM_STATEMENT.md](../../docs/product-requirements/PROBLEM_STATEMENT.md) |
| Relocated unchanged (initially untracked) | [docs/product-requirements/TRAVEL_CONCIERGE_PROJECT_FOUNDATION_SPEC_v1.0.md](../../docs/product-requirements/TRAVEL_CONCIERGE_PROJECT_FOUNDATION_SPEC_v1.0.md) |
| Created | [docs/runbooks/.gitkeep](../../docs/runbooks/.gitkeep) |
| Created | [docs/security/.gitkeep](../../docs/security/.gitkeep) |
| Created | [evaluations/approval_safety/.gitkeep](../../evaluations/approval_safety/.gitkeep) |
| Created | [evaluations/datasets/.gitkeep](../../evaluations/datasets/.gitkeep) |
| Created | [evaluations/experiments/.gitkeep](../../evaluations/experiments/.gitkeep) |
| Created | [evaluations/factual_grounding/.gitkeep](../../evaluations/factual_grounding/.gitkeep) |
| Created | [evaluations/guardrails/.gitkeep](../../evaluations/guardrails/.gitkeep) |
| Created | [evaluations/itinerary_quality/.gitkeep](../../evaluations/itinerary_quality/.gitkeep) |
| Created | [evaluations/reports/.gitkeep](../../evaluations/reports/.gitkeep) |
| Created | [evaluations/supervisor/.gitkeep](../../evaluations/supervisor/.gitkeep) |
| Created | [evaluations/tool_selection/.gitkeep](../../evaluations/tool_selection/.gitkeep) |
| Created | [infrastructure/docker/.gitkeep](../../infrastructure/docker/.gitkeep) |
| Created | [infrastructure/monitoring/.gitkeep](../../infrastructure/monitoring/.gitkeep) |
| Created | [infrastructure/scripts/.gitkeep](../../infrastructure/scripts/.gitkeep) |
| Created | [infrastructure/secrets/README.md](../../infrastructure/secrets/README.md) |
| Created | [infrastructure/terraform/environments/dev/.gitkeep](../../infrastructure/terraform/environments/dev/.gitkeep) |
| Created | [infrastructure/terraform/environments/prod/.gitkeep](../../infrastructure/terraform/environments/prod/.gitkeep) |
| Created | [infrastructure/terraform/environments/staging/.gitkeep](../../infrastructure/terraform/environments/staging/.gitkeep) |
| Created | [infrastructure/terraform/modules/.gitkeep](../../infrastructure/terraform/modules/.gitkeep) |
| Created | [packages/agents/.gitkeep](../../packages/agents/.gitkeep) |
| Created | [packages/domain/accounting/.gitkeep](../../packages/domain/accounting/.gitkeep) |
| Created | [packages/domain/approvals/.gitkeep](../../packages/domain/approvals/.gitkeep) |
| Created | [packages/domain/bookings/.gitkeep](../../packages/domain/bookings/.gitkeep) |
| Created | [packages/domain/delegation/.gitkeep](../../packages/domain/delegation/.gitkeep) |
| Created | [packages/domain/notifications/.gitkeep](../../packages/domain/notifications/.gitkeep) |
| Created | [packages/domain/offers/.gitkeep](../../packages/domain/offers/.gitkeep) |
| Created | [packages/domain/payments/.gitkeep](../../packages/domain/payments/.gitkeep) |
| Created | [packages/domain/pricing/.gitkeep](../../packages/domain/pricing/.gitkeep) |
| Created | [packages/domain/refunds/.gitkeep](../../packages/domain/refunds/.gitkeep) |
| Created | [packages/domain/travellers/.gitkeep](../../packages/domain/travellers/.gitkeep) |
| Created | [packages/domain/trips/.gitkeep](../../packages/domain/trips/.gitkeep) |
| Created | [packages/integrations/flights/.gitkeep](../../packages/integrations/flights/.gitkeep) |
| Created | [packages/integrations/hotels/.gitkeep](../../packages/integrations/hotels/.gitkeep) |
| Created | [packages/integrations/maps/.gitkeep](../../packages/integrations/maps/.gitkeep) |
| Created | [packages/integrations/messaging/.gitkeep](../../packages/integrations/messaging/.gitkeep) |
| Created | [packages/integrations/payments/.gitkeep](../../packages/integrations/payments/.gitkeep) |
| Created | [packages/integrations/travel_requirements/.gitkeep](../../packages/integrations/travel_requirements/.gitkeep) |
| Created | [packages/integrations/weather/.gitkeep](../../packages/integrations/weather/.gitkeep) |
| Created | [packages/llm/prompts/.gitkeep](../../packages/llm/prompts/.gitkeep) |
| Created | [packages/llm/providers/.gitkeep](../../packages/llm/providers/.gitkeep) |
| Created | [packages/llm/structured_outputs/.gitkeep](../../packages/llm/structured_outputs/.gitkeep) |
| Created | [packages/mcp/clients/.gitkeep](../../packages/mcp/clients/.gitkeep) |
| Created | [packages/mcp/servers/travel_knowledge/.gitkeep](../../packages/mcp/servers/travel_knowledge/.gitkeep) |
| Created | [packages/mcp/servers/travel_search/.gitkeep](../../packages/mcp/servers/travel_search/.gitkeep) |
| Created | [packages/mcp/servers/weather/.gitkeep](../../packages/mcp/servers/weather/.gitkeep) |
| Created | [packages/mcp/transports/.gitkeep](../../packages/mcp/transports/.gitkeep) |
| Created | [packages/observability/.gitkeep](../../packages/observability/.gitkeep) |
| Created | [packages/orchestration/graphs/.gitkeep](../../packages/orchestration/graphs/.gitkeep) |
| Created | [packages/orchestration/states/.gitkeep](../../packages/orchestration/states/.gitkeep) |
| Created | [packages/retrieval/chunking/.gitkeep](../../packages/retrieval/chunking/.gitkeep) |
| Created | [packages/retrieval/embeddings/.gitkeep](../../packages/retrieval/embeddings/.gitkeep) |
| Created | [packages/retrieval/indexes/.gitkeep](../../packages/retrieval/indexes/.gitkeep) |
| Created | [packages/retrieval/ingestion/.gitkeep](../../packages/retrieval/ingestion/.gitkeep) |
| Created | [packages/retrieval/reranking/.gitkeep](../../packages/retrieval/reranking/.gitkeep) |
| Created | [packages/retrieval/search/.gitkeep](../../packages/retrieval/search/.gitkeep) |
| Created | [packages/security/policies/.gitkeep](../../packages/security/policies/.gitkeep) |
| Created | [packages/shared/events/.gitkeep](../../packages/shared/events/.gitkeep) |
| Created | [packages/shared/schemas/.gitkeep](../../packages/shared/schemas/.gitkeep) |
| Created | [packages/tools/schemas/.gitkeep](../../packages/tools/schemas/.gitkeep) |
| Modified | [README.md](../../README.md) |
| Created | [services/agent_worker/.gitkeep](../../services/agent_worker/.gitkeep) |
| Created | [services/api/app/api/v1/.gitkeep](../../services/api/app/api/v1/.gitkeep) |
| Created | [services/api/app/middleware/.gitkeep](../../services/api/app/middleware/.gitkeep) |
| Created | [services/background_worker/jobs/.gitkeep](../../services/background_worker/jobs/.gitkeep) |
| Created | [specs/acceptance-criteria/README.md](../../specs/acceptance-criteria/README.md) |
| Created | [specs/api-contracts/README.md](../../specs/api-contracts/README.md) |
| Created | [specs/data-contracts/README.md](../../specs/data-contracts/README.md) |
| Created | [specs/features/README.md](../../specs/features/README.md) |
| Created | [tests/concurrency/.gitkeep](../../tests/concurrency/.gitkeep) |
| Created | [tests/contract/.gitkeep](../../tests/contract/.gitkeep) |
| Created | [tests/e2e/.gitkeep](../../tests/e2e/.gitkeep) |
| Created | [tests/fixtures/.gitkeep](../../tests/fixtures/.gitkeep) |
| Created | [tests/integration/.gitkeep](../../tests/integration/.gitkeep) |
| Created | [tests/load/.gitkeep](../../tests/load/.gitkeep) |
| Created | [tests/resilience/.gitkeep](../../tests/resilience/.gitkeep) |
| Created | [tests/security/.gitkeep](../../tests/security/.gitkeep) |
| Created | [tests/unit/.gitkeep](../../tests/unit/.gitkeep) |
