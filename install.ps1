<#
  Next Move Theory — canon + skills installer (Windows / PowerShell).
  macOS / Linux users: run install.sh instead.

  Installs INTO the root of your existing project (the folder you run your agent from):
    <target>\Next-Move-Theory-Canon\        the canon (keep this exact name)
    <target>\.claude\skills\<skill>\        skills for Claude Code   (invoke with /nmt-…)
    <target>\.agents\skills\<skill>\        skills for Codex         (invoke with $nmt-…)
    <target>\CLAUDE.md, AGENTS.md           rules injected between markers (your file kept)
    <target>\NextMoveTheory-README.md       this repo's README, renamed

  The skill sources live in this repo under Skills\claude\ and
  Skills\codex\ — the Claude copy is installed verbatim; the Codex copy is
  a separately-maintained, Codex-compatible variant. Existing unrelated skills in
  .claude\skills and .agents\skills are left untouched. Re-running is idempotent.

  Usage:
    # A) one-liner — clones to a temp dir and installs into the CURRENT directory:
    irm https://nextmovetheory.com/install.ps1 | iex

    # B) from a clone of this repo:
    powershell -ExecutionPolicy Bypass -File install.ps1                 # target = parent of the clone
    powershell -ExecutionPolicy Bypass -File install.ps1 -Target DIR     # explicit target project root
    powershell -ExecutionPolicy Bypass -File install.ps1 -Target .       # install in place (current dir)
    powershell -ExecutionPolicy Bypass -File install.ps1 -KeepClone      # keep the clone folder after installing
#>
param(
    [string]$Target,
    [switch]$KeepClone
)

$ErrorActionPreference = 'Stop'

$Utf8NoBom = New-Object System.Text.UTF8Encoding -ArgumentList $false, $true
$RepoUrl = 'https://github.com/zamesin/Next-Move-Theory-Canon-and-Skills'
$StartLocation = (Get-Location).ProviderPath

# Resolve the source (this repo) and whether we must clone it. Running from a
# clone of the repo → use it. Running via the web one-liner
# (irm https://nextmovetheory.com/install.ps1 | iex — no file on disk) → clone to
# a temp dir, exactly as install.sh does for the `curl … | bash` one-liner.
$scriptPath = $MyInvocation.MyCommand.Path
$Cloned = $false
if ($scriptPath -and (Test-Path -LiteralPath (Join-Path (Split-Path -Parent $scriptPath) 'Skills') -PathType Container)) {
    $Source = [System.IO.Path]::GetFullPath((Split-Path -Parent $scriptPath))
    if ([string]::IsNullOrWhiteSpace($Target)) {
        $Target = Split-Path -Parent $Source
    }
} else {
    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        throw 'git is required to install (not found on PATH).'
    }
    $Source = Join-Path ([System.IO.Path]::GetTempPath()) ('nmt-canon-' + [System.Guid]::NewGuid().ToString('N'))
    Write-Host "Cloning $RepoUrl ..."
    & git clone --depth 1 "$RepoUrl.git" $Source 2>&1 | Out-Null
    if (-not (Test-Path -LiteralPath (Join-Path $Source 'Skills') -PathType Container)) {
        throw "clone failed or incomplete at $Source"
    }
    $Cloned = $true
    if ([string]::IsNullOrWhiteSpace($Target)) {
        $Target = $StartLocation
    }
}

if (-not (Test-Path -LiteralPath $Target -PathType Container)) {
    throw "target dir not found: $Target"
}

$Target = (Resolve-Path -LiteralPath $Target).ProviderPath
$Target = [System.IO.Path]::GetFullPath($Target)

if (-not (Test-Path -LiteralPath (Join-Path $Source 'Skills') -PathType Container) -or
    -not (Test-Path -LiteralPath (Join-Path $Source 'Next-Move-Theory-Canon') -PathType Container)) {
    throw "source at $Source does not look like the canon repo (missing Skills/ or Next-Move-Theory-Canon/)."
}

