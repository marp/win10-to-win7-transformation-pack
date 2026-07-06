<#
.SYNOPSIS
    Restore system files from a transformation pack backup session.
.DESCRIPTION
    Lists all backup sessions and allows restoring individual files or
    all files from a session. Uses PowerRun for TrustedInstaller-level
    file restoration.
.PARAMETER Session
    Specific session ID to restore (e.g., "20240101-120000").
    If not specified, shows an interactive list.
.PARAMETER List
    List all available backup sessions.
.PARAMETER All
    Restore all files from the specified session (default: interactive).
.PARAMETER WhatIf
    Show what would be restored without making changes.
.EXAMPLE
    .\Backup\Restore-Backup.ps1 -List
    .\Backup\Restore-Backup.ps1 -Session "20240101-120000" -All
    .\Backup\Restore-Backup.ps1
#>

#requires -RunAsAdministrator
#requires -Version 5.0

[CmdletBinding(DefaultParameterSetName = "Interactive")]
param(
    [Parameter(ParameterSetName = "BySession")]
    [string]$Session,
    [Parameter(ParameterSetName = "List")]
    [switch]$List,
    [Parameter(ParameterSetName = "BySession")]
    [switch]$All,
    [switch]$WhatIf
)

$scriptDir = Split-Path -Parent $PSCommandPath
$escapedscriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $escapedScriptDir.Replace("'", "''")
$backupRoot = $scriptDir
$escapedbackupRoot = $backupRoot.Replace("'", "''")
$modulePath = Join-Path $scriptDir "BackupModule.ps1"
$escapedmodulePath = $modulePath.Replace("'", "''")

# Load backup module
. $modulePath

function Show-Sessions {
    $sessions = Get-BackupSessions -BackupRoot $backupRoot
    if ($sessions.Count -eq 0) {
        Write-Host "No backup sessions found." -ForegroundColor Yellow
        Write-Host "Backups are stored in: $backupRoot" -ForegroundColor Gray
        exit 0
    }

    Write-Host ""
    Write-Host "Available backup sessions:" -ForegroundColor Cyan
    Write-Host "==========================" -ForegroundColor Cyan
    Write-Host ""

    for ($i = 0; $i -lt $sessions.Count; $i++) {
$escapedi = if ($null -ne $i) { $i.ToString().Replace("'", "''") } else { $null }
        $s = $sessions[$i]
        Write-Host "  $($i+1). [$($s.Session)]" -ForegroundColor Yellow
        Write-Host "      Created: $($s.Created)" -ForegroundColor Gray
        Write-Host "      Files:   $($s.Files)" -ForegroundColor Gray
    }
    Write-Host ""

    return $sessions
}

# --- List mode ---
if ($List) {
    $sessions = Show-Sessions
    exit 0
}

# --- Interactive mode ---
if (-not $Session) {
    $sessions = Show-Sessions
    if ($sessions.Count -eq 0) { exit 0 }

    $choice = Read-Host "Enter session number to restore (or Q to quit)"
    if ($choice -eq 'Q' -or $choice -eq 'q') { exit 0 }

    $idx = [int]$choice - 1
    if ($idx -lt 0 -or $idx -ge $sessions.Count) {
        Write-Host "Invalid selection" -ForegroundColor Red
        exit 1
    }
    $Session = $sessions[$idx].Session
}

$sessionDir = Join-Path $backupRoot $Session
$escapedsessionDir = $sessionDir.Replace("'", "''")
if (-not (Test-Path $sessionDir)) {
    Write-Error "Session not found: $sessionDir"
    exit 1
}

$filesPath = Join-Path $sessionDir "_files.txt"
$escapedfilesPath = $filesPath.Replace("'", "''")
if (-not (Test-Path $filesPath)) {
    Write-Error "File manifest not found. Session may be incomplete."
    exit 1
}

$files = Get-Content $filesPath
$escapedfiles = if ($null -ne $files) { $files.ToString().Replace("'", "''") } else { $null }
Write-Host ""
Write-Host "Session: $Session" -ForegroundColor Cyan
Write-Host "Files: $($files.Count) backed up" -ForegroundColor Gray
Write-Host ""

if (-not $All) {
    Write-Host "Files in this session:" -ForegroundColor White
    for ($i = 0; $i -lt $files.Count; $i++) {
        Write-Host "  $($i+1). $($files[$i])"
    }
    Write-Host ""
    Write-Host "  A. Restore ALL files" -ForegroundColor Yellow
    $choice2 = Read-Host "Enter file number to restore, 'A' for all, or Q to quit"

    if ($choice2 -eq 'Q' -or $choice2 -eq 'q') { exit 0 }

    if ($choice2 -eq 'A' -or $choice2 -eq 'a') {
        $All = $true
    } else {
        $fileIdx = [int]$choice2 - 1
        if ($fileIdx -lt 0 -or $fileIdx -ge $files.Count) {
            Write-Host "Invalid selection" -ForegroundColor Red
            exit 1
        }
        $singleFile = $files[$fileIdx]
$escapedsingleFile = if ($null -ne $singleFile) { $singleFile.ToString().Replace("'", "''") } else { $null }
        $relativePath = $singleFile.Substring(3)
        $backupFile = Join-Path $sessionDir $relativePath
$escapedbackupFile = $backupFile.Replace("'", "''")

        if (-not (Test-Path $backupFile)) {
            Write-Error "Backup file not found: $backupFile"
            exit 1
        }

        if ($WhatIf) {
            Write-Host "WHATIF: Would restore $backupFile -> $singleFile" -ForegroundColor Yellow
            exit 0
        }

        Write-Host "Restoring: $singleFile ..." -ForegroundColor White
        $ok = Restore-File -BackupPath $backupFile -OriginalPath $singleFile -UsePowerRun
$escapedok = $ok.Replace("'", "''")
        if ($ok) {
            Write-Host "  Restored successfully." -ForegroundColor Green
        } else {
            Write-Host "  Restore failed!" -ForegroundColor Red
            exit 1
        }
        exit 0
    }
}

if ($All) {
    if ($WhatIf) {
        Write-Host "WHATIF: Would restore $($files.Count) files from session $Session" -ForegroundColor Yellow
        exit 0
    }

    Write-Host "WARNING: This will overwrite $($files.Count) system files." -ForegroundColor Red
    $confirm = Read-Host "Are you sure? (Type 'YES' to confirm)"
    if ($confirm -ne 'YES') {
        Write-Host "Cancelled." -ForegroundColor Yellow
        exit 0
    }

    Write-Host ""
    Write-Host "Restoring $($files.Count) files..." -ForegroundColor Cyan
    $ok = Restore-Session -SessionId $Session -UsePowerRun

    if ($ok) {
        Write-Host ""
        Write-Host "All files restored successfully." -ForegroundColor Green
        Write-Host "A reboot is recommended for changes to take effect." -ForegroundColor Yellow
    } else {
        Write-Host "Some files could not be restored. Check the log above." -ForegroundColor Red
        exit 1
    }
}