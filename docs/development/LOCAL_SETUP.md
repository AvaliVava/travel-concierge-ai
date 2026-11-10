# Local setup

Source: [Foundation Specification v1.0](../product-requirements/TRAVEL_CONCIERGE_PROJECT_FOUNDATION_SPEC_v1.0.md),
sections 9.1, 10, and 15. This guide covers foundation inspection and validation.
The owner [approved the initial foundation on 2026-11-10](../decisions/2026-11-10-foundation-approval.md);
application setup remains planned and requires a separately authorized task.

## Prerequisites and observed tools

The intended local environment is Windows, PowerShell, VS Code, a Python virtual
environment, Node.js, and Docker Desktop using WSL 2. Docker Compose is preferred
for a later local PostgreSQL service; native Windows PostgreSQL is not required.

Observed during this task on 2026-11-10:

| Check | Observed result | Scope |
| --- | --- | --- |
| `$PSVersionTable.PSVersion.ToString()` | `5.1.26100.9711` | Current shell |
| `git --version` | `2.55.0.windows.5` | Git executable |
| `& .\.venv\Scripts\python.exe --version` | `Python 3.11.9` | Existing virtual environment executable |
| `node --version` | `v26.13.0` | Node executable |
| `npm --version` | `11.20.0` | npm executable |
| `docker --version` | `29.9.3`, build `5457199` | Client version only |
| `docker compose version` | `v5.7.0` | Compose plugin version only |

These are observations, not selected version pins or compatibility guarantees.
Python/JS dependency tooling and build conventions remain OPEN-14. The previous
Docker Desktop, WSL, hypervisor, and hello-world evidence in the specification
was not independently rerun here; daemon health is not established by CLI versions.

## Inspect the existing checkout

Use the actual checkout path. The current workspace is
`C:\Users\VaVa\Desktop\travel-concierge-ai`; section 9.1's path omits `Desktop`
and is historical evidence, not a command to create or move the checkout.

```powershell
Set-Location 'C:\Users\VaVa\Desktop\travel-concierge-ai'
git branch --show-current
git status --short --untracked-files=all
```

The authorized branch is `setup/repository-foundation`. Do not switch branches
for this task. Read the complete specification at the link above before changes.

## Safe local configuration

[.env.example](../../.env.example) contains empty placeholders only. Nothing
currently loads it. A local environment file is optional; terminal variables can
be used when a later implementation needs them. To create an optional local copy:

```powershell
if (-not (Test-Path -LiteralPath '.env')) {
    Copy-Item -LiteralPath '.env.example' -Destination '.env'
}
git check-ignore -v .env .venv/
```

Do not fill in real credentials for this task. The copy command is documentation,
not a command executed as part of scaffolding. Future accounts must be explicitly
authorized, sandboxed, and configured only when needed. No provider is selected
by a generic environment placeholder.

## Validate the foundation

From the repository root in PowerShell, with Git available:

```powershell
& .\automation\validation\Test-RepositoryFoundation.ps1
git diff --check
git status --short --untracked-files=all
```

The script resolves its repository location without assuming the working
directory. It reads the specification's directory tree, checks documentation and
local links, placeholder environment values, Git visibility/ignore protections,
and common credential patterns. It reads tracked and nonignored untracked files
and reports paths/line numbers without printing potential secrets. It returns a
nonzero exit code for failures and does not install, provision, start services,
write configuration, or contact providers. See [automation guidance](../../automation/README.md).

There are no application tests, evaluations, manifests, Dockerfiles, database
configuration, or CI workflows to run yet. A static validator success is not a
product test or integration result. Exact evidence is in the
[foundation baseline](../engineering-log/FOUNDATION_BASELINE.md).

## Later setup gates

Package/import/build conventions must be decided before dependency installation.
API/database work comes next, followed by frontend/identity, orchestration, tools,
evaluations, delegation, sandbox commerce, staging, operations, and controlled
release in the specification's order. Database, container, Terraform, provider,
and payment setup are outside this task. Cloud provisioning and financial actions
require explicit authorization.
