# System overview

Source: [Foundation Specification v1.0](../product-requirements/TRAVEL_CONCIERGE_PROJECT_FOUNDATION_SPEC_v1.0.md),
sections 3-8 and 10-11. This is the intended architecture; all application
components are `planned`. Directories are structural placeholders. The owner
[approved the initial foundation on 2026-11-10](../decisions/2026-11-10-foundation-approval.md).
All 17 open decisions remain unresolved. Implementation, supplier integrations,
production security, infrastructure sizing, and transaction-specific approvals
remain pending; this approval does not authorize production operations.

## Boundaries and flow

The modular monorepo has customer/admin frontend deployments and three backend
roles: FastAPI API process, AI/agent worker, and background worker. Packages group
responsibilities without requiring each to be a microservice or a separate LLM.

```text
Customer / admin UI -> authenticated API -> domain + security services
                                |
                         agent worker / LangGraph -> LLM gateway
                                |
                      permitted tool gateway
                       /        |        \
                  MCP tools  internal APIs  supplier adapters

PostgreSQL: authoritative business records; separate workflow checkpoints
Background worker: durable reconciliation, monitoring, notifications
Proposed cloud services: SQS jobs, S3 permitted artifacts, managed runtime/data
Telemetry: structured logs + OpenTelemetry + privacy-reviewed AI traces
```

This is a logical map, not a final network design or a payment sequencing choice.

| Boundary | Intended responsibility |
| --- | --- |
| [apps/web/](../../apps/web/), [apps/admin/](../../apps/admin/) | Customer flows and scoped operational review |
| [services/api/](../../services/api/) | HTTP contracts, middleware, lifecycle, authentication/application entry |
| [services/agent_worker/](../../services/agent_worker/) | Execute bounded agent workflows |
| [services/background_worker/](../../services/background_worker/) | Durable jobs, reconciliation, monitoring, notifications |
| [packages/agents/](../../packages/agents/), [orchestration/](../../packages/orchestration/) | Logical specialists, typed state, routing, interrupts, resumable checkpoints |
| [packages/llm/](../../packages/llm/) | Gateway, provider isolation, prompts, structured outputs, routing/retries, usage |
| [packages/tools/](../../packages/tools/), [mcp/](../../packages/mcp/) | Allowlisted, typed, timed, audited capabilities; direct internal APIs also permitted |
| [packages/integrations/](../../packages/integrations/) | Provider-specific adapters, normalized errors, sandbox separation |
| [packages/domain/](../../packages/domain/) | Traveller/delegation/trip/offer/pricing/approval/booking/payment/refund/accounting/notification rules |
| [packages/security/](../../packages/security/) | Identity, authorization, policies, privacy, audit, input safety |
| [packages/retrieval/](../../packages/retrieval/) | Deferred ingestion, chunking, embeddings, indexing, search, reranking |
| [packages/observability/](../../packages/observability/), [shared/](../../packages/shared/) | Redacted telemetry; shared configuration, errors, schemas, events, identifiers |
| [database/](../../database/) | Business models, migrations, repositories, seeds |
| [tests/](../../tests/), [evaluations/](../../evaluations/) | Software checks and versioned AI evaluations |
| [infrastructure/](../../infrastructure/), [.github/workflows/](../../.github/workflows/) | Future infrastructure/delivery; no active configuration |

All directory levels in specification sections 8/8.1 are retained, including
the additional [automation/](../../automation/) and [specs/](../../specs/) areas.
The source holds the complete target named-file tree. Named Python modules,
Dockerfiles, package manifests, build files, and workflow YAML are deliberately
deferred rather than populated with fake implementations. OPEN-14/17 remain open.

## Agent and tool responsibilities

The base logical specialists are supervisor/router, flight, hotel, weather,
budget, and itinerary. Budget calculations require deterministic validation.
Profile, comparison, booking preparation, documentation/policy, verification,
monitoring, rebooking, and support responsibilities are candidates that may be
combined or handled deterministically. The blueprint's names do not finalize
their deployment. Booking preparation cannot perform supplier writes.

LangGraph is intended to provide typed state/nodes, conditional routing, validated
model/tool inputs, classified failures, checkpoints, human interrupts, and review
loops. External side effects require separate tracking to prevent replayed purchases.

