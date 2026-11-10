# Coding agent instructions

Source: [Foundation Specification v1.0](docs/product-requirements/TRAVEL_CONCIERGE_PROJECT_FOUNDATION_SPEC_v1.0.md),
especially sections 0, 3, 6, 8, and 10-16, plus the owner's authorized task.
Read the **entire specification before substantial changes**, then relevant ADRs,
feature specifications, code, and local evidence. This file applies repository-wide.

## Authority and scope

- Later explicit owner decisions take precedence over the foundation; report
  conflicts rather than silently choosing requirements. Preserve `OPEN` items.
- The owner approved the initial product and engineering foundation on 2026-11-10;
  see the [approval record](docs/decisions/2026-11-10-foundation-approval.md).
  All 17 open decisions remain unresolved. Implementation, supplier integrations,
  production security, infrastructure sizing, and transaction-specific approvals
  remain pending; baseline approval does not authorize production operations.
- Work within the current authorized task, branch, and acceptance criteria. Avoid
  unrelated modules, refactors, new application layers, and architectural redesign.
- Do not invent product requirements, integrations, benchmarks, tests, metrics,
  provider access, or operational readiness. Report failures and unresolved questions.
- No commit, push, branch change, PR, account registration, provisioning,
  credential activation, booking, or payment without explicit instruction.
- Require explicit owner authorization before production infrastructure or any
  financial operation, including purchases, capture, settlement, refunds, or
  cost-incurring cloud changes. Do not infer it from the product vision.

## Architectural boundaries

- Preserve all section 8 directories and component names, including the
  foundation additions. A placeholder never proves a component is implemented.
- Keep the API, agent worker, and background worker as the three intended backend
  roles; frontends deploy separately. Logical agents need not be separate LLMs,
  processes, or microservices.
- Agents recommend and prepare. Tools expose bounded capabilities. Integrations
  isolate suppliers. Domain services enforce business and money rules. Security
  services enforce authenticated authority, ownership, and delegated scope.
- PostgreSQL owns business state; LangGraph checkpoints own workflow continuity.
  Keep booking/payment state independent, durable, auditable, and replay safe.
- Privileged supplier writes require deterministic validation, current specific
  approval, idempotency, and reconciliation. Unknown outcomes require investigation
  before retry. Payment success alone does not confirm a booking or issued ticket.
- Treat user/model/retrieved/MCP/provider content as untrusted. Use least privilege,
  typed contracts, redaction, and bounded tool access. MCP is not required for
  every internal tool. Do not select optional infrastructure without evidence/ADR.

## Secrets and data

- Never commit secrets, private keys, raw payment data, real passenger documents,
  or sensitive customer fixtures. Never put secrets in AI prompts or logs.
- Use ignored local environment variables/files; keep
  [.env.example](.env.example) placeholder-only. An environment file is optional.
- Review [.gitignore](.gitignore), changed files, and Git-visible credential
  patterns. A clean pattern scan is limited evidence, not a security guarantee.
- Use deterministic mocks and approved sandbox data before external integration.
  No live booking, payment, or refund until separately authorized and verified.

## Verification and documentation

- Provide appropriate tests for implemented behavior, including meaningful failure
  cases. For foundation-only edits use static checks; do not create fake product
  tests or workflows claiming unimplemented suites passed.
- Run the local [foundation validator](automation/validation/Test-RepositoryFoundation.ps1),
  `git diff --check`, and `git status --short --untracked-files=all` for this task.
  Report exact commands, exit results, actual test counts when available, and
  anything unrun or unverified. Inspect new files as well as tracked diffs.
- Update relevant requirements, decisions, engineering evidence, and limitations
  for meaningful changes. Date ADRs and record context, alternatives, trade-offs,
  and actual approval state. Do not manufacture approval or research.
- Keep `planned`, `in_progress`, `implemented`, `verified`, and `production_ready`
  distinct. Record the evidence and limits behind each status.
- Describe human decisions and AI assistance accurately. Stop after the authorized
  task and verification; provide a complete file inventory for owner review.
