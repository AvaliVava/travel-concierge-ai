# AI Travel Concierge — Project Foundation Specification

**Document ID:** TC-FOUNDATION-001
**Version:** 1.0 — APPROVED INITIAL FOUNDATION
**Date:** 2026-11-10
**Repository:** `AvaliVava/travel-concierge-ai`
**Foundation branch:** `setup/repository-foundation`
**Status:** Approved by the owner on 2026-11-10 as the initial product and engineering baseline for subsequent phased development. See the [dated approval record](../decisions/2026-11-10-foundation-approval.md).
**Scope:** Product intent, architectural direction, development standards, and repository foundation. This is **not** a claim of implementation or production readiness.

## 0. How this document must be used

This specification consolidates decisions and design directions established during the project's planning discussions. It is the **approved initial baseline for subsequent phased development**, within the scope and exclusions of the dated approval record. Codex must not infer or invent decisions that are absent here.

**Status vocabulary:**

- **Agreed direction:** Discussed and selected as the intended starting approach, but not automatically implemented.
- **Candidate / proposed:** A reasonable intended option, not a finalized provider or commitment.
- **Deferred:** Known future capability intentionally excluded from the initial implementation.
- **Open decision:** Requires future selection or evidence.
- **Verified:** Supported by actual observed setup output or tests. Evidence is scoped to what was observed.

**Evidence rule:** Never equate a folder, dependency, configuration, screenshot, draft, or successful unit test with full functioning production capability. Every feature must have a truthful lifecycle status: `planned`, `in_progress`, `implemented`, `verified`, `production_ready` (only after release criteria). Documentation must distinguish these states.

**Priority on conflicts:** (1) explicit subsequent product-owner decisions; (2) this reviewed-and-approved foundation; (3) dated ADRs/feature specifications; (4) implementation evidence and test reports. When documents conflict, **report the discrepancy and request a decision**; do not silently resolve it. No part of this specification overrides later approved changes.

## 1. Executive summary and problem

### 1.1 Real-world starting problem

A traveller may rely on a family member to organize flights, accommodations, and payment arrangements. One person may be the **traveller**, another the **organizer/approver**, and another the **payer**. Traditional travel-planning demos commonly stop at itinerary recommendations, while actual travel requires comparing genuine inventory, understanding conditions, securing authorization, arranging purchase, confirming supplier reservations, and supporting the traveller afterward.

The motivating example is a family member arranging a mother's flight and hotel booking, potentially after receiving funds. This is a **problem illustration**, not authorization to process personal funds or data.

### 1.2 Product vision

Develop an **AI-assisted Travel Concierge and Booking Platform** supporting trip research, actual supplier-backed flight and accommodation comparisons, itinerary preparation, delegated permissions/approvals, safely authorized booking and payment transactions, confirmation verification, and post-booking assistance.

The system must keep intelligence and transaction authority separate. **AI agents recommend and prepare; deterministic services validate permissions, prices, payment states, booking execution and reconciliation.**

### 1.3 Intended users and roles

- Individual travellers planning their own trips.
- Family members arranging travel on behalf of other people.
- Authorized personal assistants or coordinators.
- Later: business travellers, travel managers, finance approvers, support and operations teams, and potentially authorized travel-agency personnel.

Roles are **not interchangeable**:

- **Traveller:** person who travels; may supply passenger details and preferences.
- **Requester / organizer:** initiates and prepares arrangements.
- **Approver:** authorizes a specifically scoped proposal or purchase.
- **Payer:** funds a transaction through an authorized payment mechanism.
- **Operations/reviewer:** handles exceptions under tightly scoped administrative permissions.

One person can hold several roles; roles must be evaluated against authenticated identity, resource ownership, and delegation scope.

### 1.4 Goals

1. Offer useful AI-assisted travel discovery and comparison grounded in verified external data.
2. Make traveller and family-member coordination simpler with explicit delegated access.
3. Permit real reservations and payments only after approvals, supplier access, and transaction safety controls are implemented and verified.
4. Build a maintainable, testable, secure and observable system whose engineering decisions can be inspected externally.
5. Use AI coding assistance for repetitive work without outsourcing architectural decisions or evidence standards.

### 1.5 Not goals / boundaries

- **Not** an autonomous purchasing agent allowed to spend without authorization.
- **Not** a promise of immediate airline ticketing or hotel inventory access; supplier contracts and eligibility are external dependencies.
- **Not** a full airline distribution or payment processor built from scratch.
- **Not** a requirement to run every proposed technology in the first prototype.
- **Not** an assumption that every responsibility requires a separate LLM agent, MCP server, or deployable microservice.
- **Not** permission to handle real customers' passports or money during early development; mocks and sandbox data come first.

## 2. Functional scope and development sequencing

### 2.1 Information and planning capabilities — initial product direction

- Capture trip origin, destination, dates, number of travellers, budget, travel style, and constraints.
- Search/compare flights and accommodations using permitted sources (mock data first; supplier APIs when access is available).
- Retrieve weather and relevant contextual information where useful.
- Compare options with source/offer identifiers, timestamps, currency, fees, availability, baggage and cancellation conditions where supported.
- Prepare human-readable itineraries with clearly distinguished sourced facts versus estimates.
- Preserve drafts, workflow checkpoints, and user feedback.
- Track evaluation quality and model/tool costs.

