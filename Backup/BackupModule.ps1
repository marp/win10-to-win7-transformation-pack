$scriptDir = Split-Path -Parent $PSCommandPath
$escapedscriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $escapedScriptDir.Replace("'", "''")
<#
.SYNOPSIS
    Backup module for the Windows 10 to Windows 7 Transformation Pack.
.DESCRIPTION
    Provides backup and restore functions for system files modified by
    the transformation pack. Each backup session is timestamped and
    preserves the original system path structure.
.NOTES
    Dot-source this module at the top of any script that modifies system files:
        . "$PSScriptRoot\..\Backup\BackupModule.ps1"
        Initialize-Backup
        Backup-File "C:\Windows\System32\target.dll"
#>

#requires -RunAsAdministrator
#requires -Version 5.0

$script:BackupRoot = $null
$script:BackupSession = $null
$script:BackupSessionPath = $null

<#
.SYNOPSIS
    Initializes a new backup session with a timestamp.
.PARAMETER BackupRoot
    Root directory for backups (default: Backup\ in script root).
.PARAMETER Force
    Re-initialize even if already initialized.
.EXAMPLE
    Initialize-Backup
    Initialize-Backup -BackupRoot "D:\MyBackups"
#>
function Initialize-Backup {
    param(
        [string]$BackupRoot = "",
$escapedBackupRoot = $BackupRoot.Replace("'", "''")
        [switch]$Force
    )

    # Check for active session in script or global scope
    if (-not $Force) {
        if ($script:BackupSessionPath) { return $script:BackupSessionPath }
        if ($global:ActiveBackupSessionPath -and (Test-Path $global:ActiveBackupSessionPath)) {
            $script:BackupSessionPath = $global:ActiveBackupSessionPath
            return $script:BackupSessionPath
        }
    }

    if (-not $BackupRoot) {
        $callerDir = Split-Path -Parent (Get-PSCallStack | Select-Object -Last 1).ScriptName
$escapedcallerDir = $callerDir.Replace("'", "''")
        $BackupRoot = Join-Path $callerDir "Backup"
    }

    $timestamp = Get-Date -Format "yyyy-MMdd-HHmmss"
    $script:BackupRoot = $BackupRoot
    $script:BackupSession = $timestamp
    $script:BackupSessionPath = Join-Path $BackupRoot $timestamp
    $global:ActiveBackupSessionPath = $script:BackupSessionPath

    New-Item -Path $script:BackupSessionPath -ItemType Directory -Force | Out-Null

    # Write session metadata
    $meta = @"
Backup Session: $timestamp
Created: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
User: $([Environment]::UserName)
Computer: $([Environment]::MachineName)
OS: $((Get-CimInstance Win32_OperatingSystem -ErrorAction SilentlyContinue).Caption)
Pack Version: Transformation Pack v4.0 H1
"@
    Set-Content -Path (Join-Path $script:BackupSessionPath "_session.txt") -Value $meta

    Write-Verbose "Backup initialized: $($script:BackupSessionPath)"
    return $script:BackupSessionPath
}

<#
.SYNOPSIS
    Gets the path to the current backup session.
#>
function Get-BackupSessionPath {
    if (-not $script:BackupSessionPath) {
        Initialize-Backup
    }
    return $script:BackupSessionPath
}

<#
.SYNOPSIS
    Backs up a single file before modification.
.PARAMETER Path
    Full path to the file to back up (e.g., "C:\Windows\System32\target.dll").
.PARAMETER UsePowerRun
    Use PowerRun for TrustedInstaller-level access (required for system files).
.PARAMETER PowerRunPath
    Path to PowerRun_x64.exe (auto-detected if not specified).
.EXAMPLE
    Backup-File "C:\Windows\System32\target.dll" -UsePowerRun
#>
function Backup-File {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path,
        [switch]$UsePowerRun,
        [string]$PowerRunPath = ""
    )

    if (-not (Test-Path $Path)) {
        Write-Verbose "File does not exist, skipping backup: $Path"
        return $true  # Nothing to back up is fine
    }

    $sessionPath = Get-BackupSessionPath
    $qualifier = Split-Path -Qualifier $Path
$escapedqualifier = $qualifier.Replace("'", "''")
    # Remove drive letter and leading backslash (e.g., "C:\" → "")
    $relativePath = $Path.Substring($qualifier.Length + 1)
