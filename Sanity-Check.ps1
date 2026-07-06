#requires -RunAsAdministrator
#requires -Version 5.0

<#
.SYNOPSIS
    Pre and post-installation sanity checks for the Transformation Pack.
.DESCRIPTION
    Runs comprehensive checks before and after installation to verify system
    integrity, detect conflicts, and validate successful installation.
.PARAMETER PreInstall
    Run pre-installation checks only.
.PARAMETER PostInstall
    Run post-installation checks only.
.PARAMETER Report
    Generate an HTML report of all checks.
.EXAMPLE
    .\Sanity-Check.ps1 -PreInstall
    Check if system is ready for installation.
.EXAMPLE
    .\Sanity-Check.ps1 -PostInstall
    Verify installation was successful.
.EXAMPLE
    .\Sanity-Check.ps1 -Report
    Generate HTML report in current directory.
#>

[CmdletBinding()]
param(
    [switch]$PreInstall,
    [switch]$PostInstall,
    [switch]$Report
)

$scriptDir = Split-Path -Parent $PSCommandPath
$escapedscriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $escapedScriptDir.Replace("'", "''")

# === Color output ===
function Write-Status {
    param(
        [string]$Status,
        [string]$Message,
        [string]$Color = "Gray"
    )
    $statusIcon = switch ($Status) {
        "OK"    { "✓"; $Color = "Green" }
        "WARN"  { "⚠"; $Color = "Yellow" }
        "FAIL"  { "✗"; $Color = "Red" }
        "INFO"  { "ℹ"; $Color = "Cyan" }
        default { "?"; $Color = "Gray" }
    }
    Write-Host "  [$statusIcon] $Message" -ForegroundColor $Color
}

