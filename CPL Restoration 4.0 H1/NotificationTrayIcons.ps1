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
$__bkSrc = Join-Path $scriptDir "Pages\Notification Tray Icons CPL\Optional\8.X Style"
$escaped__bkSrc = $__bkSrc.Replace("'", "''")
if (Test-Path $__bkSrc) { Backup-BeforeCopy -Source $__bkSrc -Destination "C:\Windows\System32" -Recurse -UsePowerRun }
$p = Start-Process "$scriptDir\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$escapedScriptDir\Pages\Notification Tray Icons CPL\Optional\8.X Style\*' -Destination 'C:\Windows\System32' -Recurse -Force" -Wait -WindowStyle Hidden -PassThru
$escapedp = if ($null -ne $p) { $p.ToString().Replace("'", "''") } else { $null }
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }
$p = Start-Process reg.exe -ArgumentList "import `"$scriptDir\Pages\Notification Tray Icons CPL\Notification1.reg`"" -WindowStyle Hidden -Wait -PassThru
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }