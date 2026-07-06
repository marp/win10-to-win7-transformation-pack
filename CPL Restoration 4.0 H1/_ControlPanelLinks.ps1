#requires -RunAsAdministrator
$scriptDir = Split-Path -Parent $PSCommandPath
$escapedscriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $escapedScriptDir.Replace("'", "''")
$powerRun = "$scriptDir\..\PowerRun\PowerRun_x64.exe"
$escapedpowerRun = $powerRun.Replace("'", "''")

$cplSource = "$scriptDir\Control Panel Links\Universal\7 Style\system32"
$escapedcplSource = $cplSource.Replace("'", "''")
$cplBat = "$scriptDir\Control Panel Links\Universal\7 Style\Run as TrustedInstaller\cpl7.bat"
$escapedcplBat = $cplBat.Replace("'", "''")

# === Backup existing files before modification ===
$__sDir = Split-Path -Parent $PSCommandPath
$escaped__sDir = $__sDir.Replace("'", "''")
$__bkMod = Join-Path $__sDir "..\Backup\BackupModule.ps1"
$escaped__bkMod = $__bkMod.Replace("'", "''")
if (Test-Path $__bkMod) { . $__bkMod; Initialize-Backup -BackupRoot (Join-Path $__sDir "..\Backup") | Out-Null }
$__bkSrc = Join-Path $__sDir "Control Panel Links\Universal\7 Style\system32"
$escaped__bkSrc = $__bkSrc.Replace("'", "''")
if (Test-Path $__bkSrc) { Backup-BeforeCopy -Source $__bkSrc -Destination "C:\Windows\System32" -Recurse -UsePowerRun }
$copyCmd = "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$escapedcplSource\*' -Destination 'C:\Windows\System32\' -Recurse -Force"
$escapedcopyCmd = $copyCmd.Replace("'", "''")
$p = Start-Process $powerRun -ArgumentList $copyCmd -Wait -WindowStyle Hidden -PassThru
$escapedp = if ($null -ne $p) { $p.ToString().Replace("'", "''") } else { $null }
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }

Start-Process $powerRun -ArgumentList $cplBat