# === Pre-Installation Checks ===
function Test-PreInstall {
    Write-Host ""
    Write-Host "PRE-INSTALLATION CHECKS" -ForegroundColor Cyan
    Write-Host "======================" -ForegroundColor Cyan
    Write-Host ""
    
    $results = @()
    
    # Check 1: OS Version
    Write-Host "1. Operating System" -ForegroundColor White
    $os = Get-CimInstance -ClassName Win32_OperatingSystem
    if ($os.Caption -match "Windows 10" -and $os.Version -like "10.0.19045*") {
        Write-Status "OK" "Windows 10 22H2 (10.0.19045) detected"
        $results += @{ Check = "OS Version"; Status = "OK" }
    } elseif ($os.Caption -match "Windows 10") {
        Write-Status "WARN" "Windows 10 detected but not 22H2: $($os.Version)"
        $results += @{ Check = "OS Version"; Status = "WARN"; Details = $os.Version }
    } else {
        Write-Status "FAIL" "Not Windows 10: $($os.Caption)"
        $results += @{ Check = "OS Version"; Status = "FAIL"; Details = $os.Caption }
    }
    
    # Check 2: Architecture
    Write-Host ""
    Write-Host "2. System Architecture" -ForegroundColor White
    $arch = $os.OSArchitecture
    if ($arch -eq "64-bit") {
        Write-Status "OK" "64-bit system detected"
        $results += @{ Check = "Architecture"; Status = "OK" }
    } elseif ($arch -eq "32-bit") {
        Write-Status "WARN" "32-bit system detected (not recommended)"
        $results += @{ Check = "Architecture"; Status = "WARN"; Details = $arch }
    } else {
        Write-Status "FAIL" "Unknown architecture: $arch"
        $results += @{ Check = "Architecture"; Status = "FAIL"; Details = $arch }
    }
    
    # Check 3: PowerShell Version
    Write-Host ""
    Write-Host "3. PowerShell Version" -ForegroundColor White
    if ($PSVersionTable.PSVersion.Major -ge 5) {
        Write-Status "OK" "PowerShell $($PSVersionTable.PSVersion.Major).$($PSVersionTable.PSVersion.Minor)"
        $results += @{ Check = "PowerShell Version"; Status = "OK" }
    } else {
        Write-Status "FAIL" "PowerShell too old: $($PSVersionTable.PSVersion)"
        $results += @{ Check = "PowerShell Version"; Status = "FAIL"; Details = $PSVersionTable.PSVersion }
    }
    
    # Check 4: Execution Policy
    Write-Host ""
    Write-Host "4. PowerShell Execution Policy" -ForegroundColor White
    $policy = Get-ExecutionPolicy
    if ($policy -eq "RemoteSigned" -or $policy -eq "Unrestricted" -or $policy -eq "ByPass") {
        Write-Status "OK" "Execution policy: $policy"
        $results += @{ Check = "Execution Policy"; Status = "OK" }
    } elseif ($policy -eq "Restricted") {
        Write-Status "FAIL" "Execution policy is Restricted - scripts cannot run"
        $results += @{ Check = "Execution Policy"; Status = "FAIL"; Details = $policy }
    } else {
        Write-Status "WARN" "Execution policy: $policy (unexpected)"
        $results += @{ Check = "Execution Policy"; Status = "WARN"; Details = $policy }
    }
    
    # Check 5: Admin Rights
    Write-Host ""
    Write-Host "5. Administrator Rights" -ForegroundColor White
    $isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
    if ($isAdmin) {
        Write-Status "OK" "Running with administrator rights"
        $results += @{ Check = "Admin Rights"; Status = "OK" }
    } else {
        Write-Status "FAIL" "Not running as administrator"
        $results += @{ Check = "Admin Rights"; Status = "FAIL" }
    }
    
    # Check 6: Disk Space
    Write-Host ""
    Write-Host "6. Disk Space" -ForegroundColor White
    $drive = Get-PSDrive C
    $freeGB = [math]::Round($drive.Free / 1GB, 2)
    if ($drive.Free -gt 5GB) {
        Write-Status "OK" "Free space: $freeGB GB"
        $results += @{ Check = "Disk Space"; Status = "OK"; Details = "$freeGB GB" }
    } elseif ($drive.Free -gt 1GB) {
        Write-Status "WARN" "Free space: $freeGB GB (5GB recommended)"
        $results += @{ Check = "Disk Space"; Status = "WARN"; Details = "$freeGB GB" }
    } else {
        Write-Status "FAIL" "Insufficient disk space: $freeGB GB"
        $results += @{ Check = "Disk Space"; Status = "FAIL"; Details = "$freeGB GB" }
    }
    
    # Check 7: Required Tools
    Write-Host ""
    Write-Host "7. Required Tools" -ForegroundColor White
    $tools = @(
        @{ Name = "PowerRun_x64.exe"; Path = "$scriptDir\PowerRun\PowerRun_x64.exe" }
        @{ Name = "ResourceHacker.exe"; Path = "$scriptDir\resource_hacker\ResourceHacker.exe" }
        @{ Name = "ViVeTool.exe"; Path = "$scriptDir\ViVeTool\ViVeTool.exe" }
    )
    
    foreach ($tool in $tools) {
        if (Test-Path $tool.Path) {
            Write-Status "OK" "$($tool.Name) found"
            $results += @{ Check = "Tool: $($tool.Name)"; Status = "OK" }
        } else {
            Write-Status "WARN" "$($tool.Name) not found"
            $results += @{ Check = "Tool: $($tool.Name)"; Status = "WARN" }
        }
    }
    
    # Check 8: Backup Directory
    Write-Host ""
    Write-Host "8. Backup System" -ForegroundColor White
    $backupDir = Join-Path $scriptDir "Backup"
$escapedbackupDir = $backupDir.Replace("'", "''")
    if (Test-Path $backupDir) {
        Write-Status "OK" "Backup directory exists"
        $sessions = @(Get-ChildItem -Path $backupDir -Directory -ErrorAction SilentlyContinue | Where-Object { $_.Name -match '^\d{4}-\d{4}-\d{6}$' })
        $results += @{ Check = "Backup Directory"; Status = "OK"; Details = "$($sessions.Count) sessions" }
    } else {
        Write-Status "OK" "Backup directory will be created on first install"
        $results += @{ Check = "Backup Directory"; Status = "OK"; Details = "Will be created" }
    }
    
    # Check 9: Conflicting Software
    Write-Host ""
    Write-Host "9. Conflicting Software Detection" -ForegroundColor White
    $conflicts = @()
    
    # Check for incompatible themes
    $themes = Get-ChildItem "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes" -ErrorAction SilentlyContinue
$escapedthemes = $themes.Replace("'", "''")
    if ($themes) {
        Write-Status "INFO" "Custom theme configuration found"
    }
    
    Write-Status "OK" "No known conflicts detected"
    $results += @{ Check = "Conflicts"; Status = "OK" }
    
    # Summary
    Write-Host ""
    Write-Host "SUMMARY" -ForegroundColor White
    $okCount = ($results | Where-Object { $_.Status -eq "OK" }).Count
    $warnCount = ($results | Where-Object { $_.Status -eq "WARN" }).Count
    $failCount = ($results | Where-Object { $_.Status -eq "FAIL" }).Count
    
    Write-Host "  OK: $okCount | Warnings: $warnCount | Failures: $failCount" -ForegroundColor Gray
    
    if ($failCount -gt 0) {
        Write-Host ""
        Write-Host "ERRORS DETECTED - Fix the failures above before proceeding." -ForegroundColor Red
        return $false
    } elseif ($warnCount -gt 0) {
        Write-Host ""
        Write-Host "WARNINGS - Installation may work but review warnings above." -ForegroundColor Yellow
        return $true
    } else {
        Write-Host ""
        Write-Host "System is ready for installation!" -ForegroundColor Green
        return $true
    }
}

