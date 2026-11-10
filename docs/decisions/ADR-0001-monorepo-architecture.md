# ADR-0001: Modular monorepo architecture

- Date: 2026-11-10
- Status: **Accepted as the initial architectural direction on 2026-11-10.**
- Source: [Foundation Specification v1.0](../product-requirements/TRAVEL_CONCIERGE_PROJECT_FOUNDATION_SPEC_v1.0.md),
  sections 0, 3, 7-8, and 14-16.
- Authorization: the owner's [foundation approval](2026-11-10-foundation-approval.md)
  accepts the existing initial architectural direction. All 17 open decisions
  remain unresolved; implementation and production operations are not authorized
  by this documentation task.

## Context

The intended platform spans research, AI orchestration, delegated authority,
supplier access, and eventually transactions and operations. These have distinct
responsibilities and trust boundaries. The project is in milestone 1 and has no
application implementation or measured production workload.

## Recorded direction

Use one modular repository with the complete section 8/8.1 structure. Customer
and admin apps deploy separately. The initial intended backend roles are the API,
agent worker, and background worker. Shared packages separate agents,
orchestration, LLM access, tools/MCP, integrations, domain rules, security,
retrieval, observability, and shared contracts.

Agents recommend and prepare; deterministic domain/security services control
permissions and transactions. PostgreSQL owns business state; LangGraph
checkpoints hold workflow continuity. Logical boundaries do not require a
microservice, model instance, or MCP server for every responsibility.

## Alternatives and rationale

The specification explicitly rejects prematurely splitting every bounded context
into microservices or assuming every responsibility needs its own agent/MCP
server. It calls for modular ownership and interfaces first, with extra deployment
complexity introduced only when requirements or scale justify it.

It does not document a comparative prototype, benchmark, provider evaluation, or
formal multi-repository study. None is claimed here. Optional distributed
infrastructure remains conditional on evidence and a later ADR.

## Consequences and unresolved items

The repository provides common locations for code, contracts, tests, evaluations,
and documentation while retaining explicit security and transaction boundaries.
Maintaining those boundaries requires implementation and review; a directory tree
does not enforce them or establish production readiness.

Packaging/import/build conventions remain OPEN-14. Exact identity/provider
choices, transaction state machines, performance targets, cloud sizing, and
delivery gates remain open. This record selects no package manager, version
pins, runtime topology beyond the three stated roles, or provider contract.

## Evidence and follow-up

The foundation creates structural placeholders and documentation only. No API,
frontend, worker, integration, deployment, benchmark, or application test exists
as a result. Initial foundation/ADR approval is recorded; implementation-stage
specifications, supplier integrations, production security, infrastructure sizing,
and transaction-specific approvals remain pending. See
[known limitations](../limitations/KNOWN_LIMITATIONS.md).
