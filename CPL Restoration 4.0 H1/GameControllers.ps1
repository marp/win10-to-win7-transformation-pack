#requires -RunAsAdministrator
$scriptDir = Split-Path -Parent $PSCommandPath
$escapedscriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $escapedScriptDir.Replace("'", "''")
$p = Start-Process "$scriptDir\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\don''t load' -Name 'joy.cpl' -Force" -WindowStyle Hidden -Wait -PassThru
$escapedp = if ($null -ne $p) { $p.ToString().Replace("'", "''") } else { $null }
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }
reg import "$scriptDir\Pages\Game Controllers CPL\Vista Style\Import Normally\joy.reg"