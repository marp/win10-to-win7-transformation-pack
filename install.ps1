#requires -RunAsAdministrator
#requires -Version 5.0

<#
.SYNOPSIS
    Windows 10 to Windows 7 Transformation Pack Installer
.DESCRIPTION
    Unified installer for the Windows 10 to Windows 7 Transformation Pack.
    Supports interactive (menu-driven) and silent (-All / -Components) modes.
    Creates a system restore point before making changes.
.PARAMETER All
    Install all components without prompting.
.PARAMETER Components
    Comma-separated list of components to install (silent, no prompts).
    Valid values: SecureUxTheme,Theme,DWMBlurGlass,AuthUX,Windhawk,Resources,
                  Sounds,Branding,Cursors,UAC,CPL,UserTiles,OpenWithEx,
                  Winaero,Games,StartMenu,HackBGRT,HomeGroup,DefaultPrograms
.PARAMETER LogPath
    Path to write the installation log (default: $PSScriptRoot\install.log).
.PARAMETER NoRestorePoint
    Skip system restore point creation.
.PARAMETER Silent
    Suppress all prompts (use with -All or -Components).
.PARAMETER Language
    Locale for MUI file selection (default: system locale, fallback en-US).
    Example: -Language "pl-PL", -Language "de-DE"
.PARAMETER WhatIf
    Show what would be installed without making changes (dry-run).
.EXAMPLE
    .\install.ps1 -All
    Install everything.
.EXAMPLE
    .\install.ps1 -Components "SecureUxTheme,Theme,Sounds,Branding"
    Install selected components silently.
.EXAMPLE
    .\install.ps1
    Interactive menu-driven installation.
.EXAMPLE
    .\install.ps1 -WhatIf -All
    Preview all components that would be installed (dry-run).
.EXAMPLE
    .\install.ps1 -All -Language "pl-PL"
    Install everything using Polish MUI files if available.
#>

[CmdletBinding(SupportsShouldProcess)]
param(
    [switch]$All,
    [string]$Components,
    [string]$LogPath,
    [switch]$NoRestorePoint,
    [switch]$Silent,
    [string]$Language = ""
)

$scriptDir = Split-Path -Parent $PSCommandPath
$escapedscriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $escapedScriptDir.Replace("'", "''")
if (-not $LogPath) { $LogPath = "$scriptDir\install.log" }
$escapedLogPath = $LogPath.Replace("'", "''")

# --- Locale resolution ---
if (-not $Language) {
    try {
        $Language = (Get-CimInstance -ClassName Win32_OperatingSystem).MUILanguages[0]
    } catch {
        $Language = "en-US"
    }
}
if (-not $Language) { $Language = "en-US" }
$global:InstallLanguage = $Language

# --- Logging ---
function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $line = "[$timestamp] [$Level] $Message"
    Add-Content -Path $LogPath -Value $line -Encoding UTF8
    if ($Level -eq "ERROR") { Write-Host $line -ForegroundColor Red }
    elseif ($Level -eq "WARN") { Write-Host $line -ForegroundColor Yellow }
    elseif ($Level -eq "OK") { Write-Host $Message -ForegroundColor Green }
    else { Write-Host $Message }
}

# --- Prerequisites ---
function Test-Prerequisites {
    $ok = $true

    $os = Get-CimInstance -ClassName Win32_OperatingSystem
    if ($os.Caption -notmatch "Windows 10" -or $os.Version -notlike "10.0.19045*") {
        Write-Log "This pack targets Windows 10 22H2 (10.0.19045). Detected: $($os.Caption) $($os.Version)" "ERROR"
        $ok = $false
    }

    $policy = Get-ExecutionPolicy
    if ($policy -eq "Restricted") {
        Write-Log "PowerShell execution policy is Restricted. Run: Set-ExecutionPolicy RemoteSigned" "ERROR"
        $ok = $false
    }

    $arch = $os.OSArchitecture
    if ($arch -eq "ARM64") {
        Write-Log "ARM64 Windows detected — some components may not work" "WARN"
    }

    if (-not (Test-Path "$scriptDir\PowerRun\PowerRun_x64.exe")) {
        Write-Log "PowerRun_x64.exe not found — required for TrustedInstaller-level operations" "ERROR"
        $ok = $false
    }

    return $ok
}