### 2.2 Delegation and approval — added product scope

- Define account ownership, traveller records, organizer permissions and payer/approver roles.
- Explicit invitation and acceptance of delegation; narrow scope, expiry, revocation and auditability.
- Prepare purchase proposals with **exact offers, parties, amounts, currency, conditions and expiry**.
- Require an authorized person to approve a current purchase proposal before any consequential supplier action.
- Re-approval when price, terms, supplier, traveller, or significant details change; reject and revise flows must produce a new reviewable proposal.

### 2.3 Booking and commerce — later controlled stage

- Price/availability refresh before checkout and booking.
- Supplier-specific order placement via approved integrations, using idempotency and explicit outcome reconciliation.
- Payment initiation, provider-confirmed payment state, capture/settlement handling as provider flow permits.
- Durable booking/payment state machines independent of AI checkpoints.
- Partial success, uncertain outcomes, retries, compensation/refunds and manual review cases.
- Confirm actual ticket issuance and hotel reservation independently; never report booking as complete solely because payment succeeded.
- Notification with confirmed references and permitted travel documents.

### 2.4 Post-booking operations — later stage

- Flight/itinerary change monitoring using scheduled checks or supplier notifications.
- Disruption alerts, customer support and rebooking research.
- Approved cancellation/refund execution through deterministic business services.
- Operational review queue for exceptional financial/supplier states.

### 2.5 Release stages

| Stage | Intended outcome | Exclusions/constraints |
|---|---|---|
| First usable research release | Authenticated trip requests, verified or explicitly mocked offers, itineraries, delegated plan reviews and safe checkout previews/redirects where available | No unapproved purchases or claims of direct ticketing |
| Controlled transaction release | Supplier-authorized direct bookings, payment orchestration, independent confirmations, reconciliation and refund handling | Sandbox and operational acceptance criteria before live funds |
| Expanded operations | Monitoring, supported changes, corporate policies, support and rebooking assistance | Each capability gated by supplier APIs, cost and verification |

## 3. System design principles

1. **Modular monorepo first.** One repository, clear code ownership and interfaces; do not prematurely split every bounded context into microservices.
2. **Three backend deployable roles at the outset:** FastAPI API process, AI/agent worker, background worker. Frontend applications deploy separately. This is a design direction, not yet implemented.
3. **Consequence separation.** Agents reason; tools expose bounded capabilities; integrations communicate with providers; business domain services enforce money/booking rules; security policy gates all actions.
4. **Trust boundaries.** All user input, model output, retrieved content, supplier responses and MCP tool results are untrusted until validated for their intended use.
5. **Authoritative stores.** PostgreSQL records business state. LangGraph checkpoints record agent workflow continuity, **not** financial truth.
6. **Durability and replay safety.** Background jobs can be retried; anything involving payment or supplier orders must be idempotent or reconciliation-first.
7. **Evidence over claims.** Test, evaluate, measure and document real results before assigning readiness labels.
8. **Least privilege.** Agents cannot grant themselves financial access; user identity and permissions are enforced by application services.
9. **Complexity on evidence.** Dedicated Kafka, Kubernetes, Temporal, Ray, dedicated vector databases etc. only if scale or requirements justify them.
10. **Cost and privacy by design.** Prefer local mocks first; keep identifiable/passenger/payment data out of unnecessary logs and third-party AI traces.

### 3.1 Illustrative logical flow

```text
Customer Next.js app / Admin app
       |
Auth/OIDC -> API entry -> FastAPI application
       |                     |
       |             Domain + Security services
       |                     |
       +--> Agent worker / LangGraph orchestration
                  |       |         |
             Specialist agents   LLM gateway
                  |
           Allowed Tool Gateway
             |       |        |
         MCP tools  Internal API  Supplier adapters
             |                    |
         Weather/maps          Flights / Hotels

PostgreSQL: business records + separate workflow checkpoints
SQS + background worker: reconciliation, status checks, notifications
S3: permitted artifacts and documents
OpenTelemetry + AI tracing: monitoring and evaluation (with redaction)

Purchase path: current offer -> authorization -> payment/booking
orchestration -> verify supplier and payment outcomes -> reconcile
-> notify or surface exception for manual review.
```

This is a conceptual component map, not the final network diagram or a guarantee of provider integration order. Payment/supplier sequencing depends on partner requirements.

## 4. Agent responsibilities and orchestration

Agents are **logical units of responsibility**; they need not all be separate model instances, processes or even LLM-based components.

### 4.1 Base agent responsibilities

| Logical component | Responsibility |
|---|---|
| Supervisor / router | Assess request and select permitted specialist work; no independent purchase authority |
| Flight agent | Research routes, flights, fares and conditions using approved inventory tools |
| Hotel agent | Research rooms, rates, locations and cancellation terms |
| Weather agent | Retrieve relevant current/forecast climate data |
| Budget agent | Analyse whether combined choices meet the stated budget; computations validated deterministically |
| Itinerary agent | Integrate verified options into a coherent draft |

### 4.2 Additional candidate responsibilities

