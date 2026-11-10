# Contributing

Read the complete [Foundation Specification v1.0](docs/product-requirements/TRAVEL_CONCIERGE_PROJECT_FOUNDATION_SPEC_v1.0.md)
and [agent instructions](AGENTS.md) before substantial work. The specification is
the [approved initial baseline as of 2026-11-10](docs/decisions/2026-11-10-foundation-approval.md).
All 17 open decisions remain unresolved; implementation and production operations
require separate authorization. Supplier and release choices remain open.

## Change workflow

1. Define the objective, milestone, scope, acceptance criteria, and non-goals.
   Use reviewed feature/API/data/acceptance specifications when implementation begins.
2. Check the actual tree and authorized branch. Foundation work stays on
   `setup/repository-foundation`; do not switch branches, commit, push, or open a
   PR during this task. Future branch naming is not specified here.
3. Preserve the modular monorepo and approved component boundaries. Surface
   contradictions and `OPEN` decisions before making choices that depend on them.
4. Implement only authorized work, with meaningful tests for behavior and
   deterministic mocks for failure paths. Avoid unrelated changes.
5. Run relevant checks and inspect source diffs, new files, secrets, and
   architectural implications. Record actual commands, results, failures, and
   verification gaps. Never report an unrun test as passed.
6. Update documentation, limitations, and engineering logs truthfully. Record
   important architectural decisions in dated ADRs with their real approval state.
7. When separately authorized, provide a reviewable PR with problem, behavior,
   scope, full changed-file inventory, validation evidence, and remaining risks.
   The owner approves merge and deployment. CI/CD gates and manual production
   approval policy remain OPEN-17; no release automation is configured now.

## Quality and evidence

Planned verification includes unit, integration, contract, end-to-end, security,
concurrency, resilience, and selected load tests. Include expired offers,
authorization failures, timeouts, duplicate events, and uncertain supplier outcomes
where relevant. Tests and application frameworks are not yet configured.

AI evaluations must version cases, rubrics, prompt/model IDs, baselines, artifacts,
costs, latency, and failure analyses. Evaluate routing, tool selection, grounding,
budget adherence, itinerary usefulness, guardrails, unauthorized actions, and
human-review enforcement. Numeric thresholds require measurement and approval.

Use lifecycle labels `planned`, `in_progress`, `implemented`, `verified`, and
`production_ready` with supporting evidence. A folder or successful unit test
does not demonstrate production readiness.

For foundation checks, follow [local setup](docs/development/LOCAL_SETUP.md).
No dependency install, cloud command, or application runtime is needed.

## Security and responsibility

Never commit credentials, environment secrets, raw card data, or real traveller
data. Keep local secrets ignored; use placeholder-only examples and safe mocks.
Redact logs and traces before external observability is enabled. Obtain explicit
authorization before production infrastructure or financial operations.

The owner controls product/design approval, supplier/commercial accounts,
cloud/financial authorization, and merge/release. AI assistance supplies bounded
changes and concrete evidence; engineers remain accountable for understanding
and review. Record contributions and assistance accurately.

The repository is initially private. Publication timing, disclosure review, and
license remain OPEN-13. Public updates must draw from actual milestones and
verification and protect confidential supplier information and personal data.