# --- Restore Point ---
function New-RestorePoint {
    try {
        Checkpoint-Computer -Description "Windows 7 Transformation Pack - Pre-install" -RestorePointType MODIFY_SETTINGS
        Write-Log "System restore point created" "OK"
    } catch {
        Write-Log "Failed to create restore point: $_" "WARN"
    }
}

# --- Component helpers ---
function Invoke-PackProcess {
    param(
        [Parameter(Mandatory = $true)]
        [string]$FilePath,
        [string]$Arguments = "",
        [switch]$UsePowerRun,
        [switch]$NoNewWindow,
        [string]$WindowStyle = "Normal"
    )

    $targetExe = $FilePath
$escapedtargetExe = if ($null -ne $targetExe) { $targetExe.ToString().Replace("'", "''") } else { $null }
    $targetArgs = $Arguments

    if ($UsePowerRun) {
        $powerRun = "$scriptDir\PowerRun\PowerRun_x64.exe"
$escapedpowerRun = $powerRun.Replace("'", "''")
        if (-not (Test-Path $powerRun)) {
            Write-Log "PowerRun not found at $powerRun" "ERROR"
            throw "PowerRun missing"
        }
        $targetExe = $powerRun
        $targetArgs = "`"$FilePath`" $Arguments"
    }

    try {
        $p = Start-Process $targetExe -ArgumentList $targetArgs -Wait -PassThru -NoNewWindow:$NoNewWindow -WindowStyle $WindowStyle
        if (-not $p) {
            Write-Log "Failed to start process: $FilePath" "ERROR"
            throw "Process failed to start"
        }

        if ($p.ExitCode -ne 0 -and $p.ExitCode -ne 3010) {
            Write-Log "Process [$FilePath] failed with exit code $($p.ExitCode)" "ERROR"
            throw "Process exited with error code $($p.ExitCode)"
        }

        return $p
    } catch {
        Write-Log "Error executing [$FilePath]: $_" "ERROR"
        throw $_
    }
}

function Invoke-PowerRun {
    param([string]$Command)
    try {
        $p = Invoke-PackProcess -FilePath $Command -UsePowerRun -WindowStyle Hidden
        return ($null -ne $p -and ($p.ExitCode -eq 0 -or $p.ExitCode -eq 3010))
    } catch {
        return $false
    }
}

function Install-Msi {
    param([string]$MsiPath)
    if (-not (Test-Path $MsiPath)) {
        Write-Log "MSI not found: $MsiPath" "WARN"
        return $false
    }
    try {
        $p = Invoke-PackProcess -FilePath "msiexec.exe" -Arguments "/i `"$MsiPath`" /passive /norestart" -NoNewWindow
        return ($null -ne $p -and ($p.ExitCode -eq 0 -or $p.ExitCode -eq 3010))
    } catch {
        return $false
    }
}

function Install-Executable {
    param([string]$ExePath, [string]$Args = "/S")
    if (-not (Test-Path $ExePath)) {
        Write-Log "Executable not found: $ExePath" "WARN"
        return $false
    }
    try {
        $p = Invoke-PackProcess -FilePath $ExePath -Arguments $Args
        return ($null -ne $p -and $p.ExitCode -eq 0)
    } catch {
        return $false
    }
}

function Install-StartMenu {
    Write-Log "--- Start Menu & Taskbar ---"
    $smDir = "$scriptDir\StartMenuAndTaskBar"
$escapedsmDir = $smDir.Replace("'", "''")
    if (-not (Test-Path $smDir)) {
        Write-Log "StartMenu directory not found" "WARN"
        return $false
    }

    Write-Log "  Two options available:" "INFO"
    Write-Log "    1. Explorer7 (experimental, may break UWP apps) — requires Windows 7 ISO" "INFO"
    Write-Log "    2. StartIsBack++ (paid, stable) — run installer then configure" "INFO"
    Write-Log "  See StartMenuAndTaskBar\CHOOSE_ONLY_ONE for details" "INFO"
    Write-Host "  MANUAL STEP: Install your choice from StartMenuAndTaskBar" -ForegroundColor Yellow
    return $true
}

# --- Component Installers ---
function Install-SecureUxTheme {
    Write-Log "--- Installing SecureUxTheme ---"
    $msi = "$scriptDir\SecureUxTheme\SecureUxTheme_x64.msi"
$escapedmsi = $msi.Replace("'", "''")
    if (Test-Path $msi) {
        if (Install-Msi $msi) {
            Write-Log "SecureUxTheme installed (reboot may be required)" "OK"
            return $true
        }
        Write-Log "SecureUxTheme installation failed" "ERROR"
    } else {
        Write-Log "SecureUxTheme MSI not found at $msi" "WARN"
    }
    return $false
}