| Logical component | Responsibility | Initial deployment decision |
|---|---|---|
| Traveller profile helper | Gather preferences and missing passenger information | May be deterministic forms/service rather than an agent |
| Comparison agent | Explain trade-offs among flight + hotel options | Combine with other agents if appropriate |
| Booking preparation agent | Construct purchase proposal and identify missing data | Research/preparation only; no supplier write |
| Travel policy/documentation helper | Explain policy and entry requirements from verified sources | Source provenance and freshness required |
| Verification agent | Check recommendations against offer IDs, prices and source evidence | Guard against presenting unsupported facts |
| Monitoring agent | Interpret disruptions and propose actions | Scheduled/provider event monitoring is primarily deterministic |
| Rebooking assistant | Research alternatives after disruption | User must approve actual changes |
| Support agent | Explain booking status, supplier conditions and next actions | Must not invent confirmations or refunds |

### 4.3 LangGraph responsibilities

- Typed graph state, explicit nodes and conditional routing.
- Model/tool and input validation with bounded, classified failures.
- Persisted checkpoints and resumable human-in-the-loop interrupts.
- Revision loops that return revised proposals for review where required.
- Separate tracking of external side effects to prevent duplicate purchases on replay.
- No implicit inheritance of user permissions by models or tool results.

## 5. Tool services, MCP and integrations

### 5.1 Tool gateway responsibilities

- Allowlisted tools per agent and authenticated caller.
- Typed input/output contracts, rate limiting, timeouts, retries and sanitization.
- Context-aware authorization before access to personally identifiable data.
- Auditable calls and sanitized traces; no leaking credentials to models.
- Normalized provider results and error classes.
- Support direct internal functions/APIs alongside MCP; **MCP is not mandatory for every tool**.

### 5.2 Planned logical tool groups

| Tool group | Example interface (illustrative) | Mode |
|---|---|---|
| Flights | `search_flights`, `get_fare_rules`, `refresh_flight_offer` | Read-only to agents |
| Flight status | `get_flight_status`, `get_schedule_changes` | Read-only |
| Hotels | `search_hotels`, `get_room_rates`, `get_cancellation_policy` | Read-only |
| Weather | `get_forecast`, `get_weather_alerts` | Read-only |
| Maps | `geocode`, `estimate_travel_time`, `search_places` | Read-only |
| Travel requirements | `get_entry_rules`, `get_visa_requirements` | Read-only, source verified |
| Currency | `get_exchange_rate`, `convert_currency` | Deterministic conversion based on sourced rate |
| Knowledge | `search_travel_documents`, `retrieve_policy` | Retrieval with source metadata |
| Traveller profile | `get_travel_preferences` | Protected read with delegated permission checks |
| Bookings | `get_booking_status`, `get_ticket_details` | Protected read |
| Offer validation | `validate_offer`, `calculate_checkout_total` | Deterministic domain logic |
| Approval request | `create_approval_request` | Scope-checked domain action |

### 5.3 Privileged actions not exposed as unguarded agent tools

`create_booking`, `initiate_payment`, `cancel_booking`, `request_refund`, and equivalent supplier write actions are initiated only by deterministic transaction services after enforcing fresh-offer validation, authenticated authority, explicit consent, idempotency, and audit requirements. Assistants may **propose** such actions but cannot self-authorize them.

### 5.4 External provider candidates — NOT selected contracts

- **Flights:** Duffel, Amadeus (API eligibility and ticketing/settlement arrangements to verify).
- **Accommodation:** Booking.com Demand API or Expedia Rapid (partner access to verify).
- **Weather:** OpenWeather or other suitable provider.
- **Maps/location:** Google Maps Platform or alternative.
- **Travel requirements:** Sherpa or appropriate verified source.
- **Search:** Tavily or comparable service.
- **Notifications:** email/SMS provider to be selected.
- **Payments:** supported card processor and possibly M-Pesa-compatible flow; provider **not selected**.

Adapters must be isolated behind stable interfaces, use vendor-specific sandbox credentials and normalize supplier errors. Never fabricate live inventory from general web search and present it as bookable.

## 6. Booking, delegation and financial guarantees

1. Traveller, organizer, approver and payer are distinct principal roles; all actions require appropriate scope and resource ownership checks.
2. Approval relates to **a concrete purchase proposal**, including supplier, traveller, offer, terms, total price/currency, expiry, and any constraints. Price changes require appropriate renewed consent.
3. Implement booking and payment state machines separate from agent state. Example booking lifecycle: `draft -> awaiting_approval -> approved -> purchase_in_progress -> confirmed | partial | review_required`, plus distinct cancellation/refund states. Actual enums await transaction design.
4. Independently track supplier reservation, ticket issuance (for flights), accommodation confirmation, and payment authorization/capture/settlement/refund.
5. Treat external timeouts and unknown outcomes as **uncertain**, not automatically failed. Reconcile before retrying actions that might duplicate a purchase.
6. Use idempotency keys, external references, invariant checks, durable jobs and auditable transitions.
7. Implement provider-specific payment-before-booking, hold-and-capture, pre-funded settlement or other sequences only after validating supplier contracts.
8. Customer payment data should be handled through approved provider-hosted/tokenized mechanisms; do not store raw card data.
9. Sensitive data minimization, deletion/retention requirements, and legal/commercial travel obligations remain to be researched before live operation.
10. Real-money booking, payment or refunds are **disabled until separately approved and verified**.

