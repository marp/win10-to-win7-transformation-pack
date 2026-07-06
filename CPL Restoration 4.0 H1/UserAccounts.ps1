#requires -RunAsAdministrator
$scriptDir = Split-Path -Parent $PSCommandPath
$escapedscriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $scriptDir.Replace("'", "''")
$escapedScriptDir = $escapedScriptDir.Replace("'", "''")
# Ensure script runs in its own directory
Set-Location -Path (Split-Path -Parent $PSCommandPath)

# === Backup existing files before modification ===
$__sDir = Split-Path -Parent $PSCommandPath
$escaped__sDir = $__sDir.Replace("'", "''")
$__bkMod = Join-Path $__sDir "..\Backup\BackupModule.ps1"
$escaped__bkMod = $__bkMod.Replace("'", "''")
if (Test-Path $__bkMod) { . $__bkMod; Initialize-Backup -BackupRoot (Join-Path $__sDir "..\Backup") | Out-Null }



# Copy "usercpl.dll.mui" located at
# "CPL Restoration\Pages\User Accounts CPL\7 Style\system32\en-US"
# into
# "C:\Windows\System32\en-US"
$p = Start-Process "$scriptDir\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$escapedScriptDir\Pages\User Accounts CPL\7 Style\system32\en-US\usercpl.dll.mui' -Destination 'C:\Windows\System32\en-US\' -Recurse -Force" -Wait -WindowStyle Hidden -PassThru
$escapedp = if ($null -ne $p) { $p.ToString().Replace("'", "''") } else { $null }
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }


# KOPY "C:\Windows\SystemResources\usercpl.dll.mun"  into "CPL Restoration 4.0 H1\Pages\User Accounts CPL"
# Use Resource Hacker to import the included resource file(usercpl.res,located in "CPL Restoration\Pages\User Accounts CPL\7 Style\systemresources\usercpl.dll.mun" 
# into the usercpl.dll.mun file 
# KOPY  "CPL Restoration 4.0 H1\Pages\User Accounts CPLusercpl.dll.mun" into "C:\Windows\SystemResources\usercpl.dll.mun" 
# Backup: original usercpl.dll.mun before ResourceHacker patching
Backup-File -Path "C:\Windows\SystemResources\usercpl.dll.mun" -UsePowerRun
$p = Start-Process "$scriptDir\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path 'C:\Windows\SystemResources\usercpl.dll.mun' -Destination '$escapedScriptDir\Pages\User Accounts CPL\' -Recurse -Force" -Wait -WindowStyle Hidden -PassThru
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }
$p = Start-Process "$scriptDir\..\resource_hacker\ResourceHacker.exe" -ArgumentList "-open `"$scriptDir\Pages\User Accounts CPL\usercpl.dll.mun`"", '-resource "$scriptDir\Pages\User Accounts CPL\7 Style\systemresources\usercpl.dll.mun\usercpl.res"', "-save `"$scriptDir\Pages\User Accounts CPL\usercpl.dll.mun`"", '-action addoverwrite'
Start-Process "$scriptDir\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$escapedScriptDir\Pages\User Accounts CPL\usercpl.dll.mun' -Destination 'C:\Windows\SystemResources\' -Recurse -Force" -Wait -WindowStyle Hidden -PassThru
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }
$p = Start-Process "$scriptDir\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Remove-Item -Path '$escapedScriptDir\Pages\User Accounts CPL\usercpl.dll.mun' -Force" -Wait -WindowStyle Hidden -PassThru
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }

# KOPY "C:\Windows\system32\shacct.dll"  into "CPL Restoration 4.0 H1\Pages\User Accounts CPL"
# Use Resource Hacker to import the included resource file(shacct.res,located in "$scriptDir\Pages\User Accounts CPL\7 Style\system32\shacct.dll"
# into the shacct.dll file located in "CPL Restoration 4.0 H1\Pages\User Accounts CPL"
# KOPY "CPL Restoration 4.0 H1\Pages\User Accounts CPL\shacct.dll" into "C:\Windows\system32" 
# Backup: original shacct.dll before ResourceHacker patching
Backup-File -Path "C:\Windows\system32\shacct.dll" -UsePowerRun
$p = Start-Process "$scriptDir\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path 'C:\Windows\system32\shacct.dll' -Destination '$escapedScriptDir\Pages\User Accounts CPL\' -Recurse -Force" -Wait -WindowStyle Hidden -PassThru
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }
$p = Start-Process "$scriptDir\..\resource_hacker\ResourceHacker.exe" -ArgumentList "-open `"$scriptDir\Pages\User Accounts CPL\shacct.dll`"", "-resource `"$scriptDir\Pages\User Accounts CPL\7 Style\system32\shacct.dll\shacct.res`"", "-save `"$scriptDir\Pages\User Accounts CPL\shacct.dll`"", '-action addoverwrite'
Start-Process "$scriptDir\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '$escapedScriptDir\Pages\User Accounts CPL\shacct.dll' -Destination 'C:\Windows\system32\' -Recurse -Force" -Wait -WindowStyle Hidden -PassThru
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }
$p = Start-Process "$scriptDir\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Remove-Item -Path '$escapedScriptDir\Pages\User Accounts CPL\shacct.dll' -Force" -Wait -WindowStyle Hidden -PassThru
if ($null -eq $p -or $p.ExitCode -ne 0) { throw "Command failed with exit code $($p.ExitCode)" }