function Install-Theme {
    Write-Log "--- Installing Windows 7 Aero Themes ---"
    if ($PSCmdlet.ShouldProcess("Theme files to C:\Windows\Resources\Themes", "Copy")) {
        if ($WhatIfPreference) {
            Write-Log "WHATIF: Would copy theme files to C:\Windows\Resources\Themes" "INFO"
            return $true
        }
        $themeScript = "$scriptDir\Themes\copy.ps1"
$escapedthemeScript = $themeScript.Replace("'", "''")
        if (Test-Path $themeScript) {
            try {
                & $themeScript
                if ($LASTEXITCODE -ne 0 -and $null -ne $LASTEXITCODE) { throw "Script exited with code $LASTEXITCODE" }
            } catch {
                Write-Log "Theme script failed: $_" "ERROR"
                return $false
            }
            Write-Log "Theme files copied. Available themes (30 variants):" "OK"
            Get-ChildItem "$scriptDir\Themes\*.theme" | ForEach-Object {
                Write-Log "  - $($_.BaseName)" "INFO"
            }
            Write-Log "Apply via Settings > Personalization > Themes" "INFO"
            return $true
        }
        Write-Log "Theme script not found at $themeScript" "WARN"
    }
    return $false
}

function Install-DWMBlurGlass {
    Write-Log "--- DWMBlurGlass (transparent titlebars) ---"
    $src = "$scriptDir\ExplorerTransparency\DWMBlurGlass"
$escapedsrc = $src.Replace("'", "''")
        $escapedSrc = $src.Replace("'", "''")
    if (Test-Path $src) {
        $copyCmd = "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$escapedSrc' -Destination 'C:\Windows\' -Recurse -Force"
$escapedcopyCmd = $copyCmd.Replace("'", "''")
        $copied = Invoke-PowerRun $copyCmd
        if (-not $copied) {
            Write-Log "Failed to copy DWMBlurGlass to C:\Windows\DWMBlurGlass" "ERROR"
            return $false
        }
        Write-Log "DWMBlurGlass copied to C:\Windows\DWMBlurGlass" "OK"
        Write-Log "  MANUAL STEP: Run C:\Windows\DWMBlurGlass\DWMBlurGlass.exe, download symbols, apply patch" "WARN"
        return $true
    }
    Write-Log "DWMBlurGlass not found" "WARN"
    return $false
}

function Install-AuthUX {
    Write-Log "--- Installing AuthUX (logon screen) ---"
    $exe = "$scriptDir\AuthUX v0.0.2a-beta\AuthUX-setup-x64.exe"
$escapedexe = $exe.Replace("'", "''")
    if (Test-Path $exe) {
        if (Install-Executable $exe) {
            Write-Log "AuthUX installed" "OK"
            return $true
        }
        Write-Log "AuthUX installation failed" "ERROR"
    } else {
        Write-Log "AuthUX installer not found at $exe" "WARN"
    }
    return $false
}

function Install-Windhawk {
    Write-Log "--- Installing Windhawk ---"
    $installer = "$scriptDir\Windhawk\windhawk_setup.exe"
$escapedinstaller = $installer.Replace("'", "''")
    if (Test-Path $installer) {
        if (Install-Executable $installer) {
            Write-Log "Windhawk installed" "OK"
            return $true
        }
        Write-Log "Windhawk installation failed" "ERROR"
    } else {
        Write-Log "Windhawk installer not found at $installer" "WARN"
    }
    return $false
}

function Install-WindhawkResources {
    Write-Log "--- Windhawk Resource Redirect ---"
    if ($WhatIfPreference) {
        Write-Log "WHATIF: Would copy Windhawk ResourceRedirect files" "INFO"
        return $true
    }
    $resourceScript = "$scriptDir\Windhawk\copyResources.ps1"
$escapedresourceScript = $resourceScript.Replace("'", "''")
    if (Test-Path $resourceScript) {
        try {
            & $resourceScript
            if ($LASTEXITCODE -ne 0 -and $null -ne $LASTEXITCODE) { throw "Script exited with code $LASTEXITCODE" }
        } catch {
            Write-Log "Windhawk resource script failed: $_" "ERROR"
            return $false
        }
        Write-Log "ResourceRedirect files copied" "OK"
    } else {
        Write-Log "Windhawk copyResources.ps1 not found" "WARN"
    }

    $modsFile = "$scriptDir\Windhawk\mods.txt"
$escapedmodsFile = $modsFile.Replace("'", "''")
    if (Test-Path $modsFile) {
        Write-Log "Windhawk mods to install manually from mods.txt:" "INFO"
        Get-Content $modsFile | ForEach-Object { Write-Log "  - $_" }
        Write-Log "  Open Windhawk from system tray and install the mods listed above" "WARN"
    }
    return $true
}

function Install-Sounds {
    Write-Log "--- Applying Windows 7 Sounds ---"
    if ($WhatIfPreference) {
        Write-Log "WHATIF: Would copy and apply Windows 7 sound scheme" "INFO"
        return $true
    }
    $sndScript = "$scriptDir\Sounds\copyAndApplyWindows7Sounds.ps1"
$escapedsndScript = $sndScript.Replace("'", "''")
    if (Test-Path $sndScript) {
        try {
            & $sndScript
            if ($LASTEXITCODE -ne 0 -and $null -ne $LASTEXITCODE) { throw "Script exited with code $LASTEXITCODE" }
        } catch {
            Write-Log "Sound script failed: $_" "ERROR"
            return $false
        }
        Write-Log "Windows 7 sound scheme applied" "OK"
        return $true
    }
    Write-Log "Sound script not found at $sndScript" "WARN"
    return $false
}

function Install-Branding {
    Write-Log "--- Applying Windows 7 Branding ---"
    if ($WhatIfPreference) {
        Write-Log "WHATIF: Would apply Windows 7 branding" "INFO"
        return $true
    }
    $brScript = "$scriptDir\Branding\copy.ps1"
$escapedbrScript = $brScript.Replace("'", "''")
    if (Test-Path $brScript) {
        try {
            & $brScript
            if ($LASTEXITCODE -ne 0 -and $null -ne $LASTEXITCODE) { throw "Script exited with code $LASTEXITCODE" }
        } catch {
            Write-Log "Branding script failed: $_" "ERROR"
            return $false
        }
        Write-Log "Windows 7 branding applied" "OK"
        return $true
    }
    Write-Log "Branding script not found at $brScript" "WARN"
    return $false
}

function Install-Cursors {
    Write-Log "--- Installing Windows 7 Cursors ---"
    $infFile = "$scriptDir\Cursors\Install.inf"
$escapedinfFile = $infFile.Replace("'", "''")
    if (Test-Path $infFile) {
        Write-Log "  MANUAL STEP: Right-click Cursors\Install.inf and select 'Install'" "WARN"
        return $true
    }
    Write-Log "Cursor Install.inf not found" "WARN"
    return $false
}

function Install-ClassicUAC {
    Write-Log "--- Classic Non-XAML UAC ---"
    $ntmu = "$scriptDir\classicuac-1.0.3\NTMU.exe"
$escapedntmu = $ntmu.Replace("'", "''")
    $ini = "$scriptDir\classicuac-1.0.3\pack.ini"
$escapedini = $ini.Replace("'", "''")
    if ((Test-Path $ntmu) -and (Test-Path $ini)) {
        Write-Log "  MANUAL STEP: Run classicuac-1.0.3\NTMU.exe, select pack.ini, apply" "WARN"
        return $true
    }
    Write-Log "ClassicUAC files not found" "WARN"
    return $false
}