## 7. Proposed reference stack and status

| Layer | Proposed technology | Responsibility | Status |
|---|---|---|---|
| Customer and admin UI | Next.js, React, TypeScript | Traveller interface, admin operations | Agreed direction; Node.js locally verified |
| Backend APIs | Python, FastAPI, Pydantic | HTTP contracts, validation, application services | Agreed direction; Python locally verified |
| Agent orchestration | LangGraph | Stateful graph, routing, interrupts, checkpoints | Agreed direction; not installed for project |
| LLM access | Provider SDK, optional LiteLLM | Central gateway, prompts, cost, routing | Provider/model open |
| Agent tools | MCP SDK/adapters plus internal APIs | Controlled external and internal capabilities | Agreed direction; implementations pending |
| Business database | PostgreSQL, SQLAlchemy, Alembic | Authoritative transactions, migrations, persistence | Agreed direction; project DB not configured |
| Agent checkpoints | LangGraph PostgreSQL saver | Durable agent-state persistence | Proposed |
| Background jobs | Amazon SQS + Python worker | Reconciliation, notifications, monitoring | Proposed cloud design |
| File/artifact storage | Amazon S3 | Permitted files, reports and artifacts | Proposed cloud design |
| Cache (only if needed) | Redis | Caching/coordination | Optional |
| Retrieval/RAG | PostgreSQL full-text, pgvector, reranking | Grounded policy/document retrieval | Deferred until justified |
| Cloud runtime | AWS ECS Fargate, ECR, load balancing | Container deployment | Proposed target, not provisioned |
| Managed production DB | Amazon RDS PostgreSQL | Production data | Proposed |
| Infrastructure as code | Terraform | Reproducible AWS provisioning | Agreed approach, not configured |
| Containers | Docker, Docker Compose | Reproducible local/dev packages | Docker locally verified |
| CI/CD | GitHub Actions | Build, test, scan, evaluate, deploy | Agreed approach; workflows not created |
| AuthN | OIDC via Cognito/Auth0/Keycloak | Login, identity, sessions | Provider open |
| AuthZ | App roles and policies; OPA/Cedar if justified | Delegation, policy enforcement | Design required |
| Security | IAM, KMS, Secrets Manager, WAF | Least privilege and secrets | Proposed AWS setup |
| Observability | OpenTelemetry + managed telemetry | Traces, metrics, logs | Agreed direction; backend selection open |
| AI observability | Langfuse (or LangSmith) | Prompt, agent and tool traces, evaluations | Candidate; privacy review required |
| Tests | pytest and JS/TS tooling | Unit, contract, integration, e2e, security | Required; not created |
| AI evaluations | Custom harness, optional specialist tools | Routing, factuality, grounding, policy and quality | Required; datasets pending |
| Payment | Approved provider and secure checkout | Payment processing | Provider open; no real transactions |

**Explicitly optional / not default:** Kubernetes/EKS, Kafka, Temporal, Ray, vLLM/Triton, MLflow, dedicated vector DB, feature store, service mesh and multi-region deployment. Introduce only with evidence and an ADR.

## 8. Approved target-state repository blueprint

This tree preserves the complete directory-level and named-file architecture agreed for the target product. The tree is **not** evidence those files already exist. Empty directories need not be committed until required; for the foundation task use lightweight READMEs / `.gitkeep` selectively.

