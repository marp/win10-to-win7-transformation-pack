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

$soundsSource = "$scriptDir\Windows 7 Sounds"
$escapedsoundsSource = $soundsSource.Replace("'", "''")
$regFile = "$scriptDir\Windows 7 Sounds Settings.reg"
$escapedregFile = $regFile.Replace("'", "''")

if (Test-Path $soundsSource) {
    # === Backup existing files before modification ===
    $__sDir = Split-Path -Parent $PSCommandPath
$escaped__sDir = $__sDir.Replace("'", "''")
    $__bkMod = Join-Path $__sDir "..\Backup\BackupModule.ps1"
$escaped__bkMod = $__bkMod.Replace("'", "''")
    if (Test-Path $__bkMod) {
        . $__bkMod
        Initialize-Backup | Out-Null
        Backup-BeforeCopy -Source $soundsSource -Destination "C:\Windows\Media" -Recurse -UsePowerRun
    }

    $copyCmd = "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$escapedsoundsSource\*' -Destination 'C:\Windows\Media' -Recurse -Force"
$escapedcopyCmd = $copyCmd.Replace("'", "''")
    $p = Start-Process $powerRun -ArgumentList $copyCmd -Wait -WindowStyle Hidden -PassThru
$escapedp = if ($null -ne $p) { $p.ToString().Replace("'", "''") } else { $null }
    if ($p.ExitCode -ne 0) { throw "Sound copy failed with exit code $($p.ExitCode)" }
    Write-Host "Sound files copied to C:\Windows\Media" -ForegroundColor Green
} else {
    Write-Warning "Windows 7 Sounds folder not found at: $soundsSource"
}

if (Test-Path $regFile) {
    $p = Start-Process $powerRun -ArgumentList "reg import `"$regFile`"" -WindowStyle Hidden -Wait -PassThru
    if ($p.ExitCode -ne 0) { throw "Sound registry import failed with exit code $($p.ExitCode)" }
    Write-Host "Windows 7 sound scheme applied" -ForegroundColor Green
} else {
    Write-Warning "Registry file not found at: $regFile"
}