function Install-CPL {
    Write-Log "--- Control Panel Restoration (Language: $global:InstallLanguage) ---"
    if ($PSCmdlet.ShouldProcess("Control Panel pages", "Install")) {
        $cplDir = "$scriptDir\CPL Restoration 4.0 H1"
$escapedcplDir = $cplDir.Replace("'", "''")
        if (-not (Test-Path $cplDir)) {
            Write-Log "CPL Restoration directory not found" "WARN"
            return $false
        }

        # Run preparation scripts first
        $prepScripts = @("_ControlPanelLinks.ps1", "_ControlPanelRedirection.ps1")
        foreach ($ps in $prepScripts) {
            $psPath = "$cplDir\$ps"
$escapedpsPath = $psPath.Replace("'", "''")
            if (Test-Path $psPath) {
                Write-Log "  Running preparation: $ps" "INFO"
                try {
                    & $psPath
                    if ($LASTEXITCODE -ne 0 -and $null -ne $LASTEXITCODE) { throw "Prep script $ps failed with code $LASTEXITCODE" }
                } catch {
                    Write-Log "  Preparation script $ps failed: $_" "ERROR"
                    return $false
                }
            } else {
                Write-Log "  Preparation script not found: $ps" "WARN"
            }
        }

        $cplScripts = @(
            "BackupAndRestore.ps1", "BiometricDevices.ps1",
            "DefaultPrograms.ps1", "Display.ps1",
            "GameControllers.ps1", "GenuineCenter.ps1",
            "HomeGroups.ps1", "Language.ps1",
            "MobilityCenter.ps1", "NetworkAndSharingCenter.ps1",
            "NetworkMap.ps1", "NotificationTrayIcons.ps1",
            "ParentalControls-FamilySafety.ps1",
            "PerformanceInformationAndTools.ps1", "Recovery.ps1",
            "RegionAndInput.ps1",
            "SecurityCenterAndFirewall.ps1", "System.ps1",
            "UserAccounts.ps1", "WindowsCardspace.ps1",
            "WindowsUpdate.ps1"
        )

        $successCount = 0
        $failCount = 0
        foreach ($s in $cplScripts) {
            $path = "$cplDir\$s"
$escapedpath = $path.Replace("'", "''")
            if (Test-Path $path) {
                Write-Log "  Installing CPL page: $s" "INFO"
                try {
                    $ErrorActionPreference = "Stop"
                    & $path
                    if ($LASTEXITCODE -ne 0 -and $null -ne $LASTEXITCODE) { throw "Exited with code $LASTEXITCODE" }
                    Write-Log "  $s completed" "OK"
                    $successCount++
                } catch {
                    Write-Log "  $s failed: $_" "ERROR"
                    $failCount++
                } finally {
                    $ErrorActionPreference = "Continue"
                }
            } else {
                Write-Log "  CPL script not found: $s" "WARN"
            }
        }

        Write-Log "CPL pages installed: $successCount, failed: $failCount" "OK"
        return ($failCount -eq 0)
    }
    return $true
}

function Install-UserTiles {
    Write-Log "--- Installing Windows 7 User Tiles ---"
    if ($WhatIfPreference) {
        Write-Log "WHATIF: Would install Windows 7 user tiles" "INFO"
        return $true
    }
    $tileScript = "$scriptDir\User tiles\copy.ps1"
$escapedtileScript = $tileScript.Replace("'", "''")
    if (Test-Path $tileScript) {
        try {
            & $tileScript
            if ($LASTEXITCODE -ne 0 -and $null -ne $LASTEXITCODE) { throw "Script exited with code $LASTEXITCODE" }
        } catch {
            Write-Log "User tiles script failed: $_" "ERROR"
            return $false
        }
        Write-Log "User tiles installed" "OK"
        return $true
    }
    Write-Log "User tiles script not found" "WARN"
    return $false
}

function Install-OpenWithEx {
    Write-Log "--- Installing OpenWithEx ---"
    $exe = "$scriptDir\OpenWithEx\OpenWithEx-setup-x64.exe"
    if (Test-Path $exe) {
        if (Install-Executable $exe) {
            Write-Log "OpenWithEx installed" "OK"
            return $true
        }
        Write-Log "OpenWithEx installation failed" "ERROR"
    } else {
        Write-Log "OpenWithEx installer not found at $exe" "WARN"
    }
    return $false
}

function Install-Winaero {
    Write-Log "--- Installing Winaero Tweaker ---"
    $exe = "$scriptDir\Winaero Tweaker\WinaeroTweaker-1.63.0.0-setup.exe"
    if (Test-Path $exe) {
        if (Install-Executable $exe "/SP- /VERYSILENT") {
            Write-Log "Winaero Tweaker installed" "OK"
            Write-Log "  MANUAL STEP: Launch Winaero Tweaker and configure per readme.txt" "WARN"
            return $true
        }
        Write-Log "Winaero Tweaker installation failed" "ERROR"
    } else {
        Write-Log "Winaero Tweaker installer not found at $exe" "WARN"
    }
    return $false
}