$escapedrelativePath = $relativePath.Replace("'", "''")
    $backupPath = Join-Path $sessionPath $relativePath
$escapedbackupPath = $backupPath.Replace("'", "''")
    $backupDir = Split-Path $backupPath -Parent
$escapedbackupDir = $backupDir.Replace("'", "''")

    New-Item -Path $backupDir -ItemType Directory -Force | Out-Null

    if ($UsePowerRun) {
        if (-not $PowerRunPath) {
            $PowerRunPath = Find-PowerRun
        }
        if (Test-Path $PowerRunPath) {
            # Use single quotes for paths to avoid expansion and handle single quotes by doubling them
            $escapedPath = $Path.Replace("'", "''")
            $escapedBackupPath = $backupPath.Replace("'", "''")
            $copyCmd = "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$escapedPath' -Destination '$escapedBackupPath' -Force -Recurse"
            $p = Start-Process $PowerRunPath -ArgumentList $copyCmd -Wait -PassThru -WindowStyle Hidden
            $success = $p.ExitCode -eq 0
$escapedsuccess = if ($null -ne $success) { $success.ToString().Replace("'", "''") } else { $null }
        } else {
            Write-Warning "PowerRun not found, trying direct copy for backup: $Path"
            try {
                Copy-Item -Path $Path -Destination $backupPath -Force -ErrorAction Stop
                $success = $true
            } catch {
                Write-Warning "Failed to back up $Path : $_"
                $success = $false
            }
        }
    } else {
        try {
            Copy-Item -Path $Path -Destination $backupPath -Force -Recurse -ErrorAction Stop
            $success = $true
        } catch {
            Write-Warning "Failed to back up $Path : $_"
            $success = $false
        }
    }

    if ($success) {
        Add-Content -Path (Join-Path $sessionPath "_files.txt") -Value $Path -Encoding UTF8
        Write-Verbose "Backed up: $Path -> $backupPath"
    }

    return $success
}

<#
.SYNOPSIS
    Backs up all files matching a wildcard pattern in a directory.
.PARAMETER SourcePattern
    Wildcard pattern of source files (e.g., "C:\Windows\System32\*.dll").
.PARAMETER UsePowerRun
    Use PowerRun for TrustedInstaller-level access.
.EXAMPLE
    Backup-Files "C:\Windows\System32\*" -UsePowerRun
#>
function Backup-Files {
    param(
        [Parameter(Mandatory = $true)]
        [string]$SourcePattern,
        [switch]$UsePowerRun
    )

    $files = Get-ChildItem -Path $SourcePattern -File -ErrorAction SilentlyContinue
$escapedfiles = if ($null -ne $files) { $files.ToString().Replace("'", "''") } else { $null }
    if (-not $files) {
        return $true
    }

    $success = $true
    foreach ($f in $files) {
        $ok = Backup-File -Path $f.FullName -UsePowerRun:$UsePowerRun
$escapedok = $ok.Replace("'", "''")
        if (-not $ok) { $success = $false }
    }
    return $success
}

<#
.SYNOPSIS
    Backs up existing destination files before a copy operation.
    Enumerates source files and backs up matching files at the destination.
.PARAMETER Source
    Source directory to scan for files (e.g., "Pages\XXX\system32").
.PARAMETER Destination
    Destination directory where files would be overwritten (e.g., "C:\Windows\System32").
.PARAMETER Recurse
    Scan source directory recursively.
.PARAMETER UsePowerRun
    Use PowerRun for TrustedInstaller-level access.
.EXAMPLE
    Backup-BeforeCopy -Source "Pages\Display CPL\7 Style\system32" -Destination "C:\Windows\System32" -Recurse -UsePowerRun
