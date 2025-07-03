# Check if running as administrator
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    # Relaunch as administrator
    Start-Process PowerShell -Verb RunAs "-File `"$PSCommandPath`""
    exit
}

# Ensure script runs in its own directory
Set-Location -Path (Split-Path -Parent $PSCommandPath)

Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '.\Windows 10 Sounds\*' -Destination 'C:\Windows\Media' -Recurse -Force" -Wait -WindowStyle Hidden
Write-Host "Files copied successfully!" -ForegroundColor Green

# Set Windows 10 sounds as default
Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList 'reg import ".\Windows 10 Sounds Settings.reg"' -WindowStyle Hidden -Wait
Write-Host "Windows 10 sounds applied successfully!" -ForegroundColor Green
