# Read-only local checks derived from the Foundation Specification, sections 8-15.
[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$repositoryRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..\..'))
$specPath = 'docs/product-requirements/TRAVEL_CONCIERGE_PROJECT_FOUNDATION_SPEC_v1.0.md'
$failures = [Collections.Generic.List[string]]::new()

function Assert-Foundation {
    param([bool]$Condition, [string]$Message)
    if (-not $Condition) { $failures.Add($Message) }
}

try {
    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        throw 'Git must be available on PATH.'
    }
    if (-not (Test-Path -LiteralPath (Join-Path $repositoryRoot $specPath) -PathType Leaf)) {
        throw ('Missing canonical specification: ' + $specPath)
    }

    # Read both blueprint trees, using their indentation without duplicating a manifest.
    $specLines = Get-Content -LiteralPath (Join-Path $repositoryRoot $specPath) -Encoding UTF8
    $directories = [Collections.Generic.HashSet[string]]::new()
    $treeParents = @{}
    $insideBlueprint = $false
    foreach ($line in $specLines) {
        if ($line -like '## 8. Approved*') { $insideBlueprint = $true }
        if ($line -like '## 9. Development*') { break }
        if (-not $insideBlueprint) { continue }
        if ($line -eq 'travel-concierge-ai/') { $treeParents = @{} }
        if ($line -match '^(?<prefix>[\u2502 ]*)(?:\u251c\u2500\u2500|\u2514\u2500\u2500) (?<name>[^ #]+)') {
            $depth = [int]($Matches.prefix.Length / 4)
            $entryName = $Matches.name
            if ($depth -eq 0) { $entryPath = $entryName }
            else { $entryPath = $treeParents[$depth - 1] + $entryName }
            if ($entryName.EndsWith('/')) {
                $treeParents[$depth] = $entryPath
                [void]$directories.Add($entryPath)
            }
        }
    }
    if ($directories.Count -eq 0) { throw 'No blueprint directories parsed; check specification format.' }
    foreach ($directory in $directories) {
        Assert-Foundation (Test-Path -LiteralPath (Join-Path $repositoryRoot $directory) -PathType Container) ('Missing directory: ' + $directory)
    }
    Write-Output ('Checked blueprint directories: ' + $directories.Count)

    $requiredDocuments = @(
        'README.md', 'AGENTS.md', 'CONTRIBUTING.md',
        'docs/product-requirements/PROBLEM_STATEMENT.md',
        'docs/architecture/SYSTEM_OVERVIEW.md',
        'docs/decisions/ADR-0001-monorepo-architecture.md',
        'docs/development/LOCAL_SETUP.md',
        'docs/engineering-log/FOUNDATION_BASELINE.md',
        'docs/limitations/KNOWN_LIMITATIONS.md'
    )
    foreach ($document in $requiredDocuments) {
        $documentPath = Join-Path $repositoryRoot $document
        $exists = Test-Path -LiteralPath $documentPath -PathType Leaf
        Assert-Foundation $exists ('Missing required document: ' + $document)
        if ($exists) {
            $documentText = Get-Content -LiteralPath $documentPath -Raw -Encoding UTF8
            Assert-Foundation ($documentText.Contains('TRAVEL_CONCIERGE_PROJECT_FOUNDATION_SPEC_v1.0.md')) ('Missing specification reference: ' + $document)
        }
    }

    # Include untracked work; ordinary git diff does not inspect it.
    $visibleFiles = @(& git -C $repositoryRoot -c core.quotepath=false ls-files --cached --others --exclude-standard)
    if ($LASTEXITCODE -ne 0) { throw 'Could not list Git-visible files.' }
    $visibleFiles = @($visibleFiles | Sort-Object -Unique)
    foreach ($directory in $directories) {
        $represented = @($visibleFiles | Where-Object { $_.StartsWith($directory, [StringComparison]::Ordinal) }).Count -gt 0
        Assert-Foundation $represented ('Directory has no Git-visible placeholder/content: ' + $directory)
    }
    $specCopies = @($visibleFiles | Where-Object { [IO.Path]::GetFileName($_) -eq [IO.Path]::GetFileName($specPath) })
    Assert-Foundation ($specCopies.Count -eq 1 -and $specCopies[0] -eq $specPath) 'Expected one canonical specification copy.'

    $linkCount = 0
    foreach ($document in @($visibleFiles | Where-Object { $_.EndsWith('.md') })) {
        $documentPath = Join-Path $repositoryRoot $document
        $documentText = Get-Content -LiteralPath $documentPath -Raw -Encoding UTF8
        foreach ($link in [regex]::Matches($documentText, '\[[^\]]+\]\((?<target>[^)\r\n]+)\)')) {
            $target = $link.Groups['target'].Value.Trim('<', '>')
            if ($target -match '^(?:[a-zA-Z][a-zA-Z0-9+.-]*:|#)') { continue }
            $targetPath = $target.Split('#')[0]
            $resolvedTarget = Join-Path ([IO.Path]::GetDirectoryName($documentPath)) $targetPath
            Assert-Foundation (Test-Path -LiteralPath $resolvedTarget) ('Broken local Markdown link in ' + $document + ': ' + $target)
            $linkCount++
        }
    }
    Write-Output ('Checked required documents: ' + $requiredDocuments.Count + '; local Markdown links: ' + $linkCount)

    $ignoreProbes = @(
        '.venv/Scripts/python.exe', 'services/api/.venv/pyvenv.cfg',
        '.env', '.env.local', '.env.production', 'apps/web/.env.local',
        'node_modules/example/index.js', 'apps/web/node_modules/example/index.js',
        'apps/web/.next/build-manifest.json', '__pycache__/example.pyc',
        'infrastructure/terraform/.terraform/example',
        'infrastructure/terraform/environments/dev/terraform.tfstate',
        'infrastructure/terraform/environments/prod/terraform.tfstate.backup',
        'infrastructure/terraform/environments/staging/secret.tfvars',
        'infrastructure/terraform/environments/dev/secret.tfvars.json',
        'infrastructure/terraform/preview.tfplan',
        'infrastructure/secrets/local.json', '.aws/credentials',
        'credentials.json', 'service-account-local.json', 'private.pem', 'private.key',
        'generated/example.txt', 'tmp/example.txt', 'coverage/index.html'
    )
    # Arguments avoid Windows PowerShell 5.1 adding CR characters to native stdin.
    $ignoredProbes = @(& git -C $repositoryRoot check-ignore --no-index -- $ignoreProbes)
    if ($LASTEXITCODE -gt 1) { throw 'Git ignore check failed.' }
    foreach ($probe in $ignoreProbes) {
        Assert-Foundation ($ignoredProbes -contains $probe) ('Missing ignore protection: ' + $probe)
    }
    $ignoredVisibleFiles = @(& git -C $repositoryRoot check-ignore --no-index -- $visibleFiles)
    if ($LASTEXITCODE -gt 1) { throw 'Git visibility check failed.' }
    foreach ($path in $ignoredVisibleFiles) {
        Assert-Foundation $false ('Git-visible file conflicts with ignore policy: ' + $path)
    }
    foreach ($path in @('.env.example', 'apps/web/src/lib/.gitkeep', 'infrastructure/secrets/README.md')) {
        Assert-Foundation ($visibleFiles -contains $path) ('Required safe scaffold file is not Git-visible: ' + $path)
    }
    $environmentExample = Join-Path $repositoryRoot '.env.example'
    Assert-Foundation (Test-Path -LiteralPath $environmentExample -PathType Leaf) 'Missing .env.example.'
    if (Test-Path -LiteralPath $environmentExample -PathType Leaf) {
        $placeholderCount = 0
        foreach ($line in (Get-Content -LiteralPath $environmentExample -Encoding UTF8)) {
            if ([string]::IsNullOrWhiteSpace($line) -or $line.TrimStart().StartsWith('#')) { continue }
            Assert-Foundation ($line -cmatch '^[A-Z][A-Z0-9_]*=$') '.env.example must contain empty placeholder assignments only.'
            $placeholderCount++
        }
        Assert-Foundation ($placeholderCount -gt 0) '.env.example has no placeholders.'
    }
    Write-Output ('Checked ignore protections: ' + $ignoreProbes.Count + '; environment example: empty placeholders')

    # Heuristic checks only. Never print matching content or secret values.
    $credentialPatterns = @(
        '-----BEGIN (?:[A-Z0-9]+ )*PRIVATE KEY-----',
        '\b(?:AKIA|ASIA)[A-Z0-9]{16}\b',
        '\b(?:gh[pousr]_[A-Za-z0-9]{30,}|github_pat_[A-Za-z0-9_]{40,})\b',
        '\bsk-(?:proj-|svcacct-)?[A-Za-z0-9_-]{20,}\b',
        '\b[a-z][a-z0-9+.-]*://[^/\s:@]+:[^/\s@]+@',
        '(?im)^[ \t]*[A-Z][A-Z0-9_]*(?:API_KEY|TOKEN|PASSWORD|SECRET|ACCESS_KEY)[ \t]*=[ \t]*[''"]?(?<value>[^\s''"#]+)'
    )
    foreach ($path in $visibleFiles) {
        $fullPath = Join-Path $repositoryRoot $path
        if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
            Assert-Foundation $false ('Git-visible path missing from working tree: ' + $path)
            continue
        }
        $fileText = [IO.File]::ReadAllText($fullPath)
        foreach ($pattern in $credentialPatterns) {
            foreach ($match in [regex]::Matches($fileText, $pattern)) {
                $lineNumber = 1 + [regex]::Matches($fileText.Substring(0, $match.Index), '\n').Count
                Assert-Foundation $false ('Possible credential; inspect locally: ' + $path + ':' + $lineNumber)
            }
        }
    }
    Write-Output ('Credential pattern scan: ' + $visibleFiles.Count + ' Git-visible files; ' + $credentialPatterns.Count + ' pattern groups (limited coverage)')

    if ($failures.Count -gt 0) {
        foreach ($failure in $failures) { Write-Output ('FAIL: ' + $failure) }
        exit 1
    }
    Write-Output 'PASS: static repository foundation checks. Application tests and external integrations were not run.'
    exit 0
}
catch {
    Write-Output ('FAIL: ' + $_.Exception.Message)
    exit 1
}