function Install-Games {
    Write-Log "--- Installing Windows 7 Games ---"
    $gamesDir = "$scriptDir\Games & Apps"
$escapedgamesDir = $gamesDir.Replace("'", "''")
    if (-not (Test-Path $gamesDir)) {
        Write-Log "Games directory not found" "WARN"
        return $false
    }

    $sevenZipFiles = Get-ChildItem "$gamesDir\Windows 7 Games for Windows 10 and 8.zip.*"
$escapedsevenZipFiles = $sevenZipFiles.Replace("'", "''")
    if ($sevenZipFiles.Count -ge 4) {
        Write-Log "  Games archive found. Extract Windows 7 Games for Windows 10 and 8.zip.* and run the installer" "WARN"
    }

    $calcDir = "$gamesDir\Calculator"
$escapedcalcDir = $calcDir.Replace("'", "''")
    if (Test-Path $calcDir) {
        Write-Log "  Calculator found in Games & Apps\Calculator" "INFO"
    }

    Write-Log "  MANUAL STEP: Extract and install Windows 7 Games from Games & Apps" "WARN"
    return $true
}

function Install-HackBGRT {
    Write-Log "--- HackBGRT (Boot Screen) ---"
    $hackDir = "$scriptDir\HackBGRT-2.6.0 (Use with caution!)"
$escapedhackDir = $hackDir.Replace("'", "''")
    if (-not (Test-Path $hackDir)) {
        Write-Log "HackBGRT directory not found" "WARN"
        return $false
    }

    Write-Log "  WARNING: UEFI-only. Disable Secure Boot in BIOS first!" "ERROR"
    Write-Log "  Can brick Windows installation if used incorrectly" "ERROR"
    Write-Log "  MANUAL STEP: Run setup.exe from HackBGRT directory (USE WITH CAUTION)" "WARN"
    return $true
}

function Install-HomeGroup {
    Write-Log "--- Restoring HomeGroup ---"
    if ($WhatIfPreference) {
        Write-Log "WHATIF: Would restore HomeGroup" "INFO"
        return $true
    }
    $hgScript = "$scriptDir\CPL Restoration 4.0 H1\Extras\HomeGroup\InstallHomeGroup.ps1"
$escapedhgScript = $hgScript.Replace("'", "''")
    if (Test-Path $hgScript) {
        try {
            & $hgScript
            if ($LASTEXITCODE -ne 0 -and $null -ne $LASTEXITCODE) { throw "Script exited with code $LASTEXITCODE" }
        } catch {
            Write-Log "HomeGroup script failed: $_" "ERROR"
            return $false
        }
        Write-Log "HomeGroup restoration complete" "OK"
        return $true
    }
    Write-Log "HomeGroup script not found at $hgScript" "WARN"
    return $false
}

function Install-DefaultPrograms {
    Write-Log "--- Fixing Default Programs CPL dead links ---"
    if ($WhatIfPreference) {
        Write-Log "WHATIF: Would fix Default Programs CPL dead links" "INFO"
        return $true
    }
    $dpScript = "$scriptDir\CPL Restoration 4.0 H1\DefaultPrograms.ps1"
$escapeddpScript = $dpScript.Replace("'", "''")
    if (Test-Path $dpScript) {
        try {
            & $dpScript
            if ($LASTEXITCODE -ne 0 -and $null -ne $LASTEXITCODE) { throw "Script exited with code $LASTEXITCODE" }
        } catch {
            Write-Log "DefaultPrograms script failed: $_" "ERROR"
            return $false
        }
        Write-Log "Default Programs CPL fix applied" "OK"
        return $true
    }
    Write-Log "DefaultPrograms script not found at $dpScript" "WARN"
    return $false
}

# --- Component Manifest ---
$manifestPath = Join-Path $scriptDir "components.json"
$escapedmanifestPath = $manifestPath.Replace("'", "''")
if (Test-Path $manifestPath) {
    $componentMap = Get-Content $manifestPath -Raw | ConvertFrom-Json
} else {
    Write-Log "Manifest components.json not found!" "ERROR"
    exit 1
}

function Test-Dependencies {
    param([string[]]$SelectedComponents)
    $missing = @{}
    foreach ($compName in $SelectedComponents) {
        $comp = $componentMap | Where-Object { $_.Name -eq $compName }
        if ($comp -and $comp.Deps) {
            foreach ($dep in $comp.Deps) {
                if ($dep -notin $SelectedComponents) {
                    if (-not $missing.ContainsKey($compName)) { $missing[$compName] = @() }
                    $missing[$compName] += $dep
                }
            }
        }
    }
    if ($missing.Count -gt 0) {
        Write-Log "Dependency warnings:" "WARN"
        foreach ($comp in $missing.Keys) {
            Write-Log "  $comp requires: $($missing[$comp] -join ', ') — these will be auto-added" "WARN"
        }
        foreach ($comp in $missing.Keys) {
            foreach ($dep in $missing[$comp]) {
                if ($dep -notin $SelectedComponents) {
                    $Script:SelectedComponents += $dep
                }
            }
        }
    }
}

