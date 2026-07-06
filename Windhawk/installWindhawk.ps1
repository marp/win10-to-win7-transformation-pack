#requires -RunAsAdministrator

$scriptDir = Split-Path -Parent $PSCommandPath
$escapedscriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $escapedScriptDir.Replace("'", "''")
Set-Location -Path $scriptDir

Start-Process -FilePath "$scriptDir\windhawk_setup.exe" -ArgumentList "/S" -Wait