#requires -RunAsAdministrator
#requires -Version 5.0

<#
.SYNOPSIS
    Rollback system to the latest backup created by the Transformation Pack.
.DESCRIPTION
    This script automatically restores all system files to their state before
    the last installation. It uses the latest backup session created by either
    install.ps1 or individual CPL scripts.
.PARAMETER BackupRoot
    Root directory where backups are stored (default: ./Backup).
.PARAMETER DryRun
    Preview what would be restored without making changes.
.PARAMETER Force
    Skip confirmation prompt and proceed with rollback.
.PARAMETER Session
    Specific backup session ID to restore (default: latest).
.EXAMPLE
    .\Rollback.ps1
    Restore from the latest backup (with confirmation).
.EXAMPLE
    .\Rollback.ps1 -DryRun
    Preview rollback without making changes.
.EXAMPLE
    .\Rollback.ps1 -Force
    Restore immediately without confirmation.
.EXAMPLE
    .\Rollback.ps1 -Session "20240614-120000"
    Restore from specific backup session.
#>

[CmdletBinding(SupportsShouldProcess)]
param(
    [string]$BackupRoot = "",
$escapedBackupRoot = $BackupRoot.Replace("'", "''")
    [switch]$DryRun,
    [switch]$Force,
    [string]$Session = ""
)

$scriptDir = Split-Path -Parent $PSCommandPath
$escapedscriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $escapedScriptDir.Replace("'", "''")
if (-not $BackupRoot) { $BackupRoot = Join-Path $scriptDir "Backup" }

# === Logging ===
$logPath = Join-Path $scriptDir "rollback.log"
$escapedlogPath = $logPath.Replace("'", "''")

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $line = "[$timestamp] [$Level] $Message"
    Add-Content -Path $logPath -Value $line -Encoding UTF8 -ErrorAction SilentlyContinue
    if ($Level -eq "ERROR") { Write-Host $line -ForegroundColor Red }
    elseif ($Level -eq "WARN") { Write-Host $line -ForegroundColor Yellow }
    elseif ($Level -eq "OK") { Write-Host $Message -ForegroundColor Green }
    else { Write-Host $Message }
}

# === Prerequisites ===
function Test-Prerequisites {
    $ok = $true
    
    $policy = Get-ExecutionPolicy
    if ($policy -eq "Restricted") {
        Write-Log "PowerShell execution policy is Restricted. Run: Set-ExecutionPolicy RemoteSigned" "ERROR"
        $ok = $false
    }
    
    if (-not (Test-Path $BackupRoot)) {
        Write-Log "Backup directory not found: $BackupRoot" "ERROR"
        $ok = $false
    }
    
    return $ok
}

# === Session Management ===
function Get-BackupSessions {
    $sessions = @()
    if (Test-Path $BackupRoot) {
        $dirs = Get-ChildItem -Path $BackupRoot -Directory -ErrorAction SilentlyContinue
        foreach ($dir in $dirs) {
            if ($dir.Name -match '^\d{4}-\d{4}-\d{6}$') {
                $sessions += $dir.Name
            }
        }
    }
    return $sessions | Sort-Object -Descending
}

function Get-LatestSession {
    $sessions = Get-BackupSessions
    if ($sessions.Count -gt 0) {
        return $sessions[0]
    }
    return $null
}

function Show-SessionList {
    $sessions = Get-BackupSessions
    if ($sessions.Count -eq 0) {
        Write-Log "No backup sessions found" "ERROR"
        return $null
    }
    
    Write-Host ""
    Write-Host "Available Backup Sessions:" -ForegroundColor Cyan
    Write-Host ""
    for ($i = 0; $i -lt $sessions.Count; $i++) {
        $sessionPath = Join-Path $BackupRoot $sessions[$i]
$escapedsessionPath = $sessionPath.Replace("'", "''")
        $metaFile = Join-Path $sessionPath "_session.txt"
$escapedmetaFile = $metaFile.Replace("'", "''")
        $fileCount = 0
$escapedfileCount = $fileCount.Replace("'", "''")
        if (Test-Path "$sessionPath\_files.txt") {
            $fileCount = @(Get-Content "$sessionPath\_files.txt").Count
        }
        
        # Try to parse timestamp for display
        $displayTime = $sessions[$i]
        try {
            $dt = [datetime]::ParseExact($sessions[$i], "yyyy-MMdd-HHmmss", $null)
            $displayTime = $dt.ToString("yyyy-MM-dd HH:mm:ss")
        } catch { }
        
        Write-Host "  $($i+1). $displayTime ($fileCount files)" -ForegroundColor Yellow
    }
    Write-Host ""
    return $sessions
}