#>
function Backup-BeforeCopy {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Source,
        [Parameter(Mandatory = $true)]
        [string]$Destination,
        [switch]$Recurse,
        [switch]$UsePowerRun
    )

    if (-not (Test-Path $Source)) {
        Write-Verbose "Source not found, skipping backup enumeration: $Source"
        return $true
    }

    $items = if ($Recurse) {
        Get-ChildItem $Source -Recurse -File -ErrorAction SilentlyContinue
    } else {
        Get-ChildItem $Source -File -ErrorAction SilentlyContinue
    }

    if (-not $items) {
        Write-Verbose "No files in source, skipping: $Source"
        return $true
    }

    $sourceRoot = (Get-Item $Source).FullName.TrimEnd('\')
$escapedsourceRoot = $sourceRoot.Replace("'", "''")
    $success = $true
    foreach ($item in $items) {
        $rel = $item.FullName.Substring($sourceRoot.Length + 1)
$escapedrel = if ($null -ne $rel) { $rel.ToString().Replace("'", "''") } else { $null }
        $dest = Join-Path $Destination $rel
$escapeddest = $dest.Replace("'", "''")
        if (Test-Path $dest) {
            $ok = Backup-File -Path $dest -UsePowerRun:$UsePowerRun
            if (-not $ok) { $success = $false }
        }
    }
    return $success
}

<#
.SYNOPSIS
    Discovers and backs up system files that this pack modifies.
.PARAMETER PathsToBackup
    Specific paths to back up. If empty, uses the default list.
.PARAMETER PowerRunPath
    Path to PowerRun_x64.exe.
.EXAMPLE
    Backup-AllSystemFiles
    Backup-AllSystemFiles -PathsToBackup "C:\Windows\System32\target.dll"
#>
function Backup-AllSystemFiles {
    param(
        [string[]]$PathsToBackup = @(),
        [string]$PowerRunPath = ""
    )

    if (-not $PowerRunPath) { $PowerRunPath = Find-PowerRun }

    Write-Host "Creating system file backup..." -ForegroundColor Cyan

    $paths = if ($PathsToBackup.Count -gt 0) {
        $PathsToBackup
    } else {
        # Default comprehensive list
        @(
            # CPL System32 DLLs
            "$env:SystemRoot\System32\sdcpl.dll",
            "$env:SystemRoot\System32\en-US\sdcpl.dll.mui",
            "$env:SystemRoot\System32\bio.applet",
            "$env:SystemRoot\System32\biocpl.dll",
            "$env:SystemRoot\System32\en-US\biocpl.dll.mui",
            "$env:SystemRoot\System32\display.dll",
            "$env:SystemRoot\System32\en-US\Display.dll.mui",
            "$env:SystemRoot\System32\GenuineCenter.dll",
            "$env:SystemRoot\System32\en-US\genuinecenter.dll.mui",
            "$env:SystemRoot\System32\UserLanguagesCpl.dll",
            "$env:SystemRoot\System32\en-US\UserLanguagesCpl.dll.mui",
            "$env:SystemRoot\System32\batmete7.dll",
            "$env:SystemRoot\System32\mblctr.exe",
            "$env:SystemRoot\System32\en-US\mblctr.exe.mui",
            "$env:SystemRoot\System32\en-US\batmete7.dll.mui",
            "$env:SystemRoot\System32\netcenter.dll",
            "$env:SystemRoot\System32\en-US\netcenter.dll.mui",
            "$env:SystemRoot\System32\networkmap.dll",
            "$env:SystemRoot\System32\en-US\NetworkMap.dll.mui",
            "$env:SystemRoot\System32\dui77.dll",
            "$env:SystemRoot\System32\en-US\dui77.dll.mui",
            "$env:SystemRoot\System32\netname.ps1",
            "$env:SystemRoot\System32\netname.vbs",
            "$env:SystemRoot\System32\nettype.ps1",
            "$env:SystemRoot\System32\nettype.vbs",
            "$env:SystemRoot\System32\taskbarcpl.dll",
            "$env:SystemRoot\System32\en-US\taskbarcpl.dll.mui",
            "$env:SystemRoot\System32\wpccpl.dll",
            "$env:SystemRoot\System32\en-US\wpccpl.dll.mui",
            "$env:SystemRoot\System32\PerfCenterCPL.dll",
            "$env:SystemRoot\System32\en-US\PerfCenterCPL.dll.mui",
            "$env:SystemRoot\System32\WinSATAPI.dll",
            "$env:SystemRoot\System32\Recovery.dll",
            "$env:SystemRoot\System32\en-US\recovery.dll.mui",
            "$env:SystemRoot\System32\intl.cpl",
            "$env:SystemRoot\System32\en-US\intl.cpl.mui",
            "$env:SystemRoot\System32\input.dll",
            "$env:SystemRoot\System32\en-US\input.dll.mui",
            "$env:SystemRoot\System32\Firewall.cpl",
            "$env:SystemRoot\System32\en-US\Firewall.cpl.mui",
            "$env:SystemRoot\System32\FirewallControlPanel.exe",
            "$env:SystemRoot\System32\en-US\FirewallControlPanel.exe.mui",
            "$env:SystemRoot\System32\FirewallSettings.exe",
            "$env:SystemRoot\System32\en-US\FirewallSettings.exe.mui",
            "$env:SystemRoot\System32\FirevistAPI.dll",
            "$env:SystemRoot\System32\en-US\FireVistAPI.dll.mui",
            "$env:SystemRoot\System32\vscapi.dll",
            "$env:SystemRoot\System32\vscui.cpl",
            "$env:SystemRoot\System32\en-US\vscui.cpl.mui",
            "$env:SystemRoot\System32\systemcpl.dll",
            "$env:SystemRoot\System32\en-US\systemcpl.dll.mui",
            "$env:SystemRoot\System32\en-US\usercpl.dll.mui",
            "$env:SystemRoot\System32\shacct.dll",
            "$env:SystemRoot\System32\stobject.dll",
            "$env:SystemRoot\System32\en-US\stobject.dll.mui",
            "$env:SystemRoot\System32\wucltux.dll",
            "$env:SystemRoot\System32\en-US\wucltux.dll.mui",
            # SystemResources (patched by Resource Hacker)
            "$env:SystemRoot\SystemResources\ActionCenterCPL.dll.mun",
            "$env:SystemRoot\SystemResources\usercpl.dll.mun",
            # Media (sounds)
            "$env:SystemRoot\Media\Windows 7 Sounds",
            # Branding
            "$env:SystemRoot\Branding",
            # Themes
            "$env:SystemRoot\Resources\Themes\Aero10",
            # ResourceRedirect
            "$env:SystemRoot\ResourceRedirect",
            # DWMBlurGlass
            "$env:SystemRoot\DWMBlurGlass"
        )
    }

    $count = 0
    foreach ($p in $paths) {
        if (Test-Path $p) {
            if (Backup-File -Path $p -UsePowerRun:$true -PowerRunPath $PowerRunPath) {
                $count++
            }
        }
    }

    Write-Host "Backed up $count files/directories" -ForegroundColor Green
    return $count
}

