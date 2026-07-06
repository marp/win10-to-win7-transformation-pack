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

# === Backup existing files before modification ===
$__sDir = Split-Path -Parent $PSCommandPath
$escaped__sDir = $__sDir.Replace("'", "''")
$__bkMod = Join-Path $__sDir "..\Backup\BackupModule.ps1"
$escaped__bkMod = $__bkMod.Replace("'", "''")
if (Test-Path $__bkMod) {
    . $__bkMod
    Initialize-Backup | Out-Null
    Backup-BeforeCopy -Source $scriptDir -Destination "C:\Windows\Resources\Themes" -Recurse -UsePowerRun
}

$copyCmd = "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$escapedScriptDir\*' -Destination 'C:\Windows\Resources\Themes\' -Recurse -Force"
$escapedcopyCmd = $copyCmd.Replace("'", "''")
$cleanCmd = "powershell -ExecutionPolicy Bypass -Command Remove-Item -Path 'C:\Windows\Resources\Themes\copy.ps1' -Force"
$escapedcleanCmd = $cleanCmd.Replace("'", "''")

$p1 = Start-Process $powerRun -ArgumentList $copyCmd -Wait -WindowStyle Hidden -PassThru
$escapedp1 = if ($null -ne $p1) { $p1.ToString().Replace("'", "''") } else { $null }
if ($p1.ExitCode -ne 0) { throw "Theme copy failed with exit code $($p1.ExitCode)" }

$p2 = Start-Process $powerRun -ArgumentList $cleanCmd -Wait -WindowStyle Hidden -PassThru
$escapedp2 = if ($null -ne $p2) { $p2.ToString().Replace("'", "''") } else { $null }
if ($p2.ExitCode -ne 0) { throw "Cleanup of copy.ps1 failed with exit code $($p2.ExitCode)" }

Write-Host "Themes copied to C:\Windows\Resources\Themes" -ForegroundColor Green