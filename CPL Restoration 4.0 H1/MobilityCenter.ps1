#requires -RunAsAdministrator
$scriptDir = Split-Path -Parent $PSCommandPath
$escapedscriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $escapedScriptDir.Replace("'", "''")

# === Backup existing files before modification ===
$__sDir = Split-Path -Parent $PSCommandPath
$escaped__sDir = $__sDir.Replace("'", "''")
$__bkMod = Join-Path $__sDir "..\Backup\BackupModule.ps1"
$escaped__bkMod = $__bkMod.Replace("'", "''")
if (Test-Path $__bkMod) { . $__bkMod; Initialize-Backup -BackupRoot (Join-Path $__sDir "..\Backup") | Out-Null }
Backup-File -Path "C:\Windows\System32\batmete7.dll" -UsePowerRun
$p = Start-Process "$scriptDir\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$escapedScriptDir\Pages\Mobility Center CPL\7 Style\system32\batmete7.dll' -Destination 'C:\Windows\System32' -Recurse -Force" -Wait -WindowStyle Hidden -PassThru
$escapedp = if ($null -ne $p) { $p.ToString().Replace("'", "''") } else { $null }
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }
Backup-File -Path "C:\Windows\System32\mblctr.exe" -UsePowerRun
$p = Start-Process "$scriptDir\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$escapedScriptDir\Pages\Mobility Center CPL\7 Style\system32\mblctr.exe' -Destination 'C:\Windows\System32' -Recurse -Force" -Wait -WindowStyle Hidden -PassThru
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }
$__bkSrc = Join-Path $scriptDir "Pages\Mobility Center CPL\7 Style\system32\en-US"
$escaped__bkSrc = $__bkSrc.Replace("'", "''")
if (Test-Path $__bkSrc) { Backup-BeforeCopy -Source $__bkSrc -Destination "C:\Windows\System32\en-US" -Recurse -UsePowerRun }
$p = Start-Process "$scriptDir\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$escapedScriptDir\Pages\Mobility Center CPL\7 Style\system32\en-US\*' -Destination 'C:\Windows\System32\en-US' -Recurse -Force" -Wait -WindowStyle Hidden -PassThru
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }