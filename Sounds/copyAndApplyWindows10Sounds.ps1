#requires -RunAsAdministrator

$scriptDir = Split-Path -Parent $PSCommandPath
$escapedscriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $escapedScriptDir.Replace("'", "''")
$powerRun = "$scriptDir\..\PowerRun\PowerRun_x64.exe"
$escapedpowerRun = $powerRun.Replace("'", "''")

if (-not (Test-Path $powerRun)) {
    Write-Error "PowerRun not found at: $powerRun"
    exit 1
}

$soundsSource = "$scriptDir\Windows 10 Sounds"
$escapedsoundsSource = $soundsSource.Replace("'", "''")
$regFile = "$scriptDir\Windows 10 Sounds Settings.reg"
$escapedregFile = $regFile.Replace("'", "''")

if (Test-Path $soundsSource) {
    $copyCmd = "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$escapedsoundsSource\*' -Destination 'C:\Windows\Media' -Recurse -Force"
$escapedcopyCmd = $copyCmd.Replace("'", "''")
    Start-Process $powerRun -ArgumentList $copyCmd -Wait -WindowStyle Hidden
    Write-Host "Sound files copied to C:\Windows\Media" -ForegroundColor Green
} else {
    Write-Warning "Windows 10 Sounds folder not found at: $soundsSource"
}

if (Test-Path $regFile) {
    Start-Process $powerRun -ArgumentList "reg import `"$regFile`"" -WindowStyle Hidden -Wait
    Write-Host "Windows 10 sound scheme applied" -ForegroundColor Green
} else {
    Write-Warning "Registry file not found at: $regFile"
}