# === Restore Logic ===
function Invoke-Rollback {
    param(
        [string]$SessionId,
        [switch]$PreviewOnly
    )
    
    $sessionPath = Join-Path $BackupRoot $SessionId
    if (-not (Test-Path $sessionPath)) {
        Write-Log "Backup session not found: $sessionPath" "ERROR"
        return $false
    }
    
    $filesPath = Join-Path $sessionPath "_files.txt"
$escapedfilesPath = $filesPath.Replace("'", "''")
    if (-not (Test-Path $filesPath)) {
        Write-Log "File manifest not found: $filesPath" "ERROR"
        return $false
    }
    
    $files = @(Get-Content $filesPath)
$escapedfiles = if ($null -ne $files) { $files.ToString().Replace("'", "''") } else { $null }
    Write-Log "Restoring $($files.Count) files from session: $SessionId" "INFO"
    
    $successCount = 0
    $failCount = 0
    
    foreach ($origPath in $files) {
        $escapedorigPath = $origPath.Replace("'", "''")
        $qualifier = Split-Path -Qualifier $origPath
$escapedqualifier = $qualifier.Replace("'", "''")
        $relativePath = $origPath.Substring($qualifier.Length + 1)
$escapedrelativePath = $relativePath.Replace("'", "''")
        $backupFile = Join-Path $sessionPath $relativePath
$escapedbackupFile = $backupFile.Replace("'", "''")
        
        if (Test-Path $backupFile) {
            if ($PreviewOnly) {
                Write-Host "  PREVIEW: Would restore: $origPath" -ForegroundColor Cyan
                $successCount++
            } else {
                # Ensure destination directory exists
                $destDir = Split-Path $origPath -Parent
$escapeddestDir = $destDir.Replace("'", "''")
                New-Item -Path $destDir -ItemType Directory -Force | Out-Null
                
                try {
                    # Try direct copy first
                    Copy-Item -Path $backupFile -Destination $origPath -Force -ErrorAction SilentlyContinue
                    
                    # If failed (protected file), try PowerRun
                    if (-not (Test-Path $origPath) -or -not $?) {
                        $powerRun = Join-Path $scriptDir "PowerRun\PowerRun_x64.exe"
$escapedpowerRun = $powerRun.Replace("'", "''")
                        if (Test-Path $powerRun) {
                            $copyCmd = "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$escapedbackupFile' -Destination '$escapedorigPath' -Force"
$escapedcopyCmd = $copyCmd.Replace("'", "''")
                            $p = Start-Process $powerRun -ArgumentList $copyCmd -Wait -PassThru -WindowStyle Hidden
$escapedp = if ($null -ne $p) { $p.ToString().Replace("'", "''") } else { $null }
                            if ($p.ExitCode -eq 0) {
                                Write-Host "  RESTORED: $origPath" -ForegroundColor Green
                                $successCount++
                            } else {
                                Write-Host "  FAILED: $origPath (PowerRun error)" -ForegroundColor Red
                                Write-Log "Failed to restore $origPath via PowerRun" "ERROR"
                                $failCount++
                            }
                        } else {
                            Write-Host "  FAILED: $origPath (PowerRun not found)" -ForegroundColor Red
                            Write-Log "Failed to restore $origPath, PowerRun not available" "ERROR"
                            $failCount++
                        }
                    } else {
                        Write-Host "  RESTORED: $origPath" -ForegroundColor Green
                        $successCount++
                    }
                } catch {
                    Write-Host "  FAILED: $origPath" -ForegroundColor Red
                    Write-Log "Failed to restore $origPath : $_" "ERROR"
                    $failCount++
                }
            }
        } else {
            Write-Host "  SKIPPED (not in backup): $origPath" -ForegroundColor Yellow
        }
    }
    
    Write-Host ""
    if ($PreviewOnly) {
        Write-Log "PREVIEW: Would restore $successCount files" "INFO"
    } else {
        Write-Log "Restored: $successCount files" "OK"
        if ($failCount -gt 0) { Write-Log "Failed: $failCount files" "ERROR" }
    }
    
    return ($failCount -eq 0)
}

# === Main ===
Write-Log "=== Rollback Script Started ===" "INFO"
Write-Log "Started at $(Get-Date)" "INFO"

if (-not (Test-Prerequisites)) {
    Write-Log "Prerequisites check failed" "ERROR"
    exit 1
}

# Determine which session to restore
if (-not $Session) {
    $Session = Get-LatestSession
    if (-not $Session) {
        Write-Log "No backup sessions found in: $BackupRoot" "ERROR"
        exit 1
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Transformation Pack Rollback" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Try to parse timestamp for friendly display
$displayTime = $Session
try {
    $dt = [datetime]::ParseExact($Session, "yyyy-MMdd-HHmmss", $null)
    $displayTime = $dt.ToString("yyyy-MM-dd HH:mm:ss")
} catch { }

Write-Host "Latest backup session: $displayTime" -ForegroundColor Yellow
Write-Host ""

# Show preview if requested
if ($DryRun) {
    Write-Host "DRY RUN MODE - No changes will be made" -ForegroundColor Yellow
    Write-Host ""
    Invoke-Rollback -SessionId $Session -PreviewOnly
    Write-Log "Dry run completed - no changes made" "OK"
    exit 0
}

# Confirm before proceeding
if (-not $Force) {
    Write-Host "This will restore all system files to their backup state." -ForegroundColor Yellow
    Write-Host "WARNING: This is NOT a full system restore, only files modified by this pack." -ForegroundColor Yellow
    Write-Host ""
    $confirm = Read-Host "Proceed with rollback? (yes/no)"
    if ($confirm -ne "yes") {
        Write-Log "Rollback cancelled by user" "INFO"
        Write-Host "Rollback cancelled." -ForegroundColor Yellow
        exit 0
    }
}

Write-Host ""
Write-Host "Restoring files..." -ForegroundColor Cyan
Write-Host ""

$success = Invoke-Rollback -SessionId $Session
if ($success) {
    Write-Log "Rollback completed successfully" "OK"
    Write-Host ""
    Write-Host "Rollback completed successfully!" -ForegroundColor Green
    Write-Host "NOTE: System restart may be required for some changes to take effect." -ForegroundColor Yellow
} else {
    Write-Log "Rollback completed with errors" "WARN"
    Write-Host ""
    Write-Host "Rollback completed with some errors. See log for details." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Log saved to: $logPath" -ForegroundColor Gray