```text
travel-concierge-ai/
│
├── apps/
│   ├── web/                         # Customer-facing Next.js app
│   │   ├── src/
│   │   │   ├── app/
│   │   │   │   ├── dashboard/
│   │   │   │   ├── trips/
│   │   │   │   ├── search/
│   │   │   │   ├── bookings/
│   │   │   │   ├── checkout/
│   │   │   │   ├── approvals/
│   │   │   │   ├── family/
│   │   │   │   └── account/
│   │   │   ├── components/
│   │   │   ├── features/
│   │   │   ├── hooks/
│   │   │   └── lib/
│   │   └── package.json
│   └── admin/
│       ├── src/
│       │   ├── bookings/
│       │   ├── failed-transactions/
│       │   ├── approvals/
│       │   ├── refunds/
│       │   ├── customers/
│       │   └── operations/
│       └── package.json
│
├── services/
│   ├── api/
│   │   ├── app/
│   │   │   ├── main.py
│   │   │   ├── api/
│   │   │   │   ├── v1/
│   │   │   │   │   ├── auth.py
│   │   │   │   │   ├── travellers.py
│   │   │   │   │   ├── trips.py
│   │   │   │   │   ├── searches.py
│   │   │   │   │   ├── approvals.py
│   │   │   │   │   ├── bookings.py
│   │   │   │   │   ├── payments.py
│   │   │   │   │   ├── refunds.py
│   │   │   │   │   └── webhooks.py
│   │   │   │   └── dependencies.py
│   │   │   ├── middleware/
│   │   │   └── lifespan.py
│   │   └── Dockerfile
│   ├── agent_worker/
│   │   ├── main.py
│   │   └── Dockerfile
│   └── background_worker/
│       ├── main.py
│       ├── jobs/
│       │   ├── booking_reconciliation.py
│       │   ├── flight_monitoring.py
│       │   ├── payment_reconciliation.py
│       │   └── notifications.py
│       └── Dockerfile
│
├── packages/
│   ├── agents/
│   │   ├── supervisor.py
│   │   ├── flight_agent.py
│   │   ├── hotel_agent.py
│   │   ├── weather_agent.py
│   │   ├── budget_agent.py
│   │   ├── itinerary_agent.py
│   │   ├── comparison_agent.py
│   │   ├── documentation_agent.py
│   │   ├── booking_preparation_agent.py
│   │   ├── verification_agent.py
│   │   ├── monitoring_agent.py
│   │   └── support_agent.py
│   ├── orchestration/
│   │   ├── graphs/
│   │   │   ├── planning_graph.py
│   │   │   ├── approval_graph.py
│   │   │   └── support_graph.py
│   │   ├── states/
│   │   │   ├── trip_state.py
│   │   │   └── support_state.py
│   │   ├── routing.py
│   │   ├── checkpoints.py
│   │   └── interrupts.py
│   ├── llm/
│   │   ├── gateway.py
│   │   ├── providers/
│   │   ├── structured_outputs/
│   │   ├── prompts/
│   │   ├── routing.py
│   │   ├── retries.py
│   │   └── usage_tracking.py
│   ├── tools/
│   │   ├── registry.py
│   │   ├── permissions.py
│   │   ├── executor.py
│   │   ├── schemas/
│   │   ├── flight_tools.py
│   │   ├── hotel_tools.py
│   │   ├── weather_tools.py
│   │   ├── maps_tools.py
│   │   ├── currency_tools.py
│   │   ├── travel_rules_tools.py
│   │   └── knowledge_tools.py
│   ├── mcp/
│   │   ├── clients/
│   │   ├── servers/
│   │   │   ├── travel_search/
│   │   │   ├── weather/
│   │   │   └── travel_knowledge/
│   │   ├── transports/
│   │   └── config.py
│   ├── integrations/
│   │   ├── flights/
│   │   │   ├── base.py
│   │   │   ├── duffel_adapter.py
│   │   │   └── amadeus_adapter.py
│   │   ├── hotels/
│   │   │   ├── base.py
│   │   │   └── booking_adapter.py
│   │   ├── payments/
│   │   │   ├── base.py
│   │   │   ├── card_adapter.py
│   │   │   └── mpesa_adapter.py
│   │   ├── weather/
│   │   ├── maps/
│   │   ├── messaging/
│   │   └── travel_requirements/
│   ├── domain/
│   │   ├── travellers/
│   │   ├── delegation/
│   │   ├── trips/
│   │   ├── offers/
│   │   ├── pricing/
│   │   ├── approvals/
│   │   ├── bookings/
│   │   ├── payments/
│   │   ├── refunds/
│   │   ├── accounting/
│   │   └── notifications/
│   ├── security/
│   │   ├── identity.py
│   │   ├── authorization.py
│   │   ├── policies/
│   │   ├── pii_protection.py
│   │   ├── audit.py
│   │   └── input_safety.py
│   ├── retrieval/
│   │   ├── ingestion/
│   │   ├── chunking/
│   │   ├── embeddings/
│   │   ├── indexes/
│   │   ├── search/
│   │   └── reranking/
│   ├── observability/
│   │   ├── logging.py
│   │   ├── tracing.py
│   │   ├── metrics.py
│   │   └── ai_tracing.py
│   └── shared/
│       ├── config.py
│       ├── exceptions.py
│       ├── schemas/
│       ├── events/
│       └── identifiers.py
│
├── database/
│   ├── migrations/
│   ├── models/
│   ├── repositories/
│   └── seeds/
├── evaluations/
│   ├── datasets/
│   ├── supervisor/
│   ├── tool_selection/
│   ├── guardrails/
│   ├── itinerary_quality/
│   ├── factual_grounding/
│   ├── approval_safety/
│   ├── experiments/
│   └── reports/
├── tests/
│   ├── unit/
│   ├── integration/
│   ├── contract/
│   ├── e2e/
│   ├── security/
│   ├── concurrency/
│   ├── load/
│   ├── resilience/
│   └── fixtures/
├── infrastructure/
│   ├── terraform/
│   │   ├── modules/
│   │   └── environments/
│   │       ├── dev/
│   │       ├── staging/
│   │       └── prod/
│   ├── docker/
│   ├── monitoring/
│   ├── secrets/
│   └── scripts/
├── .github/
│   └── workflows/
│       ├── ci.yml
│       ├── security.yml
│       ├── evaluations.yml
│       ├── deploy-staging.yml
│       └── deploy-production.yml
├── docs/
│   ├── architecture/
│   ├── api/
│   ├── security/
│   ├── decisions/
│   ├── runbooks/
│   ├── incident-response/
│   └── product-requirements/
├── pyproject.toml
├── package.json
├── .env.example
├── .gitignore
├── Makefile
└── README.md
```

### 8.1 Foundation-only additions (no deletions/restructures)

