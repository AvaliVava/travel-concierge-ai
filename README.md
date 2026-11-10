# Travel Concierge AI

An AI-assisted travel concierge project for travellers and people arranging travel
on their behalf. The intended product connects sourced flight and accommodation
research, itineraries, delegated review, and eventually authorized transactions
and post-booking support. These are planned capabilities.

The authoritative source for this foundation task is the
[Foundation Specification v1.0](docs/product-requirements/TRAVEL_CONCIERGE_PROJECT_FOUNDATION_SPEC_v1.0.md).
The owner [approved the initial foundation on 2026-11-10](docs/decisions/2026-11-10-foundation-approval.md).
All 17 open decisions remain unresolved. Implementation and supplier integrations,
production security, infrastructure sizing, and transaction-specific approvals
remain pending; baseline approval does not authorize production operations.

## Current status

Milestone 1: repository foundation; initial baseline approved. The directory structure,
engineering documentation, ignore rules, placeholder environment example, and
local static validation utility are implemented. Verification evidence and its
limits are recorded in the [foundation baseline](docs/engineering-log/FOUNDATION_BASELINE.md).

| Area | Lifecycle status | Evidence / limitation |
| --- | --- | --- |
| Repository foundation | `implemented`; static checks recorded separately | Directories and documentation are not functioning features |
| APIs, web/admin apps, agents, tools, database, identity | `planned` | Structural placeholders only; no application dependencies or services |
| Supplier integrations, approvals, booking, payment, refunds | `planned` | No credentials, provider contracts, or working integrations established |
| Tests, AI evaluations, CI/CD and cloud deployment | `planned` | No application test suites, evaluation datasets, running workflows, or cloud configuration |
| Production capabilities | No `production_ready` capabilities | Release, operational, commercial, and security gates remain outstanding |

Use `planned`, `in_progress`, `implemented`, `verified`, and `production_ready`
truthfully. `verified` requires observed evidence for a specific claim;
`production_ready` requires the release criteria in the specification.

## Architecture and technology direction

A modular monorepo contains separately deployed customer/admin frontends and
three intended backend roles: API, agent worker, and background worker.
Agents recommend and prepare; deterministic domain and security services enforce
permissions, current offers, transaction rules, and reconciliation. PostgreSQL
will own business state; workflow checkpoints will only preserve agent continuity.

| Location | Intended responsibility |
| --- | --- |
| [apps/](apps/) | Customer Next.js app and admin app |
| [services/](services/) | FastAPI API process, AI/agent worker, background worker |
| [packages/](packages/) | Agents, orchestration, LLM access, tools, MCP, provider adapters, domain, security, retrieval, observability, shared contracts |
| [database/](database/) | Models, migrations, repositories, safe seeds |
| [tests/](tests/) / [evaluations/](evaluations/) | Software verification and measured AI quality |
| [infrastructure/](infrastructure/) / [.github/workflows/](.github/workflows/) | Future infrastructure and delivery; placeholders only |
| [docs/](docs/) / [specs/](specs/) | Engineering documentation and future reviewable requirements |
| [automation/](automation/) | Safe development utilities; no provisioning |

Agreed directions include Next.js/React/TypeScript, Python/FastAPI/Pydantic,
LangGraph, controlled MCP plus internal APIs, PostgreSQL/SQLAlchemy/Alembic,
Docker/Compose, Terraform, GitHub Actions, and OpenTelemetry. Provider SDK choices
and optional LiteLLM remain open. AWS services, a PostgreSQL checkpoint saver,
and tracing providers are proposed; Redis is optional and retrieval is deferred.
See the [system overview](docs/architecture/SYSTEM_OVERVIEW.md) for exact statuses.

## Local setup and validation

Use the [local setup guide](docs/development/LOCAL_SETUP.md). There is currently
no application install, build, migration, or run command. No dependencies need to
be installed to inspect this foundation. From the repository in PowerShell:

```powershell
& .\automation\validation\Test-RepositoryFoundation.ps1
git diff --check
git status --short --untracked-files=all
```

The validator checks structure, documentation links, ignore protections, and
common credential patterns using local files and Git. It does not test product
behavior or guarantee that all secrets can be detected. No application tests or
external integration checks have been run.

## Planned sequence

1. Repository foundation and automation.
2. API and local database.
3. Frontend and identity.
4. Core agent orchestration.
5. Travel tools and suppliers.
6. AI quality, safety, and evaluation.
7. Delegation and approval.
8. Sandbox booking and payment.
9. Cloud staging.
10. Operational readiness.
11. Controlled live release.

The specification defines the gates, not a delivery calendar. Exact MVP scope,
providers, transaction design, markets, compliance, performance targets, package
conventions, and release policy remain open. All 17 open items and source
discrepancies appear in [known limitations](docs/limitations/KNOWN_LIMITATIONS.md).

Read [AGENTS.md](AGENTS.md) before substantial agent changes and
[CONTRIBUTING.md](CONTRIBUTING.md) before contributing. The project is private
initially; public release timing and a license remain undecided. Never include
personal traveller information or secrets in documentation, fixtures, or traces.