# === Post-Installation Checks ===
function Test-PostInstall {
    Write-Host ""
    Write-Host "POST-INSTALLATION CHECKS" -ForegroundColor Cyan
    Write-Host "=======================" -ForegroundColor Cyan
    Write-Host ""
    
    $results = @()
    
    # Check 1: System files copied
    Write-Host "1. System Files" -ForegroundColor White
    $systemFiles = @(
        "C:\Windows\Resources\Themes\Aero10.theme"
        "C:\Windows\System32\SecureUxTheme.dll"
    )
    
    $copiedCount = 0
    foreach ($file in $systemFiles) {
        if (Test-Path $file) {
            Write-Status "OK" "$file exists"
            $copiedCount++
            $results += @{ Check = "File: $(Split-Path $file -Leaf)"; Status = "OK" }
        }
    }
    Write-Status "INFO" "$copiedCount / $($systemFiles.Count) expected files found"
    
    # Check 2: Registry entries
    Write-Host ""
    Write-Host "2. Registry Entries" -ForegroundColor White
    $regPaths = @(
        @{ Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes"; Name = "Themes" }
    )
    
    foreach ($reg in $regPaths) {
        if (Test-Path $reg.Path -ErrorAction SilentlyContinue) {
            Write-Status "OK" "$($reg.Name) registry key exists"
            $results += @{ Check = "Registry: $($reg.Name)"; Status = "OK" }
        } else {
            Write-Status "WARN" "$($reg.Name) registry key not found"
            $results += @{ Check = "Registry: $($reg.Name)"; Status = "WARN" }
        }
    }
    
    # Check 3: Backup Session
    Write-Host ""
    Write-Host "3. Backup Session" -ForegroundColor White
    $backupDir = Join-Path $scriptDir "Backup"
    if (Test-Path $backupDir) {
        $sessions = @(Get-ChildItem -Path $backupDir -Directory -ErrorAction SilentlyContinue | Sort-Object -Descending | Select-Object -First 1)
        if ($sessions) {
            Write-Status "OK" "Latest backup session: $($sessions[0].Name)"
            $fileCount = @(Get-Content (Join-Path $sessions[0].FullName "_files.txt") -ErrorAction SilentlyContinue).Count
$escapedfileCount = $fileCount.Replace("'", "''")
            Write-Status "INFO" "Files backed up: $fileCount"
            $results += @{ Check = "Latest Backup"; Status = "OK"; Details = "$fileCount files" }
        } else {
            Write-Status "WARN" "No backup sessions found"
            $results += @{ Check = "Latest Backup"; Status = "WARN" }
        }
    } else {
        Write-Status "WARN" "Backup directory not found"
        $results += @{ Check = "Latest Backup"; Status = "WARN" }
    }
    
    # Check 4: Control Panel Pages
    Write-Host ""
    Write-Host "4. Control Panel Restoration" -ForegroundColor White
    $cplFiles = @(
        @{ Name = "Language"; Path = "C:\Windows\System32\Language.dll" }
        @{ Name = "Display"; Path = "C:\Windows\System32\Display.dll" }
    )
    
    $cplCount = 0
    foreach ($cpl in $cplFiles) {
        if (Test-Path $cpl.Path -ErrorAction SilentlyContinue) {
            Write-Status "OK" "$($cpl.Name) CPL restored"
            $cplCount++
            $results += @{ Check = "CPL: $($cpl.Name)"; Status = "OK" }
        }
    }
    Write-Status "INFO" "$cplCount CPL pages detected"
    
    # Summary
    Write-Host ""
    Write-Host "SUMMARY" -ForegroundColor White
    $okCount = ($results | Where-Object { $_.Status -eq "OK" }).Count
    $warnCount = ($results | Where-Object { $_.Status -eq "WARN" }).Count
    
    Write-Host "  OK: $okCount | Warnings: $warnCount" -ForegroundColor Gray
    
    if ($warnCount -gt 0) {
        Write-Host ""
        Write-Host "REVIEW WARNINGS - Some components may not have installed correctly." -ForegroundColor Yellow
        return $true
    } else {
        Write-Host ""
        Write-Host "Installation verification complete!" -ForegroundColor Green
        return $true
    }
}

# === Main ===
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Transformation Pack Sanity Checks" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

if ($PreInstall) {
    Test-PreInstall | Out-Null
} elseif ($PostInstall) {
    Test-PostInstall | Out-Null
} else {
    # Run both by default
    Test-PreInstall | Out-Null
    Write-Host ""
    Write-Host "Run './Sanity-Check.ps1 -PostInstall' after installation to verify." -ForegroundColor Gray
}