if ([string]::Equals($Source.TrimEnd('\'), $Target.TrimEnd('\'), [System.StringComparison]::OrdinalIgnoreCase)) {
    throw "target equals the repo clone ($Source). Run from your PROJECT ROOT, or pass -Target <your-project-root>."
}

function Read-Utf8Text {
    param([Parameter(Mandatory = $true)][string]$Path)
    return [System.IO.File]::ReadAllText($Path, $Utf8NoBom)
}

function Write-Utf8Text {
    param(
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $true)][string]$Content
    )
    [System.IO.File]::WriteAllText($Path, $Content, $Utf8NoBom)
}

function Quote-PSString {
    param([Parameter(Mandatory = $true)][string]$Text)
    return "'" + $Text.Replace("'", "''") + "'"
}

function Copy-DirectoryContents {
    param(
        [Parameter(Mandatory = $true)][string]$From,
        [Parameter(Mandatory = $true)][string]$To
    )
    if (-not (Test-Path -LiteralPath $To -PathType Container)) {
        New-Item -ItemType Directory -Path $To | Out-Null
    }
    Copy-Item -Path (Join-Path $From '*') -Destination $To -Recurse -Force
}

function Update-RulesFile {
    param(
        [Parameter(Mandatory = $true)][string]$Name,
        [Parameter(Mandatory = $true)][string]$SourceRoot,
        [Parameter(Mandatory = $true)][string]$TargetRoot
    )

    $sourceFile = Join-Path $SourceRoot $Name
    if (-not (Test-Path -LiteralPath $sourceFile -PathType Leaf)) {
        return
    }

    $start = '<!-- Next-Move-Theory-Rules:start -->'
    $end = '<!-- Next-Move-Theory-Rules:end -->'
    $rules = (Read-Utf8Text -Path $sourceFile).TrimEnd()
    $block = "$start`n$rules`n$end`n"
    $targetFile = Join-Path $TargetRoot $Name

    if (Test-Path -LiteralPath $targetFile -PathType Leaf) {
        $current = Read-Utf8Text -Path $targetFile
    } else {
        $current = ''
    }

    if ($current.Contains($start) -and $current.Contains($end)) {
        $pre, $afterStart = $current.Split(@($start), 2, [System.StringSplitOptions]::None)
        $discard, $post = $afterStart.Split(@($end), 2, [System.StringSplitOptions]::None)
        $updated = $pre + $block.TrimEnd("`n") + $post
    } elseif ($current.Trim().Length -gt 0) {
        $updated = $current.TrimEnd() + "`n`n" + $block
    } else {
        $updated = $block
    }

    Write-Utf8Text -Path $targetFile -Content $updated
    Write-Host "  injected rules -> $targetFile"
}

Write-Host 'Installing Next Move Theory canon + skills'
Write-Host "  source: $Source"
Write-Host "  target: $Target"

$canonTarget = Join-Path $Target 'Next-Move-Theory-Canon'
$claudeSkills = Join-Path $Target '.claude\skills'
$codexSkills = Join-Path $Target '.agents\skills'

# 1. Canon at the root (keep the exact name — skills read it by this relative path).
if (Test-Path -LiteralPath $canonTarget) {
    Remove-Item -LiteralPath $canonTarget -Recurse -Force
}
Copy-Item -LiteralPath (Join-Path $Source 'Next-Move-Theory-Canon') -Destination $canonTarget -Recurse -Force

# 2. Skills — the Claude copy to .claude\skills, the Codex copy to .agents\skills.
#    The Codex tree is already Codex-compatible (no install-time patching). Existing
#    unrelated skills in those dirs are left untouched.
New-Item -ItemType Directory -Path $claudeSkills -Force | Out-Null
New-Item -ItemType Directory -Path $codexSkills -Force | Out-Null
Copy-DirectoryContents -From (Join-Path $Source 'Skills\claude') -To $claudeSkills
Copy-DirectoryContents -From (Join-Path $Source 'Skills\codex')  -To $codexSkills

# 3. README, renamed (so it doesn't clobber your project's own README).
Copy-Item -LiteralPath (Join-Path $Source 'README.md') -Destination (Join-Path $Target 'NextMoveTheory-README.md') -Force

# 4. Inject the rules between markers into existing CLAUDE.md and AGENTS.md.
Update-RulesFile -Name 'CLAUDE.md' -SourceRoot $Source -TargetRoot $Target
Update-RulesFile -Name 'AGENTS.md' -SourceRoot $Source -TargetRoot $Target

