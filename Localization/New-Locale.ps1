<#
.SYNOPSIS
    Creates empty locale directory structure for a new language.
.DESCRIPTION
    Scans all CPL page directories for en-US MUI files and creates
    corresponding empty directories for the specified locale.
.PARAMETER Locale
    Locale code (e.g., "pl-PL", "de-DE", "fr-FR", "es-ES", etc.)
.EXAMPLE
    .\Localization\New-Locale.ps1 -Locale "pl-PL"
#>

#requires -RunAsAdministrator
#requires -Version 5.0

param(
    [Parameter(Mandatory = $true)]
    [string]$Locale
)

$scriptDir = Split-Path -Parent $PSCommandPath
$escapedscriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $escapedScriptDir.Replace("'", "''")
$packRoot = Split-Path -Parent $scriptDir
$escapedpackRoot = $packRoot.Replace("'", "''")
$cplRoot = "$packRoot\CPL Restoration 4.0 H1"
$escapedcplRoot = $cplRoot.Replace("'", "''")
$created = 0

# Simple locale code validation (xx-XX or xx)
if ($Locale -notmatch '^[a-z]{2}(-[A-Z]{2})?$') {
    Write-Error "Invalid locale format. Use e.g., 'pl-PL', 'de-DE', 'fr-FR'"
    exit 1
}

# Find all en-US locale directories under Pages and create matching locale dirs
Get-ChildItem -Path "$cplRoot\Pages" -Recurse -Directory | Where-Object {
    $_.Name -eq "en-US"
} | ForEach-Object {
    $parentDir = $_.Parent.FullName
    $newLocaleDir = Join-Path $parentDir $Locale
$escapednewLocaleDir = $newLocaleDir.Replace("'", "''")
    if (-not (Test-Path $newLocaleDir)) {
        New-Item -Path $newLocaleDir -ItemType Directory -Force | Out-Null
        Write-Host "Created: $newLocaleDir" -ForegroundColor Green
        $created++
    }
}

# Also check Extras folders
Get-ChildItem -Path "$cplRoot\Extras" -Recurse -Directory | Where-Object {
    $_.Name -eq "en-US"
} | ForEach-Object {
    $parentDir = $_.Parent.FullName
    $newLocaleDir = Join-Path $parentDir $Locale
    if (-not (Test-Path $newLocaleDir)) {
        New-Item -Path $newLocaleDir -ItemType Directory -Force | Out-Null
        Write-Host "Created: $newLocaleDir" -ForegroundColor Green
        $created++
    }
}

Write-Host ""
Write-Host "Locale '$Locale' setup complete." -ForegroundColor Cyan
Write-Host "Directories created: $created" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Translate the en-US .mui files in each directory to $Locale" -ForegroundColor Yellow
Write-Host "2. Copy the translated .mui files to the corresponding $Locale directories" -ForegroundColor Yellow
Write-Host "3. Test by running: .\install.ps1 -Language '$Locale' -Components CPL" -ForegroundColor Yellow