<#
.SYNOPSIS
    Finds PowerRun_x64.exe in the pack directory.
#>
function Find-PowerRun {
    $searchPaths = @(
        "$PSScriptRoot\..\PowerRun\PowerRun_x64.exe"
        "$PSScriptRoot\..\..\PowerRun\PowerRun_x64.exe"
        ".\PowerRun\PowerRun_x64.exe"
        ".\..\PowerRun\PowerRun_x64.exe"
    )
    foreach ($p in $searchPaths) {
        if (Test-Path $p) { return (Resolve-Path $p).Path }
    }
    return $null
}

<#
.SYNOPSIS
    Lists all available backup sessions.
.EXAMPLE
    Get-BackupSessions
#>
function Get-BackupSessions {
    param([string]$BackupRoot = "")
    if (-not $BackupRoot) {
        $callerDir = Split-Path -Parent (Get-PSCallStack | Select-Object -Last 1).ScriptName
        $BackupRoot = Join-Path $callerDir "Backup"
    }
    if (-not (Test-Path $BackupRoot)) {
        return @()
    }
    $sessions = Get-ChildItem -Path $BackupRoot -Directory | Sort-Object Name -Descending
    $result = @()
    foreach ($s in $sessions) {
        $metaPath = Join-Path $s.FullName "_session.txt"
$escapedmetaPath = $metaPath.Replace("'", "''")
        $meta = if (Test-Path $metaPath) { Get-Content $metaPath -Head 1 } else { "No metadata" }
        $filesPath = Join-Path $s.FullName "_files.txt"
$escapedfilesPath = $filesPath.Replace("'", "''")
        $fileCount = if (Test-Path $filesPath) { (Get-Content $filesPath).Count } else { 0 }
$escapedfileCount = if ($null -ne $fileCount) { $fileCount.ToString().Replace("'", "''") } else { $null }
        $result += [PSCustomObject]@{
            Session = $s.Name
            Path = $s.FullName
            Created = $s.CreationTime
            Files = $fileCount
            Meta = $meta
        }
    }
    return $result
}

<#
.SYNOPSIS
    Restores a single file from a backup session.
