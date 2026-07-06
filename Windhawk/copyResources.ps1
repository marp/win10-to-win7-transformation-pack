#requires -RunAsAdministrator
# === Backup existing files before modification ===
$__sDir = Split-Path -Parent $PSCommandPath
$escaped__sDir = $__sDir.Replace("'", "''")
$__bkMod = Join-Path $__sDir "..\Backup\BackupModule.ps1"
$escaped__bkMod = $__bkMod.Replace("'", "''")
if (Test-Path $__bkMod) { . $__bkMod; Initialize-Backup -BackupRoot (Join-Path $__sDir "..\Backup") | Out-Null }

$scriptDir = Split-Path -Parent $PSCommandPath
$escapedscriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $escapedScriptDir.Replace("'", "''")
$resourceDir = "$scriptDir\ResourceRedirect"
$escapedresourceDir = $resourceDir.Replace("'", "''")

if (Test-Path $resourceDir) {
    Copy-Item -Path $resourceDir -Destination 'C:\Windows\' -Recurse -Force
    Write-Host "ResourceRedirect copied to C:\Windows\ResourceRedirect" -ForegroundColor Green
} else {
    Write-Warning "ResourceRedirect directory not found at: $resourceDir"
}