#requires -RunAsAdministrator
$scriptDir = Split-Path -Parent $PSCommandPath
$escapedscriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $escapedScriptDir.Replace("'", "''")
$powerRun = "$scriptDir\..\PowerRun\PowerRun_x64.exe"
$escapedpowerRun = $powerRun.Replace("'", "''")
$regFile = "$scriptDir\Patch CPL Redirection\desktopContextPatch.reg"
$escapedregFile = $regFile.Replace("'", "''")
$vivetool = "$scriptDir\..\ViVeTool\ViVeTool.exe"
$escapedvivetool = $vivetool.Replace("'", "''")

if (Test-Path $regFile) {
    $p = Start-Process $powerRun -ArgumentList "reg import `"$regFile`"" -WindowStyle Hidden -Wait -PassThru
$escapedp = if ($null -ne $p) { $p.ToString().Replace("'", "''") } else { $null }
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }
} else {
    Write-Warning "Registry patch not found at: $regFile"
}

if (Test-Path $vivetool) {
    $p = Start-Process $powerRun -ArgumentList "$vivetool /disable /id:25175482" -WindowStyle Hidden -Wait -PassThru
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }
} else {
    Write-Warning "ViVeTool not found at: $vivetool"
}