```text
travel-concierge-ai/
├── AGENTS.md
├── CONTRIBUTING.md
├── specs/
│   ├── features/
│   ├── api-contracts/
│   ├── data-contracts/
│   └── acceptance-criteria/
├── automation/
│   ├── scaffolding/
│   ├── codegen/
│   ├── validation/
│   └── scripts/
├── docs/
│   ├── development/
│   ├── engineering-log/
│   └── limitations/
└── .github/workflows/
    └── dependency-updates.yml  # future workflow; do not create functionality without design
```

The foundation spec itself should be stored under `docs/product-requirements/` (or `specs/` after an explicit documented decision); do not duplicate competing canonical copies. Placeholder directories must be distinguishable from implemented features.

## 9. Development milestones and acceptance gates

The following is the authoritative **sequence**, not a fixed calendar or a claim of completion.

| # | Milestone | Key activities | Evidence/exit condition |
|---|---|---|---|
| 1 | Repository foundation & automation | GitHub repo, local tools, branch, documentation baseline, AGENTS.md, specs, safe scaffold | Clean inspectable repo, reproducible bootstrap instructions, docs based on approved source |
| 2 | API and local database | FastAPI, PostgreSQL, models, Alembic, unit/integration tests | API responds, schema migrations run and roll back, integration tests pass |
| 3 | Frontend and identity | Next.js, OIDC, accounts, trips, authorization | Users sign in and manage only permitted records |
| 4 | Core agent orchestration | LLM gateway, LangGraph state, routing, checkpointing, HITL | Workflow can complete, interrupt, resume and reject safely |
| 5 | Travel tools and suppliers | MCP tools, provider adapters, mock then permitted sandbox APIs | Trusted/clearly mocked offers can be searched, normalized, verified |
| 6 | AI quality, safety and evaluation | Golden cases, regression harness, instrumentation, cost metrics | Reproducible measured results, explicit failure cases |
| 7 | Delegation and approval | Family roles, invitations, permission checks, exact offer approvals | Unauthorized access or approval rejected; changes force review |
| 8 | Sandbox booking and payment | State machines, safe supplier simulation, payment sandbox, reconciliation | Duplicates, failures and uncertain external outcomes tested |
| 9 | Cloud staging | Terraform, IAM/OIDC deployment, ECS/ECR, RDS, S3, SQS, CI/CD | Staging deployed with controlled cost and passing e2e smoke tests |
| 10 | Operational readiness | Monitoring, backups, restoration, load/resilience tests, incident playbooks | Recovery and rollback exercised; risks documented |
| 11 | Controlled live release | Supplier commercial approvals, payment/compliance requirements, controlled launch | Authorized confirmed transactions demonstrably reconcilable |

**Current position:** Within milestone 1, following repository scaffolding and owner foundation approval on 2026-11-10. Implementation requires a separately authorized task. Section 9.1 retains historical setup observations; the [foundation engineering log](../engineering-log/FOUNDATION_BASELINE.md) records subsequent repository evidence.

### 9.1 Known local setup evidence (reported in this conversation)

- GitHub private repository `AvaliVava/travel-concierge-ai` created, initially including README and `.gitignore`; local clone resides at `C:\Users\VaVa\travel-concierge-ai`.
- Local Git: `main` tracked `origin/main`, clean tree at check; subsequently branch `setup/repository-foundation` verified with `git status --short` empty.
- Python 3.11.9 virtual environment `.venv` created and activated; executable path verified inside repository; `.venv/` ignored by Git.
- Node.js `v26.13.0`, npm `11.20.0` verified after refreshing the shell PATH; permanent machine PATH already listed Node.js installation directory.
- Docker Desktop `4.99.0`, Docker Engine `29.9.3`, Compose `v5.7.0` observed; WSL installed, virtualization enabled, hypervisor running; `docker run hello-world` succeeded.
- **Not established:** source-tree scaffolding beyond initial files, database service, FastAPI/Next.js implementations, cloud infrastructure, CI workflows, hosted model integrations, travel supplier APIs, and evaluations.

**Verification scope:** These observations came from the user's local command output and screenshots; Codex must recheck relevant claims within its actual execution environment rather than treating them as independently re-run by Codex.

## 10. Environment, secrets and infrastructure rules

### 10.1 Local

- Windows + PowerShell + VS Code; Python venv; Node.js; Docker Desktop using WSL 2.
- Prefer Docker Compose for local PostgreSQL; native Windows installation remains possible but is not required.
- Store local secrets in a Git-ignored `.env` or ephemeral terminal environment variables as appropriate. `.env` is **not mandatory**; a provided `.env.example` must contain placeholders only.
- Do not commit credentials or sensitive customer data. Never include secrets in AI prompts.
- Dev setup should be reproducible through safe scripts and documented commands.

### 10.2 AWS staging/production — not configured yet

- Terraform modules and environment states (development, staging, production) with protected remote state and access control.
- ECR for images; ECS Fargate for API and workers; RDS for PostgreSQL; SQS for jobs; S3 for permitted objects; AWS secrets storage and IAM task roles.
- GitHub Actions OIDC short-lived credentials preferred over static AWS keys.
- Network isolation, encryption, backups and restoration, resource budgeting, observability and rollback designed before production promotion.
- `terraform apply` and cloud resources may incur costs and require explicit authorization.

