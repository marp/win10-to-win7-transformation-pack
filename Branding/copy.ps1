#requires -RunAsAdministrator

$scriptDir = Split-Path -Parent $PSCommandPath
$escapedscriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $escapedScriptDir.Replace("'", "''")
$powerRun = "$scriptDir\..\PowerRun\PowerRun_x64.exe"
$escapedpowerRun = $powerRun.Replace("'", "''")

if (-not (Test-Path $powerRun)) {
    Write-Error "PowerRun not found at: $powerRun"
    return
}

$brandingSource = "$scriptDir\Branding"
$escapedbrandingSource = $brandingSource.Replace("'", "''")
$escapedBrandingSource = $brandingSource.Replace("'", "''")
# === Backup existing files before modification ===
$__sDir = Split-Path -Parent $PSCommandPath
$escaped__sDir = $__sDir.Replace("'", "''")
$__bkMod = Join-Path $__sDir "..\Backup\BackupModule.ps1"
$escaped__bkMod = $__bkMod.Replace("'", "''")
if (Test-Path $__bkMod) {
    . $__bkMod
    Initialize-Backup | Out-Null
    Backup-BeforeCopy -Source $brandingSource -Destination "C:\Windows\Branding" -Recurse -UsePowerRun
}

$copyCmd = "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$escapedBrandingSource' -Destination 'C:\Windows\' -Recurse -Force"
$escapedcopyCmd = $copyCmd.Replace("'", "''")
$p = Start-Process $powerRun -ArgumentList $copyCmd -Wait -WindowStyle Hidden -PassThru
$escapedp = if ($null -ne $p) { $p.ToString().Replace("'", "''") } else { $null }
if ($p.ExitCode -ne 0) { throw "Branding copy failed with exit code $($p.ExitCode)" }

Write-Host "Branding copied to C:\Windows\Branding" -ForegroundColor Green