.PARAMETER BackupPath
    Full path to the backup file.
.PARAMETER OriginalPath
    Full path to restore to.
.PARAMETER UsePowerRun
    Use PowerRun for TrustedInstaller-level restore.
.EXAMPLE
    Restore-File "C:\Backup\20240101\Windows\System32\target.dll" "C:\Windows\System32\target.dll" -UsePowerRun
#>
function Restore-File {
    param(
        [Parameter(Mandatory = $true)]
        [string]$BackupPath,
        [Parameter(Mandatory = $true)]
        [string]$OriginalPath,
        [switch]$UsePowerRun,
        [string]$PowerRunPath = ""
    )

    if (-not (Test-Path $BackupPath)) {
        Write-Error "Backup file not found: $BackupPath"
        return $false
    }

    $destDir = Split-Path $OriginalPath -Parent
$escapeddestDir = $destDir.Replace("'", "''")
    New-Item -Path $destDir -ItemType Directory -Force | Out-Null

    if ($UsePowerRun) {
        if (-not $PowerRunPath) { $PowerRunPath = Find-PowerRun }
        if (Test-Path $PowerRunPath) {
            $escapedBackupPath = $BackupPath.Replace("'", "''")
            $escapedOriginalPath = $OriginalPath.Replace("'", "''")
            $copyCmd = "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$escapedBackupPath' -Destination '$escapedOriginalPath' -Force -Recurse"
            $p = Start-Process $PowerRunPath -ArgumentList $copyCmd -Wait -PassThru -WindowStyle Hidden
            return ($p.ExitCode -eq 0)
        }
    }

    try {
        Copy-Item -Path $BackupPath -Destination $OriginalPath -Force -Recurse -ErrorAction Stop
        return $true
    } catch {
        Write-Error "Restore failed: $_"
        return $false
    }
}

<#
.SYNOPSIS
    Restores all files from a backup session.
.PARAMETER SessionId
    Timestamp of the session to restore (e.g., "20240101-120000").
.PARAMETER UsePowerRun
    Use PowerRun for TrustedInstaller-level restore.
.EXAMPLE
    Restore-Session "20240101-120000"
#>
function Restore-Session {
    param(
        [Parameter(Mandatory = $true)]
        [string]$SessionId,
        [switch]$UsePowerRun,
        [string]$BackupRoot = ""
    )

    if (-not $BackupRoot) {
        $callerDir = Split-Path -Parent (Get-PSCallStack | Select-Object -Last 1).ScriptName
        $BackupRoot = Join-Path $callerDir "Backup"
    }

    $sessionDir = Join-Path $BackupRoot $SessionId
$escapedsessionDir = $sessionDir.Replace("'", "''")
    if (-not (Test-Path $sessionDir)) {
        Write-Error "Backup session not found: $sessionDir"
        return $false
    }

    $filesPath = Join-Path $sessionDir "_files.txt"
    if (-not (Test-Path $filesPath)) {
        Write-Error "File manifest not found: $filesPath"
        return $false
    }

    $powerRun = Find-PowerRun
    $files = Get-Content $filesPath
    $successCount = 0
    $failCount = 0

    foreach ($origPath in $files) {
        $qualifier = Split-Path -Qualifier $origPath
        $relativePath = $origPath.Substring($qualifier.Length + 1)
        $backupFile = Join-Path $sessionDir $relativePath
$escapedbackupFile = $backupFile.Replace("'", "''")

        if (Test-Path $backupFile) {
            $ok = Restore-File -BackupPath $backupFile -OriginalPath $origPath -UsePowerRun:$UsePowerRun -PowerRunPath $powerRun
            if ($ok) {
                Write-Host "  Restored: $origPath" -ForegroundColor Green
                $successCount++
            } else {
                Write-Host "  FAILED: $origPath" -ForegroundColor Red
                $failCount++
            }
        } else {
            Write-Host "  SKIPPED (backup not found): $origPath" -ForegroundColor Yellow
        }
    }

    Write-Host ""
    Write-Host "Restored: $successCount files" -ForegroundColor Green
    if ($failCount -gt 0) { Write-Host "Failed: $failCount files" -ForegroundColor Red }
    return ($failCount -eq 0)
}

Write-Verbose "BackupModule.ps1 loaded. Use Initialize-Backup to start a session."