### 10.3 External credentials

LLM, travel supplier, map, weather, messaging, observability and payment accounts activated **only** when needed. Sandbox access and contracts must be checked. Do not assume any provider credentials already exist or that live ticketing is available.

## 11. Security, quality, evaluation and operations requirements

### 11.1 Security baseline

- OIDC-based sign-in with deterministic permission enforcement; roles/delegation defined explicitly.
- Principle of least privilege, scoped data access, secure secret management, TLS and data minimization.
- Treat prompt injection, malicious content in MCP results and excessive tool authority as design risks.
- Validate outbound supplier calls and inbound payment/supplier webhooks.
- Keep audit logs for approvals, privileged operations and financial state changes.
- Payment and traveller data protection requirements and applicable travel-agency obligations must be evaluated before live launch.

### 11.2 Software tests

- Unit, integration, contract, end-to-end, security, concurrency, resilience and selected load tests.
- Use deterministic mocks for failure modes; include network timeouts, duplicate events, expired offers, auth failures and uncertain supplier results.
- CI gates must run actual commands and report outcomes; never claim unrun checks passed.

### 11.3 AI evaluations

- Supervisor routing correctness, tool selection, source grounding, budget adherence, itinerary usefulness, refusal/guardrail decisions, unauthorized-action prevention, human-review enforcement, token/cost accounting, latency and resilience.
- Maintain versioned evaluation cases, rubrics, baselines, prompt/model IDs, artifacts and failure analyses.
- Proposed numeric quality targets require measurement and approval, not invented industry thresholds.

### 11.4 Observability & operational readiness

- Structured logs, OpenTelemetry traces/metrics, AI tool/model traces and controlled alerts.
- Redaction/privacy controls before any third-party tracing.
- Availability/recovery objectives, backup/restore drills, incident runbooks, responsible on-call handling and staged rollbacks before public production operation.

## 12. AI-assisted engineering workflow and attribution

### 12.1 Roles

| Role | Responsibility |
|---|---|
| Product owner | Product requirements, explicit design approval, supplier/commercial accounts, authorized cloud and financial actions, merge/release decisions |
| ChatGPT | Draft specifications, architecture analysis, implementation instructions, independent reasoning/review, test plan and documentation preparation |
| Codex | Bounded repository changes, scaffolding, code, tests and documentation **based on approved inputs**; supply concrete verification results |
| GitHub Actions | Automated checks and gated delivery based on actual configurations |
| Cloud/provider services | Run managed resources; do not replace engineering accountability |

### 12.2 Standard change workflow

1. Define objective, current milestone, scope, acceptance criteria and non-goals.
2. Provide authoritative source document and relevant code context.
3. Codex plans the bounded change and calls out ambiguities before inventing requirements.
4. Codex makes changes only on authorized branch; no unrelated refactors.
5. Run relevant checks; include exact commands, exit status/results and test counts if available.
6. Review source diff and security/architectural implications.
7. Document new decisions (ADR) only when decisions were actually made.
8. Product owner approves merge/deployment; retain PR and test evidence.
9. Update README, engineering logs, limitations and feature status truthfully.

### 12.3 Codex `AGENTS.md` policy to derive

- Protect original directory boundaries; never silently redesign architecture.
- Use this specification and approved ADRs; mark unresolved items `OPEN`.
- Do not create fake integrations, fabricated metrics or undocumented product behavior.
- No autonomous commit, push, pull request, cloud provisioning, account registration, credentials, payment or booking action without explicit instruction.
- Constrain edits to scope; show changed files and diff-check results.
- Use safe placeholders instead of real secrets; update `.gitignore`.
- Explain what tests were actually run and what was not verified.

### 12.4 Personal contribution and AI assistance

Document accurately which design decisions and implementations were human-designed, AI-assisted, independently verified, or pending review. Use PR descriptions and engineering logs rather than claiming exclusive authorship or relying on unverifiable stories. Using Codex is acceptable; demonstrable understanding and verification are required.

## 13. Repository documentation and public development standards

### 13.1 Required initial files

| File | Purpose | Codex source of truth |
|---|---|---|
| `README.md` | Public problem, product, truthful current status, roadmap, setup, tests and limits | This document + observed repository |
| `AGENTS.md` | Coding agent rules | Section 12 + explicit owner instruction |
| `CONTRIBUTING.md` | Branch, PR, review, testing and documentation rules | Section 12 |
| `docs/product-requirements/PROBLEM_STATEMENT.md` | Problem, roles, goals and non-goals | Sections 1–2 |
| `docs/architecture/SYSTEM_OVERVIEW.md` | Logical boundaries, flows, code organization | Sections 3–8 |
| `docs/decisions/ADR-0001-monorepo-architecture.md` | Context, decision, alternatives, trade-offs | Section 3; label as proposed/accepted per approval |
| `docs/development/LOCAL_SETUP.md` | Prerequisites and reproducible commands | Section 9.1 plus local checks |
| `docs/engineering-log/FOUNDATION_BASELINE.md` | Exact facts vs pending work | Section 9.1 and `git status` |
| `docs/limitations/KNOWN_LIMITATIONS.md` | Missing capabilities and risks | Sections 1.5, 14 |
| `specs/{features,api-contracts,data-contracts,acceptance-criteria}/` | Future executable requirements | Only short orientation documents now |
| `automation/{scaffolding,codegen,validation,scripts}/` | Reusable dev automation | No speculative implementation |