# --- Interactive menu ---
function Show-Menu {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "  Windows 10 → Windows 7 Transformation" -ForegroundColor Cyan
    Write-Host "  Pack Installer" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Select components to install (by number)." -ForegroundColor White
    Write-Host "Separate multiple numbers with commas (e.g. 1,3,5)." -ForegroundColor White
    Write-Host "Enter 'A' for all, 'Q' to quit." -ForegroundColor White
    Write-Host ""

    for ($i = 0; $i -lt $componentMap.Count; $i++) {
        $risk = if ($componentMap[$i].Risk) { $componentMap[$i].Risk } else { "Unknown" }
        $riskColor = switch ($risk) {
            "Low" { "Green" }
            "Medium" { "Yellow" }
            "High" { "Red" }
            "Critical" { "Magenta" }
            Default { "White" }
        }
        Write-Host "  $($i+1). $($componentMap[$i].Name) " -NoNewline -ForegroundColor Yellow
        Write-Host "[$risk Risk]" -ForegroundColor $riskColor
        Write-Host "      $($componentMap[$i].Desc)" -ForegroundColor Gray
    }
    Write-Host ""
}

function Show-PreflightReport {
    param([string[]]$SelectedComponents)

    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "          PREFLIGHT RISK REPORT" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "The following components will be installed:" -ForegroundColor White
    Write-Host ""

    $maxRisk = "Low"
    foreach ($compName in $SelectedComponents) {
        $comp = $componentMap | Where-Object { $_.Name -eq $compName }
        $risk = if ($comp.Risk) { $comp.Risk } else { "Low" }
        $riskColor = switch ($risk) {
            "Low" { "Green" }
            "Medium" { "Yellow" }
            "High" { "Red" }
            "Critical" { "Magenta" }
            Default { "White" }
        }
        Write-Host "  - $($compName.PadRight(15)) [Risk: " -NoNewline
        Write-Host "$risk" -NoNewline -ForegroundColor $riskColor
        Write-Host "]"

        # Update max risk for summary
        if ($risk -eq "Critical") { $maxRisk = "Critical" }
        elseif ($risk -eq "High" -and $maxRisk -ne "Critical") { $maxRisk = "High" }
        elseif ($risk -eq "Medium" -and $maxRisk -notin @("High", "Critical")) { $maxRisk = "Medium" }
    }

    Write-Host ""
    Write-Host "SUMMARY RISK LEVEL: " -NoNewline
    $summaryColor = switch ($maxRisk) {
        "Low" { "Green" }
        "Medium" { "Yellow" }
        "High" { "Red" }
        "Critical" { "Magenta" }
    }
    Write-Host "$maxRisk" -ForegroundColor $summaryColor

    if ($maxRisk -eq "Critical" -or $maxRisk -eq "High") {
        Write-Host "WARNING: High/Critical risk components can affect system stability or boot." -ForegroundColor Red
        Write-Host "Ensure you have a full system backup before proceeding." -ForegroundColor Red
    }
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
}

