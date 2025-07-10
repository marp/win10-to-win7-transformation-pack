# Check if running as administrator
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    # Relaunch as administrator
    Start-Process PowerShell -Verb RunAs "-File `"$PSCommandPath`""
    exit
}

# Ensure script runs in its own directory
Set-Location -Path (Split-Path -Parent $PSCommandPath)

Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command New-Item -Name 'Default Pictures' -Path 'C:\ProgramData\Microsoft\User Account Pictures\' -ItemType 'Directory' -Force" -Wait -WindowStyle Hidden
Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '.\*' -Destination 'C:\ProgramData\Microsoft\User Account Pictures\Default Pictures\' -Recurse -Force" -Wait -WindowStyle Hidden
Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Remove-Item -Path 'C:\ProgramData\Microsoft\User Account Pictures\Default Pictures\copy.ps1' -Force" -Wait -WindowStyle Hidden

Write-Host "Files copied successfully!" -ForegroundColor Green