The README must never claim future capabilities are live. The foundation spec should be committed in one canonical location only after review.

### 13.2 Build-in-public approach

- Public documentation should reflect actual engineering milestones, not marketing claims.
- LinkedIn updates can draw from verified PRs, diagrams, test evidence, decisions and failures.
- Protect supplier confidentiality, personal data and secrets; private repository is an agreed **initial** visibility choice, with publication decision deferred.
- Project quality is evaluated by implementation evidence, not frequency of posts.

### 13.3 Documentation update cadence

- Every meaningful PR: scope, changed files, verification, limitations.
- Important architectural change: dated ADR stating context, options, decision and trade-offs.
- Major milestone: demonstrated outcome, results, residual risk, next milestone.
- Do not invent complete data from undeveloped subsystems.

## 14. Open decisions and dependency register

| ID | Decision / dependency | Current disposition |
|---|---|---|
| OPEN-01 | Exact model provider(s), model routing and cost budget | Not selected |
| OPEN-02 | Identity provider (Cognito/Auth0/Keycloak), precise role/permission model | Not selected |
| OPEN-03 | Flight inventory and ticketing partner, eligibility, settlements | Supplier candidates only |
| OPEN-04 | Hotel inventory/booking partner, coverage and commercial permission | Supplier candidates only |
| OPEN-05 | Payment provider(s), M-Pesa support, settlement and refund model | Not selected |
| OPEN-06 | Initial supported markets, currencies, jurisdictions and traveller types | Not finalized |
| OPEN-07 | Legal, privacy and travel-agency responsibilities for real sales | Requires professional/official verification |
| OPEN-08 | Detailed booking/payment state machines and cross-supplier compensation | Design before transaction stage |
| OPEN-09 | Target service levels, load and performance budgets | To benchmark |
| OPEN-10 | AWS region, runtime sizing, staging/production cost ceilings | To choose before provisioning |
| OPEN-11 | Specific observability backend and privacy settings | Candidate stack only |
| OPEN-12 | Initial scope of RAG, embeddings and any vector storage | Add only if justified |
| OPEN-13 | Public repository timing, license and disclosure review | Private initially; revisit |
| OPEN-14 | Precise project package/import layout and build system conventions | Define during implementation foundation; preserve conceptual tree |
| OPEN-15 | Scope of first customer-facing MVP and exact acceptance metrics | Determine in product specification stage |
| OPEN-16 | Exact handling of permission expiry, family invitations and payer authorization | Detailed security design pending |
| OPEN-17 | CI/CD gating and manual production approval policy | Define before release automation |

These items are not blockers for foundation scaffolding; they **are** blockers for falsely claiming implementation decisions have been finalized.

## 15. Initial Codex scaffolding contract (foundation approval recorded)

**Input:** This approved foundation specification saved at a named path in the repository, plus the live tree and branch state.

**Allowed now:** Create required documentation from the supplied source, create top-level and selected structural placeholders (no fake modules), create safe `.env.example`, extend `.gitignore`, add instructions for future automation, and run read-only/static checks.

**Not allowed now:** Implement FastAPI, Next.js, LangGraph or business logic; install dependencies; configure PostgreSQL; create actual cloud infrastructure or Terraform state; use real provider secrets; commit/push/open PR; change branch; create running CI that claims unimplemented tests are passing; or alter approved architecture without authorization.

**Required checks/report:**

- Confirm current branch is `setup/repository-foundation` and inventory original files.
- Compare generated documentation to **this** document and report omitted/ambiguous points.
- Verify `.venv/`, `.env`, credential files and Terraform state are ignored as applicable.
- Run `git diff --check` and inspect `git status --short`.
- Summarize all created/modified paths, security concerns, tests actually executed vs not executed, deviations and open questions.
- Stop for human review; do not commit, push or merge.

## 16. Owner approval record

The owner **approved v1.0 as the initial product and engineering foundation on 2026-11-10**. Approval covers the product vision, agreed architectural direction, development process, documentation standards and engineering boundaries. It leaves all 17 open decisions unresolved and does not authorize production operations. Implementation, supplier integrations, production security, infrastructure sizing and transaction-specific approvals remain pending. The [dated approval record](../decisions/2026-11-10-foundation-approval.md) preserves the exact owner decision, scope and exclusions.

**Approval record:**

- Reviewer: Project owner, by explicit instruction in the Foundation Approval Record task.
- Approval date: 2026-11-10.
- Approved version / reviewed-source hash: v1.0; the pre-update source SHA256 is recorded in the dated approval record, not presented as the current file hash.
- Amendments: Approval-status language and references only; original technical content and OPEN-01 through OPEN-17 are unchanged.
- Canonical repository path: `docs/product-requirements/TRAVEL_CONCIERGE_PROJECT_FOUNDATION_SPEC_v1.0.md`.

**End of foundation specification.**
