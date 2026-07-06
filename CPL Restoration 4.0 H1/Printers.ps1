#requires -RunAsAdministrator
$scriptDir = Split-Path -Parent $PSCommandPath
$escapedscriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $escapedScriptDir.Replace("'", "''")
$p = Start-Process "$scriptDir\..\PowerRun\PowerRun_x64.exe" -ArgumentList "reg import `"$scriptDir\Pages\Printers CPL\Vista Style\Import as TrustedInstaller\printers.reg`"" -WindowStyle Hidden -Wait -PassThru
$escapedp = if ($null -ne $p) { $p.ToString().Replace("'", "''") } else { $null }
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }