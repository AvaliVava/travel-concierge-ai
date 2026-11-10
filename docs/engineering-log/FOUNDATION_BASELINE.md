# Foundation baseline

Date: 2026-11-10. Source:
[Foundation Specification v1.0](../product-requirements/TRAVEL_CONCIERGE_PROJECT_FOUNDATION_SPEC_v1.0.md).
This records repository evidence separately from product plans and historical
setup reports. The owner [approved the initial foundation on 2026-11-10](../decisions/2026-11-10-foundation-approval.md).
All 17 open decisions remain unresolved. Implementation and production operations
require separate authorization. No commit, push, PR, branch change, or provisioning
is authorized by this documentation task.

## Pre-change observations

- Workspace: `C:\Users\VaVa\Desktop\travel-concierge-ai`.
- `git branch --show-current`: `setup/repository-foundation`.
- `git status --short`: only the root-level specification was untracked.
- `git ls-files`: only the initial README and Python-oriented ignore file.
- `git log -3 --oneline`: `8d9c66b Initial commit`.
- An ignored local Python virtual environment existed; no application source tree
  was present. No external repository visibility or remote service was verified.
- Read the complete 754-line specification before creating any scaffold files.

## Source preservation and authority

During the original scaffolding task, the untracked specification was relocated
from the repository root to its section 8.1 product-requirements location as one
byte-identical copy. SHA256 before/after that relocation:
`2DABF2F087B29E86301BFD44301F4FAC75E66C1E9907DF06D87928E3B3678854`.
Its review status, approval fields, and historical text were not edited during
that task. The subsequent approval-status updates below intentionally change
document metadata while preserving the original technical content.

The original scaffolding task authorized a bounded scaffold while the source
still used draft-only approval wording. The owner's subsequent explicit approval
resolves that discrepancy and accepts the initial architectural direction; it
does not resolve open decisions or authorize implementation/production operations.
The old clone path/clean-tree report is historical, not current evidence. All 17
open decisions are retained in
[known limitations](../limitations/KNOWN_LIMITATIONS.md).

## Implemented foundation

- All 143 distinct directories in source sections 8/8.1, preserving names,
  component boundaries, and foundation additions. Empty leaves use placeholders.
- The nine requested engineering documents; brief orientation for specs,
  automation, future workflows, and the secret-management boundary.
- Empty generic environment placeholders; no selected provider or runtime config.
- Ignore extensions for Node output, environment variants, credentials, Terraform
  state/plans/secret variables, generated reports, and temporary files.
- The inherited `lib/` packaging ignore was scoped to the root to preserve
  the required customer application's library directory.
- A read-only PowerShell/Git validator for structure, documentation references,
  local links, Git visibility, ignore protections, and common credential patterns.

Application modules, manifests, build files, Dockerfiles, and workflow YAML in
the target blueprint are deferred under the foundation contract. They were not
created as fake modules or resolved against OPEN-14/17. No new architecture or
product behavior was introduced.

## Environment evidence independently rechecked

| Command | Result / scope |
| --- | --- |
| `$PSVersionTable.PSVersion.ToString()` | `5.1.26100.9711` |
| `git --version` | `2.55.0.windows.5` |
| `& .\.venv\Scripts\python.exe --version` | `Python 3.11.9`; existing venv executable |
| `node --version` | `v26.13.0` |
| `npm --version` | `11.20.0` |
| `docker --version` | `29.9.3`, build `5457199`; client only |
| `docker compose version` | `v5.7.0`; plugin only |

These are observed versions, not version pins, tested compatibility, or daemon
health. The source's Docker Desktop/WSL/hello-world observations were not rerun.

## Static verification (initial scaffolding task)

The following results are historical observations from the original scaffolding
task, before the approval record was added. All checks were local and required
no installs; later documentation changes do not retroactively update these counts.

| Command / check | Observed result |
| --- | --- |
| `& .\automation\validation\Test-RepositoryFoundation.ps1` | Exit 0: 143 directories, nine required documents, 197 local Markdown links, 25 ignore probes, empty environment placeholders, and 119 Git-visible files checked |
| Credential pattern scan within the validator | Six pattern groups; no candidate credentials found in Git-visible files. Ignored local files are excluded; this is limited detection, not a security guarantee |
| `git check-ignore -v -- .venv/ .env .env.local apps/web/node_modules/example/index.js infrastructure/terraform/environments/dev/terraform.tfstate infrastructure/secrets/local.json` | Exit 0: every supplied path matched the intended ignore rules |
| `git diff --check` | Exit 0; no output. Covers tracked diffs, so new authored files were checked separately |
| PowerShell whitespace/conflict-marker scan of all authored files | 118 files checked; no trailing whitespace or merge markers. The unchanged supplied specification was excluded |
| `Get-FileHash -LiteralPath 'docs\product-requirements\TRAVEL_CONCIERGE_PROJECT_FOUNDATION_SPEC_v1.0.md' -Algorithm SHA256` | Matched the original SHA256 recorded above |
| `git branch --show-current` | `setup/repository-foundation`; unchanged |
| `git status --short` and `git status --short --untracked-files=all` | Two modified tracked files, 117 untracked files, zero staged entries, zero tracked deletions; complete paths/status output in the inventory below |
| Inventory comparison against `git ls-files --cached --others --exclude-standard` | All 119 Git-visible paths accounted for |

The first validator run exposed CR characters added to native stdin by Windows
PowerShell 5.1 and an assignment pattern crossing empty values/newlines. The
utility was corrected to pass Git path arguments directly and restrict assignment
spacing to horizontal whitespace. Subsequent checks passed.

Seven utility checks ran in an isolated temporary copy, with a local fixture Git
repository and no dependencies, network, or application services. Each invocation
used `powershell -NoProfile -File $fixtureValidator`; the runner required the
expected exit code and diagnostic marker:

| Fixture | Expected / observed exit |
| --- | --- |
| Complete copied foundation | 0 / 0 |
| Missing required document | 1 / 1 |
| Broken local Markdown link | 1 / 1 |
| Nonempty environment placeholder | 1 / 1 |
| Synthetic credential-like assignment (no real credential) | 1 / 1; diagnostic omitted its value |
| Removed environment ignore protection | 1 / 1 |
| Restored complete foundation | 0 / 0 |

Result: **7/7 utility checks behaved as expected**. These are local validation
checks, not product tests or a configured application suite. The actual workspace
was not mutated by the negative fixtures.

The [initial scaffold file-change inventory](FOUNDATION_CHANGE_INVENTORY.md)
records 116 created files (98 empty placeholders), two modified files, and the
existing source relocated unchanged during that task. There were no original
content deletions; this is a historical snapshot, not the later approval task's
file inventory.

Application tests, AI evaluations, dependency compatibility, database/runtime
checks, supplier/payment integrations, CI/CD, and production readiness remain
unverified. Nothing is production ready.

## Attribution and next gate

The owner supplied the scope and source; the source attributes planning roles
to the owner and ChatGPT. Codex generated this bounded scaffold/documentation and
ran the checks explicitly recorded here. Source claims were not independently
converted into product evidence. Owner approval of the initial foundation is now
recorded. The next implementation milestone needs a separately authorized task.

## Owner approval update — 2026-11-10

The owner explicitly approved the initial product and engineering foundation as
the baseline for subsequent phased development, covering the product vision,
agreed architectural direction, development process, documentation standards and
engineering boundaries. The dated approval record preserves the exact decision
and exclusions; ADR-0001 is accepted as the initial architectural direction.

All OPEN-01 through OPEN-17 retain their original identifiers, wording and
dispositions. Implementation, supplier integrations, production security,
infrastructure sizing and transaction-specific approvals remain pending. This
approval does not authorize production operations or demonstrate production
readiness. No application behavior or technology choice was changed.

This documentation-only task adds the dated approval record and updates approval
references in the specification, ADR, system overview, agent instructions, this
log, limitations, and the directly affected approval sentences in the README,
contribution guide, local setup guide and problem statement. Previous scaffold
changes remain uncommitted; this task does not modify those non-documentation files.

### Approval task file inventory

Relative to the workspace at the start of this approval task: one document
created, ten documents modified, no deletions. All non-documentation hashes are
unchanged, including the previously modified ignore file and foundation validator.

| Change | File |
| --- | --- |
| Created | [Dated foundation approval](../decisions/2026-11-10-foundation-approval.md) |
| Modified | [Foundation Specification v1.0](../product-requirements/TRAVEL_CONCIERGE_PROJECT_FOUNDATION_SPEC_v1.0.md) |
| Modified | [AGENTS.md](../../AGENTS.md) |
| Modified | [SYSTEM_OVERVIEW.md](../architecture/SYSTEM_OVERVIEW.md) |
| Modified | [ADR-0001](../decisions/ADR-0001-monorepo-architecture.md) |
| Modified | [FOUNDATION_BASELINE.md](FOUNDATION_BASELINE.md) |
| Modified | [KNOWN_LIMITATIONS.md](../limitations/KNOWN_LIMITATIONS.md) |
| Modified | [README.md](../../README.md) |
| Modified | [CONTRIBUTING.md](../../CONTRIBUTING.md) |
| Modified | [LOCAL_SETUP.md](../development/LOCAL_SETUP.md) |
| Modified | [PROBLEM_STATEMENT.md](../product-requirements/PROBLEM_STATEMENT.md) |

### Approval task verification

| Command / check | Observed result |
| --- | --- |
| `& .\automation\validation\Test-RepositoryFoundation.ps1` | Exit 0: 143 directories, nine required documents, 224 local Markdown links, 25 ignore probes, empty environment placeholders, and 120 Git-visible files checked; no credential-pattern candidates |
| Pre-/post-update source comparison | Sections 1-8.1, milestone sequence, historical section 9.1, sections 10-14, and section 15's contract body are exactly unchanged; edits are limited to approval/status references |
| Open-register comparison | All 17 original rows exactly unchanged in the specification; limitations and the approval record contain the same identifiers, wording and dispositions |
| Workspace hash comparison | Only the ten Markdown documents above changed and the one approval record was added; no existing file deleted; non-documentation files unchanged |
| Approval-status consistency scan across root and engineering Markdown | No stale current review-draft, pending formal approval, or awaiting-review references found; historical observations are explicitly labeled |
| `git diff --check` | Exit 0; no output. Git's tracked-diff scope does not include the untracked foundation documents; those were also inspected and compared with the pre-task source |
| `git status --short` and `git status --short --untracked-files=all` | Two modified tracked files and 118 untracked files; zero staged entries or tracked deletions. The earlier scaffold changes were already present |
| `git branch --show-current` / `git rev-parse HEAD` | `setup/repository-foundation` / `8d9c66be79ce79c18aa97ce2fd8096eae7b4a6b9`; both unchanged |

Current specification SHA256 after approval-status updates:
`7F3C06F1A852F9DAC2EEB630C432C3D4EDA4DF8643756E155B378A1221ED40E2`.
The original reviewed-source hash above remains historical provenance rather
than a claim that metadata updates leave the current file byte-identical.

No current approval-status inconsistency remains. The historical clone-path
discrepancy stays documented; all 17 open decisions and implementation-stage
approvals remain pending. No application tests, supplier integrations, production
security verification, or operational readiness checks were performed in this
documentation task. No dependencies, application code, branches, commits, pushes,
PRs, cloud resources, or production operations were changed or created.
