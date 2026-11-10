# Known limitations and open decisions

Source: [Foundation Specification v1.0](../product-requirements/TRAVEL_CONCIERGE_PROJECT_FOUNDATION_SPEC_v1.0.md),
especially sections 1.5, 7, 9-11, and 14-16. Updated: 2026-11-10.

## Current capability limits

Only repository scaffolding, documentation, ignore protections, and a local
static validation utility are implemented. Application components remain
`planned`: no FastAPI/Next.js behavior, LangGraph workflows, project database,
identity/delegation, tool/MCP service, supplier adapter, booking, payment, refund,
monitoring, or notification capability has been implemented or verified here.
No capability is `production_ready`.

No dependency installation, application test suite, AI evaluation dataset/harness,
runtime build, database integration, supplier sandbox, external API verification,
running CI workflow, infrastructure provisioning, or live operation was performed.
Version checks only establish executable versions; no Docker daemon/WSL smoke
test or package compatibility testing was rerun. Credential pattern scanning is
limited and does not replace a dedicated secret scanner or security review.

Supplier eligibility/contracts, current inventory, booking authority, independent
ticket/hotel confirmations, durable financial state, compensation/refunds,
idempotency, reconciliation, operational recovery, and legal/privacy requirements
must be established before relevant releases. No live customer data or funds are
authorized. General web results must never be presented as live bookable inventory.

## Complete unresolved register (source section 14)

| ID | Decision / dependency | Preserved disposition |
| --- | --- | --- |
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

These are not blockers for directory/document scaffolding. They do block claims
that dependent implementation choices are finalized.

## Source discrepancies and incomplete decisions

1. **Foundation approval recorded.** The original draft-versus-task authority
   discrepancy is resolved by the owner's
   [2026-11-10 approval](../decisions/2026-11-10-foundation-approval.md) of the initial
   product and engineering baseline. All 17 open decisions remain unchanged.
   Implementation, supplier integrations, production security, infrastructure
   sizing, and transaction-specific approvals remain pending. Production
   operations and readiness are not authorized or established by baseline approval.
2. **Canonical location.** The source arrived untracked at the repository root.
   Section 8.1 prescribes the product-requirements directory (or a separately
   decided specs location). It was moved unchanged to the linked location above,
   leaving one copy. The later approval record fills the source's canonical-path
   field and changes approval metadata; original technical content is preserved.
3. **Local path and cleanliness.** Section 9.1 reports an earlier clone path
   without `Desktop` and a clean tree. The actual checkout includes `Desktop`
   and began with the source untracked. Prior setup observations are historical;
   current evidence is recorded separately in the [baseline](../engineering-log/FOUNDATION_BASELINE.md).
4. **Complete blueprint versus foundation scope.** Every directory is preserved.
   The named application modules, Dockerfiles, package manifests, build files,
   and six future workflow filenames describe target state. They are deferred
   under sections 8, 8.1, and 15 rather than turned into fake modules or runnable
   configuration. OPEN-14/17 remain unresolved.
5. **Candidate names versus commitments.** Provider-specific adapter filenames in
   the target tree do not select providers. Section 7's agreed technologies are
   distinguished from proposed cloud/checkpoint options, optional Redis/LiteLLM,
   deferred retrieval, and open provider/observability choices.

No missing decision prevents the authorized directory/document scaffold. Later
implementation must resolve the relevant open items with explicit specifications
and evidence. This task introduces no new product requirements or benchmarks.
