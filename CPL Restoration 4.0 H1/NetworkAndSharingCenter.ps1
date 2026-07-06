#requires -RunAsAdministrator
$scriptDir = Split-Path -Parent $PSCommandPath
$escapedscriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $escapedScriptDir.Replace("'", "''")

Set-Location -Path (Split-Path -Parent $PSCommandPath)

# === Backup existing files before modification ===
$__sDir = Split-Path -Parent $PSCommandPath
$escaped__sDir = $__sDir.Replace("'", "''")
$__bkMod = Join-Path $__sDir "..\Backup\BackupModule.ps1"
$escaped__bkMod = $__bkMod.Replace("'", "''")
if (Test-Path $__bkMod) { . $__bkMod; Initialize-Backup -BackupRoot (Join-Path $__sDir "..\Backup") | Out-Null }



$powerRun = "$scriptDir\..\PowerRun\PowerRun_x64.exe"
$escapedpowerRun = $powerRun.Replace("'", "''")
$resHack = "$scriptDir\..\resource_hacker\ResourceHacker.exe"
$escapedresHack = $resHack.Replace("'", "''")
$pageDir = "$scriptDir\Pages\Network and Sharing Center CPL"
$escapedpageDir = $pageDir.Replace("'", "''")

# Patch netcenter.dll with 7-style resources using Resource Hacker
# Backup: original netcenter.dll before ResourceHacker patching
Backup-File -Path "C:\Windows\System32\netcenter.dll" -UsePowerRun
$p = Start-Process $powerRun -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path 'C:\Windows\System32\netcenter.dll' -Destination '$escapedpageDir\' -Force" -Wait -WindowStyle Hidden -PassThru
$escapedp = if ($null -ne $p) { $p.ToString().Replace("'", "''") } else { $null }
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }
$p = Start-Process $resHack -ArgumentList "-open `"$pageDir\netcenter.dll`"", "-resource `"$pageDir\7 Style\system32\netcenter.dll\netcenter.res`"", "-save `"$pageDir\netcenter.dll`"", "-action addoverwrite" -Wait -WindowStyle Hidden -PassThru
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }
$p = Start-Process $powerRun -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$escapedpageDir\netcenter.dll' -Destination 'C:\Windows\System32\' -Force" -Wait -WindowStyle Hidden -PassThru
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }
$p = Start-Process $powerRun -ArgumentList "powershell -ExecutionPolicy Bypass -Command Remove-Item -Path '$escapedpageDir\netcenter.dll' -Force" -Wait -WindowStyle Hidden -PassThru
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }

# Copy MUI for netcenter.dll
# Backup: original netcenter.dll.mui before overwriting
Backup-File -Path "C:\Windows\System32\en-US\netcenter.dll.mui" -UsePowerRun
$p = Start-Process $powerRun -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$escapedpageDir\7 Style\system32\en-US\netcenter.dll.mui' -Destination 'C:\Windows\System32\en-US' -Recurse -Force" -Wait -WindowStyle Hidden -PassThru
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }

# Import Connect To registry
$p = Start-Process $powerRun -ArgumentList "reg import `"$pageDir\Import as TrustedInstaller\connectto.reg`"" -WindowStyle Hidden -Wait -PassThru
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }

# Copy network dialogs scripts to System32
# Backup: network dialogs before overwriting
$__nscSrc = Join-Path $pageDir "7 Style\Windows 7 Network Dialogs\system32"
$escaped__nscSrc = $__nscSrc.Replace("'", "''")
if (Test-Path $__nscSrc) { Backup-BeforeCopy -Source $__nscSrc -Destination "C:\Windows\System32" -Recurse -UsePowerRun }
$p = Start-Process $powerRun -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$escapedpageDir\7 Style\Windows 7 Network Dialogs\system32\*' -Destination 'C:\Windows\System32' -Recurse -Force" -Wait -WindowStyle Hidden -PassThru
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }

# Import PNIDUI registry for network flyout
$p = Start-Process $powerRun -ArgumentList "reg import `"$pageDir\7 Style\Windows 7 Network Dialogs\Import as TrustedInstaller\pnidui.reg`"" -WindowStyle Hidden -Wait -PassThru
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }

Write-Host ""
Write-Host "Network and Sharing Center CPL installed." -ForegroundColor Green
Write-Host "  For the 7-style network flyout, install PNIDUI.dll from aubymori.github.io" -ForegroundColor Yellow