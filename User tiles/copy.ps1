#requires -RunAsAdministrator

$scriptDir = Split-Path -Parent $PSCommandPath
$escapedscriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $escapedScriptDir.Replace("'", "''")
$powerRun = "$scriptDir\..\PowerRun\PowerRun_x64.exe"
$escapedpowerRun = $powerRun.Replace("'", "''")
$destDir = "C:\ProgramData\Microsoft\User Account Pictures\Default Pictures"
$escapeddestDir = $destDir.Replace("'", "''")

# === Backup existing files before modification ===
$__bkMod = Join-Path $scriptDir "..\Backup\BackupModule.ps1"
$escaped__bkMod = $__bkMod.Replace("'", "''")
if (Test-Path $__bkMod) { . $__bkMod; Initialize-Backup -BackupRoot (Join-Path $scriptDir "..\Backup") | Out-Null }

if (-not (Test-Path $powerRun)) {
    Write-Error "PowerRun not found at: $powerRun"
    exit 1
}

$mkdirCmd = "powershell -ExecutionPolicy Bypass -Command New-Item -Name 'Default Pictures' -Path 'C:\ProgramData\Microsoft\User Account Pictures\' -ItemType 'Directory' -Force"
$escapedmkdirCmd = $mkdirCmd.Replace("'", "''")
Start-Process $powerRun -ArgumentList $mkdirCmd -Wait -WindowStyle Hidden

# Backup destination before overwriting
Backup-BeforeCopy -Source "$scriptDir" -Destination "$destDir" -Recurse -UsePowerRun

$copyCmd = "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$escapedScriptDir\*' -Destination '$escapeddestDir\' -Recurse -Force"
$escapedcopyCmd = $copyCmd.Replace("'", "''")
Start-Process $powerRun -ArgumentList $copyCmd -Wait -WindowStyle Hidden

$cleanCmd = "powershell -ExecutionPolicy Bypass -Command Remove-Item -Path '$escapeddestDir\copy.ps1' -Force"
$escapedcleanCmd = $cleanCmd.Replace("'", "''")
Start-Process $powerRun -ArgumentList $cleanCmd -Wait -WindowStyle Hidden

Write-Host "User tiles copied to $destDir" -ForegroundColor Green