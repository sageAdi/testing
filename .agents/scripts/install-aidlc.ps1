param(
    [string]$TargetDir = "."
)

$ErrorActionPreference = "Stop"

if ($TargetDir -eq "-h" -or $TargetDir -eq "--help") {
    @"
Usage: install-aidlc.ps1 [TARGET_DIR]

Installs the AI-DLC workflow control files into TARGET_DIR.
If TARGET_DIR is omitted, the current directory is used.

This script copies:
  - AGENTS.md
  - .agents/
  - .aidlc-rule-details/
  - README.md

It does not create aidlc-docs/ or application code.
"@
    exit 0
}

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$SourceRoot = Resolve-Path (Join-Path $ScriptDir "..\..")
$TargetRoot = Resolve-Path $TargetDir

$RequiredPaths = @(
    "AGENTS.md",
    ".agents",
    ".aidlc-rule-details"
)

foreach ($Path in $RequiredPaths) {
    if (-not (Test-Path (Join-Path $SourceRoot $Path))) {
        Write-Error "ERROR: source bundle is missing $Path"
        exit 1
    }
}

function Copy-AidlcPath {
    param(
        [string]$SourcePath,
        [string]$TargetPath
    )

    if (Test-Path $TargetPath) {
        Remove-Item -Recurse -Force $TargetPath
    }
    Copy-Item -Recurse -Force $SourcePath $TargetPath
}

if ($SourceRoot.Path -eq $TargetRoot.Path) {
    Write-Host "Source and target are the same directory; validating existing AI-DLC files."
} else {
    Copy-AidlcPath (Join-Path $SourceRoot "AGENTS.md") (Join-Path $TargetRoot "AGENTS.md")
    Copy-AidlcPath (Join-Path $SourceRoot ".agents") (Join-Path $TargetRoot ".agents")
    Copy-AidlcPath (Join-Path $SourceRoot ".aidlc-rule-details") (Join-Path $TargetRoot ".aidlc-rule-details")

    $ReadmePath = Join-Path $SourceRoot "README.md"
    if (Test-Path $ReadmePath) {
        Copy-AidlcPath $ReadmePath (Join-Path $TargetRoot "README.md")
    }
}

$ValidationScripts = @(
    ".agents/scripts/validate-skill-manifests.sh",
    ".agents/scripts/validate-generated-rules.sh",
    ".agents/scripts/validate-approval-gates.sh",
    ".agents/scripts/check-token-budget.sh"
)

$Bash = Get-Command bash -ErrorAction SilentlyContinue
if ($Bash) {
    foreach ($Script in $ValidationScripts) {
        $ScriptPath = Join-Path $TargetRoot $Script
        if (Test-Path $ScriptPath) {
            & $Bash.Source $ScriptPath $TargetRoot
        }
    }
} else {
    Write-Host "bash not found; skipped shell-based validators."
}

Write-Host "AI-DLC workflow installed into $($TargetRoot.Path)"
Write-Host "Start with: Using AI-DLC, [describe the work]"
