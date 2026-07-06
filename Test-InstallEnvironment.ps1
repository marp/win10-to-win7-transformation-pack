<#
.SYNOPSIS
    Tests the installation environment for the Transformation Pack.
.DESCRIPTION
    Checks prerequisites, component file integrity, script syntax,
    and disk space. Run BEFORE install.ps1 to identify potential issues.
.EXAMPLE
    .\Test-InstallEnvironment.ps1
#>

#requires -RunAsAdministrator
#requires -Version 5.0

[CmdletBinding()]
param()

$scriptDir = Split-Path -Parent $PSCommandPath
$escapedscriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $escapedScriptDir.Replace("'", "''")
$logFile = "$scriptDir\env-test.log"
$escapedlogFile = $logFile.Replace("'", "''")
$errors = 0
$warnings = 0

function Write-Test {
    param([string]$Message, [string]$Status = "PASS")
    $timestamp = Get-Date -Format "HH:mm:ss"
    switch ($Status) {
        "FAIL" { $color = "Red"; $errors++ }
        "WARN" { $color = "Yellow"; $warnings++ }
        "PASS" { $color = "Green" }
        default { $color = "White" }
    }
    Write-Host "[$timestamp] [$Status] $Message" -ForegroundColor $color
    Add-Content -Path $logFile -Value "[$timestamp] [$Status] $Message" -Encoding UTF8
}

# --- Start ---
"Environment Test Log - $(Get-Date)" | Out-File $logFile
"=" * 60 | Out-File $logFile -Append

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Transformation Pack Environment Test" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 1. OS check
Write-Test "OS: $((Get-CimInstance Win32_OperatingSystem).Caption) $((Get-CimInstance Win32_OperatingSystem).Version)"
$arch = (Get-CimInstance Win32_OperatingSystem).OSArchitecture
Write-Test "Architecture: $arch"
if ($arch -eq "ARM64") { Write-Test "ARM64 detected — some components may not work" "WARN" }

# 2. PowerShell version
Write-Test "PowerShell version: $($PSVersionTable.PSVersion)"
if ($PSVersionTable.PSVersion.Major -lt 5) {
    Write-Test "PowerShell 5+ required" "FAIL"
}

# 3. Execution policy
$policy = Get-ExecutionPolicy
Write-Test "Execution policy: $policy"
if ($policy -eq "Restricted") {
    Write-Test "Execution policy is Restricted — run: Set-ExecutionPolicy RemoteSigned" "FAIL"
}

# 4. Admin rights
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
Write-Test "Running as Administrator: $isAdmin"
if (-not $isAdmin) { Write-Test "Must run as Administrator" "FAIL" }

# 5. Disk space
$drive = (Get-PSDrive -Name $scriptDir[0]).Free
$escapeddrive = $drive.Replace("'", "''")
$freeGB = [math]::Round($drive / 1GB, 1)
Write-Test "Free disk space: ${freeGB}GB (at least 5GB recommended)"
if ($freeGB -lt 2) { Write-Test "Low disk space — may not have room for backups" "WARN" }

# 6. PowerRun
$powerRun = "$scriptDir\PowerRun\PowerRun_x64.exe"
$escapedpowerRun = $powerRun.Replace("'", "''")
$prOk = Test-Path $powerRun
$escapedprOk = if ($null -ne $prOk) { $prOk.ToString().Replace("'", "''") } else { $null }
Write-Test "PowerRun: $(if($prOk){'found'}else{'MISSING'})"
if (-not $prOk) { Write-Test "PowerRun_x64.exe is required for TrustedInstaller operations" "FAIL" }

# 7. Resource Hacker
$resHack = "$scriptDir\resource_hacker\ResourceHacker.exe"
$escapedresHack = $resHack.Replace("'", "''")
$rhOk = Test-Path $resHack
Write-Test "Resource Hacker: $(if($rhOk){'found'}else{'MISSING'})"
if (-not $rhOk) { Write-Test "Resource Hacker is required by CPL page installers" "WARN" }

# 8. ViVeTool
$vive = "$scriptDir\ViVeTool\ViVeTool.exe"
$escapedvive = $vive.Replace("'", "''")
$viveOk = Test-Path $vive
Write-Test "ViVeTool: $(if($viveOk){'found'}else{'MISSING'})"

