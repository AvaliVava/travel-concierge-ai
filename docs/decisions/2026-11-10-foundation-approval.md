# Initial foundation approval — 2026-11-10

- Decision owner: project owner, by explicit instruction in the Foundation
  Approval Record task.
- Decision date: 2026-11-10.
- Status: **Approved initial product and engineering foundation.**
- Repository / branch: `AvaliVava/travel-concierge-ai` / `setup/repository-foundation`.
- Approved baseline: [Foundation Specification v1.0](../product-requirements/TRAVEL_CONCIERGE_PROJECT_FOUNDATION_SPEC_v1.0.md).
- Architecture record: [ADR-0001](ADR-0001-monorepo-architecture.md), accepted as
  the initial architectural direction.

## Exact owner decision

> On 2026-11-10, the owner approved the project's initial product and engineering foundation as the baseline for subsequent phased development.
>
> This approval covers the product vision, agreed architectural direction, development process, documentation standards and engineering boundaries.
>
> It does not resolve any of the 17 open decisions or authorize production operations.

## Approved scope

The approval establishes the specification's product vision and phased development
sequence, modular monorepo and agreed architectural direction, development
process, documentation/evidence standards, and engineering boundaries as the
initial baseline. ADR-0001 records acceptance of that existing direction; no
architecture, component boundary, or technology decision is changed here.

Technology dispositions remain as documented: agreed direction, candidate/proposed,
optional, deferred, or open. Approval of the baseline does not select a candidate
provider, finalize an unresolved design, or establish implementation evidence.

## Exclusions and pending approvals

- **Implementation:** subsequent work requires a separately authorized, phased
  task and relevant implementation specifications/tests. This task changes only
  documentation; application capabilities remain planned.
- **Supplier integrations:** partner selection, eligibility, contracts, sandbox
  access, credentials, and live supplier actions remain pending.
- **Production security:** detailed identity/delegation, permissions, privacy,
  payment-data controls, compliance, and operational acceptance remain pending
  design, implementation, verification, and applicable approvals.
- **Infrastructure sizing:** region, runtime sizing, cost ceilings, and provisioning
  authorization remain pending. No cloud or production operation is authorized.
- **Transactions:** booking/payment state machines, supplier/payment sequencing,
  settlement, compensation, and transaction-specific approvals remain pending.
  No booking, payment, capture, settlement, cancellation, or refund is authorized.
- **Release:** no production readiness, merge, deployment, commit, push, or PR is
  authorized by this documentation task. Existing release/operational gates apply.

## Remaining open decisions

All identifiers and dispositions below are unchanged from section 14 of the
approved specification; the [limitations register](../limitations/KNOWN_LIMITATIONS.md)
retains the same 17 open items.

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

## Source identity and evidence

The reviewed v1.0 source, before these approval-status updates, had SHA256
`2DABF2F087B29E86301BFD44301F4FAC75E66C1E9907DF06D87928E3B3678854`.
This identifies the reviewed source, not the current file after its metadata
updates. Original technical content and all open-decision rows are preserved.

The owner supplied the decision; Codex records it without independently granting
approval. The [engineering log](../engineering-log/FOUNDATION_BASELINE.md) separates
the original scaffold evidence from verification of this documentation update.
No implementation, supplier integration, or production readiness is demonstrated
by the approval record.