Write-Host ''
$onboard = @'
============================================================================
  Next Move Theory is installed.   Free and open-source.
============================================================================

  >>  START HERE - run   /nmt-chat   (Claude Code)   or   $nmt-chat   (Codex)

      It's the front door to everything here. Paste whatever you have - a
      rough idea, messy notes, a chat thread, a doc - and it pulls out the
      context and tells you your next move and which skill to run for your
      task. No methodologically-perfect brief required.

      Don't know where to start? That is exactly what /nmt-chat is for.

  --------------------------------------------------------------------------
  All the skills   (Claude Code: /name   |   Codex: $name):

    nmt-chat                    advice + your next move        <- START HERE
    nmt-diagnose                live product: find risks & growth points
    nmt-market-research         new idea: size the market, pick the segment
    nmt-craft-value-proposition turn a segment into a winning value prop
    nmt-product-requirements    turn the value into a build-ready PRD
    nmt-craft-go-to-market      turn the value into landing + ads + growth
    nmt-analyze-interviews      have interviews? extract the Jobs from them

  The four producers form a pipeline - jump in wherever you already are:
    market-research -> craft-value-proposition -> product-requirements
                                              -> craft-go-to-market

  Still unsure which to run? Run /nmt-chat - it routes you to the right one.
  --------------------------------------------------------------------------
'@
Write-Host $onboard
Write-Host ''
Write-Host "  Installed into: $Target"
Write-Host "    Claude skills:  $claudeSkills   (invoke with /nmt-...)"
Write-Host "    Codex skills:   $codexSkills   (invoke with `$nmt-...)"
Write-Host "    canon:          $canonTarget"
Write-Host ("    readme:         " + (Join-Path $Target 'NextMoveTheory-README.md'))
Write-Host ''
$tail = @'
  Codex tip - to let skills ask structured questions outside Plan mode, add
  this experimental feature key to %USERPROFILE%\.codex\config.toml (or to
  .codex\config.toml in a trusted project), then restart Codex:
      [features]
      default_mode_request_user_input = true
  Verified against Codex CLI 0.141.0; if the key is unavailable in your Codex
  version, the skills fall back to asking in chat.

  Update anytime - safe & idempotent (refreshes canon, skills, and rules in
  place; leaves your own files untouched). Re-run the installer from your
  project root.

  Free & open:   https://github.com/zamesin/Next-Move-Theory-Canon-and-Skills
  New releases:  subscribe at https://nextmovetheory.com
'@
Write-Host $tail

# Clean up the clone. For the web one-liner ($Cloned: temp clone) always remove it;
# for a disk clone, remove it only when it sits directly inside the target (the
# `git clone … ; install.ps1 -Target .` flow). Opt out with -KeepClone.
$sourceParent = Split-Path -Parent $Source
$removeClone = $Cloned -or [string]::Equals($sourceParent.TrimEnd('\'), $Target.TrimEnd('\'), [System.StringComparison]::OrdinalIgnoreCase)
if ($removeClone) {
    if ($KeepClone) {
        Write-Host "Clone kept at $Source (remove it manually when you no longer need it)."
    } else {
        Set-Location -LiteralPath $Target
        try {
            Remove-Item -LiteralPath $Source -Recurse -Force
            Write-Host "Removed the clone folder: $Source"
        } catch {
            $engine = (Get-Process -Id $PID).Path
            if ([string]::IsNullOrWhiteSpace($engine)) {
                $engine = Join-Path $PSHOME 'powershell.exe'
            }
            $quotedSource = Quote-PSString -Text $Source
            $cleanupCommand = "Start-Sleep -Seconds 1; Remove-Item -LiteralPath $quotedSource -Recurse -Force"
            Start-Process -FilePath $engine -ArgumentList @('-NoProfile', '-ExecutionPolicy', 'Bypass', '-Command', $cleanupCommand) -WindowStyle Hidden | Out-Null
            Write-Host "Scheduled clone folder removal after installer exits: $Source"
        }
    }
} else {
    Set-Location -LiteralPath $StartLocation
}