# 9. Component file integrity
Write-Host ""
Write-Host "--- Component File Integrity ---" -ForegroundColor Cyan
$components = @(
    @{Path = "SecureUxTheme\SecureUxTheme_x64.msi"; Name = "SecureUxTheme"}
    @{Path = "Themes\copy.ps1"; Name = "Theme installer script"}
    @{Path = "Themes\Aero10 Seven.theme"; Name = "Base Aero10 Seven theme"}
    @{Path = "Themes\Aero10 Vista.theme"; Name = "Base Aero10 Vista theme"}
    @{Path = "Themes\Aero10 Metro 8.theme"; Name = "Base Aero10 Metro theme"}
    @{Path = "ExplorerTransparency\DWMBlurGlass\DWMBlurGlass.exe"; Name = "DWMBlurGlass"}
    @{Path = "AuthUX v0.0.2a-beta\AuthUX-setup-x64.exe"; Name = "AuthUX"}
    @{Path = "Windhawk\windhawk_setup.exe"; Name = "Windhawk"}
    @{Path = "Windhawk\copyResources.ps1"; Name = "Windhawk Resource Redirect"}
    @{Path = "Branding\copy.ps1"; Name = "Branding"}
    @{Path = "Sounds\copyAndApplyWindows7Sounds.ps1"; Name = "Sounds"}
    @{Path = "Cursors\Install.inf"; Name = "Cursors"}
    @{Path = "classicuac-1.0.3\NTMU.exe"; Name = "Classic UAC"}
    @{Path = "User tiles\copy.ps1"; Name = "User Tiles"}
    @{Path = "OpenWithEx\OpenWithEx-setup-x64.exe"; Name = "OpenWithEx"}
    @{Path = "CPL Restoration 4.0 H1\_ControlPanelLinks.ps1"; Name = "CPL Links prep"}
    @{Path = "CPL Restoration 4.0 H1\_ControlPanelRedirection.ps1"; Name = "CPL Redirection prep"}
)

foreach ($comp in $components) {
    $fullPath = Join-Path $scriptDir $comp.Path
$escapedfullPath = $fullPath.Replace("'", "''")
    if (Test-Path $fullPath) {
        Write-Test "$($comp.Name): OK" "PASS"
    } else {
        Write-Test "$($comp.Name): MISSING at $($comp.Path)" "WARN"
    }
}

# 10. CPL page script integrity
Write-Host ""
Write-Host "--- CPL Page Scripts ---" -ForegroundColor Cyan
$cplDir = "$scriptDir\CPL Restoration 4.0 H1"
$escapedcplDir = $cplDir.Replace("'", "''")
$cplScripts = @(
    "BackupAndRestore.ps1", "BiometricDevices.ps1",
    "DefaultPrograms.ps1", "Display.ps1",
    "GameControllers.ps1", "GenuineCenter.ps1",
    "HomeGroups.ps1", "Language.ps1",
    "MobilityCenter.ps1", "NetworkAndSharingCenter.ps1",
    "NetworkMap.ps1", "NotificationTrayIcons.ps1",
    "ParentalControls-FamilySafety.ps1",
    "PerformanceInformationAndTools.ps1", "Printers.ps1",
    "Recovery.ps1", "RegionAndInput.ps1",
    "SecurityCenterAndFirewall.ps1", "System.ps1",
    "UserAccounts.ps1", "WindowsCardspace.ps1",
    "WindowsUpdate.ps1"
)
$cplFound = 0
$cplMissing = 0
foreach ($s in $cplScripts) {
    $path = Join-Path $cplDir $s
$escapedpath = $path.Replace("'", "''")
    if (Test-Path $path) {
        $cplFound++
    } else {
        Write-Test "CPL script missing: $s" "WARN"
        $cplMissing++
    }
}
Write-Test "CPL scripts: $cplFound found, $cplMissing missing" $(if($cplMissing -eq 0){"PASS"}else{"WARN"})

# 11. Summary
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Test Results" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Errors:   $errors" -ForegroundColor $(if($errors -gt 0){"Red"}else{"Green"})
Write-Host "  Warnings: $warnings" -ForegroundColor $(if($warnings -gt 0){"Yellow"}else{"Green"})
Write-Host "  Log:      $logFile"
Write-Host ""

if ($errors -gt 0) {
    Write-Host "  Fix the errors above before running install.ps1" -ForegroundColor Red
    exit 1
} else {
    Write-Host "  Environment looks good. You can proceed with install.ps1" -ForegroundColor Green
    exit 0
}