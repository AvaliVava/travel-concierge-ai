# Development automation

Source: [Foundation Specification v1.0](../docs/product-requirements/TRAVEL_CONCIERGE_PROJECT_FOUNDATION_SPEC_v1.0.md),
sections 8.1, 10, 12-15. Only local foundation validation is implemented.

| Directory | Scope |
| --- | --- |
| [scaffolding/](scaffolding/) | Reserved for later reviewed scaffold helpers; empty |
| [codegen/](codegen/) | Reserved for contract-driven generation after design; empty |
| [validation/](validation/) | Read-only PowerShell foundation validator |
| [scripts/](scripts/) | Reserved for safe local utilities; empty |

Run from PowerShell with Git available:

```powershell
& .\automation\validation\Test-RepositoryFoundation.ps1
```

The [validator](validation/Test-RepositoryFoundation.ps1) reads the canonical
specification's sections 8/8.1 to check every required directory. It checks
required documents, specification references and local Markdown links, empty
environment placeholders, Git visibility and ignore protections, and common
credential patterns in Git-visible files. It prints candidate locations without
secret values and returns nonzero on failure. It performs no writes, dependency
installation, network requests, provisioning, service startup, or financial action.

The credential check is a narrow local pattern scan, not a dedicated security
scanner or a guarantee that all secrets are absent. It omits ignored files, such
as the existing virtual environment and any local environment secrets. No
application tests, provider integrations, or deployment gates are exercised.

Package/build conventions and running workflows remain OPEN-14/17. Do not add
generators, bootstrap installers, CI success placeholders, deployment scripts,
or provider activation without an authorized design and task. Future automation
must validate inputs, preserve scope, and report actual failures.