The tool gateway must enforce caller/agent allowlists, authorization, schemas,
rate limits, timeouts, bounded retries, sanitization, and audit. Read capabilities
cover flight/hotel/weather/maps/travel-rule/currency/knowledge research, protected
traveller/booking reads, and deterministic offer/total validation. Approval
requests are scoped domain actions. No tool result confers permissions.

## Business and security invariants

- Agents recommend; deterministic domain and security services authorize and
  execute consequences. Supplier, model, retrieved, MCP, and user inputs are untrusted.
- PostgreSQL owns business truth. Agent checkpoints never determine financial
  truth. Durable booking/payment state machines and exact enums await OPEN-08.
- A purchase requires current offers and specific authenticated approval of
  supplier, traveller, offer, terms, amount/currency, expiry, and constraints.
  Changed material details require renewed approval.
- Track reservation, flight ticket issuance, hotel confirmation, and payment
  authorization/capture/settlement/refund independently. Payment success alone
  cannot establish a confirmed booking.
- Use idempotency, external references, durable jobs, audit, and reconciliation.
  Reconcile timeouts/unknown outcomes before retrying consequential operations.
- Supplier contracts determine ordering, holds, capture, and compensation. Use
  provider-hosted/tokenized payments; never store raw card data.
- Validate webhooks/outbound calls; enforce delegated scope and ownership. Redact
  traveller/payment data before logs, prompts, or third-party traces.
- Live money actions remain disabled until separately authorized and verified.

## Technology disposition (source section 7)

| Technology | Disposition; current implementation |
| --- | --- |
| Next.js, React, TypeScript | Agreed direction; no frontend implementation |
| Python, FastAPI, Pydantic | Agreed direction; no API implementation |
| LangGraph | Agreed direction; no project orchestration configured |
| MCP SDK/adapters and internal APIs | Agreed direction; no tools implemented |
| PostgreSQL, SQLAlchemy, Alembic | Agreed direction; no project database/migrations configured |
| Terraform; Docker/Compose; GitHub Actions | Agreed approaches; no infrastructure, containers, or workflows configured |
| OpenTelemetry + managed telemetry | Agreed direction; backend/privacy settings open |
| Provider SDK; optional LiteLLM | Model/provider/routing/budget open (OPEN-01) |
| LangGraph PostgreSQL saver | Proposed checkpoint mechanism |
| SQS/Python worker, S3 | Proposed cloud jobs/artifacts design |
| ECS Fargate, ECR, load balancing, RDS PostgreSQL | Proposed AWS target; not provisioned |
| IAM, KMS, Secrets Manager, WAF | Proposed AWS security setup |
| Redis | Optional only if needed |
| PostgreSQL full-text, pgvector, reranking | Deferred until retrieval need justified (OPEN-12) |
| OIDC via Cognito/Auth0/Keycloak | Identity approach; provider open (OPEN-02) |
| App roles/policies; optional OPA/Cedar | Authorization design required; engines only if justified |
| Langfuse or LangSmith | Candidates; privacy review required (OPEN-11) |
| pytest and JS/TS testing; AI evaluation harness | Required future verification; JS/TS tool and datasets not chosen/configured |
| Secure payment provider | Open (OPEN-05); no real transactions |

Flights (Duffel/Amadeus), hotels (Booking.com Demand/Expedia Rapid), weather
(OpenWeather/alternative), maps (Google/alternative), requirements (Sherpa/verified
source), search (Tavily/comparable), notifications, and payments remain candidates
or unselected providers. Candidate adapter filenames are illustrative target
locations, not selected contracts or evidence of eligibility.

Kubernetes/EKS, Kafka, Temporal, Ray, vLLM/Triton, MLflow, dedicated vector databases,
feature stores, service mesh, and multi-region deployment are explicitly not
defaults. Require evidence and an ADR before introducing them.

See the [monorepo ADR](../decisions/ADR-0001-monorepo-architecture.md),
[baseline evidence](../engineering-log/FOUNDATION_BASELINE.md), and
[open register](../limitations/KNOWN_LIMITATIONS.md). No benchmark or research
has been conducted by this scaffolding task.
