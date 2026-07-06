#requires -RunAsAdministrator
<#
.SYNOPSIS
    Generates color variant .theme files from base Aero10 themes.
    Each variant changes only the DisplayName and ColorizationColor.
#>

$scriptDir = Split-Path -Parent $PSCommandPath
$escapedscriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $escapedScriptDir.Replace("'", "''")
$variants = @(
    @{ NameSuffix = "(Ruby Red)"; Color = "0x6B1E3A8A" }
    @{ NameSuffix = "(Emerald Green)"; Color = "0x6B3E9B4F" }
    @{ NameSuffix = "(Amethyst Purple)"; Color = "0x6B9B59B6" }
    @{ NameSuffix = "(Teal)"; Color = "0x6B4A9580" }
    @{ NameSuffix = "(Orange)"; Color = "0x6B4184F0" }
    @{ NameSuffix = "(Hot Pink)"; Color = "0x6B9B3080" }
)

$bases = @(
    @{ Name = "Aero10 Seven"; File = "Aero10 Seven.theme" }
    @{ Name = "Aero10 Vista"; File = "Aero10 Vista.theme" }
    @{ Name = "Aero10 Metro"; File = "Aero10 Metro 8.theme" }
)

foreach ($base in $bases) {
    $basePath = Join-Path $scriptDir $base.File
$escapedbasePath = $basePath.Replace("'", "''")
    if (-not (Test-Path $basePath)) {
        Write-Warning "Base theme not found: $basePath"
        continue
    }
    $baseContent = Get-Content $basePath -Raw

    foreach ($variant in $variants) {
        $newName = "$($base.Name) $($variant.NameSuffix).theme"
        $newPath = Join-Path $scriptDir $newName
$escapednewPath = $newPath.Replace("'", "''")
        if (Test-Path $newPath) { continue }

        $newContent = $baseContent -replace
            "DisplayName=Aero10: [A-Za-z0-9 ]+",
            "DisplayName=Aero10: $($base.Name.Split(' ')[-1]) $($variant.NameSuffix.Trim('()'))"

        $colorPattern = '(?<=ColorizationColor=)0x[0-9A-Fa-f]{8}'
        if ($newContent -match $colorPattern) {
            $newContent = $newContent -replace $colorPattern, $variant.Color
        }

        Set-Content -Path $newPath -Value $newContent -Encoding UTF8
        Write-Host "Created: $newName" -ForegroundColor Green
    }
}