function Install-Components {
    param([string[]]$Components)

    Write-Log "Starting installation with components: $($Components -join ', ')" "INFO"
    Write-Log "Language: $global:InstallLanguage" "INFO"
    Write-Log "Log: $LogPath" "INFO"

    if ($WhatIfPreference) {
        Write-Log "WHATIF: Dry-run mode — no changes will be made" "WARN"
    }

    if (-not $NoRestorePoint -and -not $WhatIfPreference) { New-RestorePoint }

    # Load backup module and initialize backup session
    Write-Log "Initializing backup system..." "INFO"
    $backupMod = Join-Path $scriptDir "Backup\BackupModule.ps1"
$escapedbackupMod = $backupMod.Replace("'", "''")
    if (Test-Path $backupMod) {
        . $backupMod
        $backupSession = Initialize-Backup
        Write-Log "Backup initialized: $backupSession" "INFO"

        # Create full backup snapshot of all system files the pack touches
        if (-not $WhatIfPreference) {
            Write-Log "Creating backup snapshot of system files..." "INFO"
            $backupCount = Backup-AllSystemFiles
            Write-Log "Snapshot complete: $backupCount files/directories backed up" "OK"
        }
    } else {
        Write-Log "BackupModule not found at $backupMod" "WARN"
    }

    $successCount = 0
    $failCount = 0

    foreach ($compName in $Components) {
        $entry = $componentMap | Where-Object { $_.Name -eq $compName }
        if (-not $entry) {
            Write-Log "Unknown component: $compName" "WARN"
            continue
        }

        $func = $entry.Func
        try {
            $result = & $func
            if ($result -eq $true) {
                $successCount++
            } else {
                Write-Log "Component '$compName' reported failure" "ERROR"
                $failCount++
            }
        } catch {
            Write-Log "Component '$compName' failed: $_" "ERROR"
            $failCount++
        }
        Write-Log ""
    }

    Write-Log "========================================" "INFO"
    Write-Log "Installation complete." "OK"
    Write-Log "Components installed: $successCount" "OK"
    if ($failCount -gt 0) { Write-Log "Components with errors: $failCount" "ERROR" }
    Write-Log "Log saved to: $LogPath" "INFO"
    Write-Log "========================================" "INFO"

    Write-Host ""
    Write-Host "IMPORTANT: Some components require manual steps (see log)." -ForegroundColor Yellow
    Write-Host "A reboot may be needed for some changes to take effect." -ForegroundColor Yellow
}

# --- Main ---
try {
    Start-Transcript -Path "$scriptDir\install_transcript.log" -Append | Out-Null
    Write-Log "=== Windows 10 to Windows 7 Transformation Pack Installer ===" "INFO"
    Write-Log "Started at $(Get-Date)" "INFO"
    Write-Log "Language: $global:InstallLanguage" "INFO"
    if ($WhatIfPreference) { Write-Log "WHATIF mode enabled — no changes will be applied" "WARN" }

    if (-not (Test-Prerequisites)) {
        Write-Log "Prerequisites check failed. Fix the issues above and re-run." "ERROR"
        exit 1
    }

    if ($Silent -and -not $All -and -not $Components) {
        Write-Log "-Silent requires either -All or -Components" "ERROR"
        exit 1
    }

    if ($All) {
        $selectedComponents = $componentMap.Name
    } elseif ($Components) {
        $selectedComponents = $Components -split ',' | ForEach-Object { $_.Trim() }
    } else {
        Show-Menu
        $input = Read-Host "Enter choice(s)"
        if ($input -eq 'Q' -or $input -eq 'q') {
            Write-Log "Installation cancelled by user" "INFO"
            exit 0
        }
        if ($input -eq 'A' -or $input -eq 'a') {
            $selectedComponents = $componentMap.Name
        } else {
            $indices = $input -split ',' | ForEach-Object { $_.Trim() } | Where-Object { $_ -match '^\d+$' }
$escapedindices = $indices.Replace("'", "''")
            $selectedComponents = $indices | ForEach-Object {
                $idx = [int]$_ - 1
                if ($idx -ge 0 -and $idx -lt $componentMap.Count) { $componentMap[$idx].Name }
            }
            if ($selectedComponents.Count -eq 0) {
                Write-Log "No valid components selected" "ERROR"
                exit 1
            }
        }
    }

    # Resolve dependencies
    Test-Dependencies -SelectedComponents $selectedComponents

    # Deduplicate
    $selectedComponents = $selectedComponents | Select-Object -Unique

    # Show preflight report
    if (-not $Silent -and -not $WhatIfPreference -and -not $All) {
        Show-PreflightReport -SelectedComponents $selectedComponents

        # Generate Change Inventory (Static list based on manifest)
        Write-Host "CHANGE INVENTORY:" -ForegroundColor Cyan
        foreach ($compName in $selectedComponents) {
            $comp = $componentMap | Where-Object { $_.Name -eq $compName }
            Write-Host "  [$($comp.Name)]" -ForegroundColor Yellow
            Write-Host "    Purpose: $($comp.Desc)" -ForegroundColor Gray
            if ($comp.Deps) { Write-Host "    Dependencies: $($comp.Deps -join ', ')" -ForegroundColor Gray }
        }
        Write-Host ""

        $confirm = Read-Host "Do you want to proceed with the installation? (Y/N)"
        if ($confirm -ne 'Y' -and $confirm -ne 'y') {
            Write-Log "Installation cancelled by user" "INFO"
            exit 0
        }
    }

    Install-Components -Components $selectedComponents
} finally {
    try { Stop-Transcript | Out-Null } catch { }
}