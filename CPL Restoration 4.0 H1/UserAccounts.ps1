# # Get the directory where the script is being executed
# $scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# # PART 1: Import usercpl.res into usercpl.dll.mun or usercpl.dll
# $usercplResFile = Join-Path $scriptDir "Pages\User Accounts CPL\7 Style\systemresources\usercpl.dll.mun\usercpl.res"
# $usercplDllMunPath = "C:\Windows\SystemResources\usercpl.dll.mun"
# $usercplDllPathOld = "C:\Windows\System32\usercpl.dll"

# $powerRunExe = Join-Path $scriptDir "PowerRun\PowerRun_x64.exe"
# $resourceHackerExe = Join-Path $scriptDir "resource_hacker\ResourceHacker.exe"

# # Check Windows version and decide which path to use
# $windowsVersion = [System.Environment]::OSVersion.Version
# if ($windowsVersion.Major -ge 10 -and $windowsVersion.Build -ge 17763) {
#     # Windows 10 1809 or newer: Use the system resources file location
#     $targetDllPath = $usercplDllMunPath
# } else {
#     # Windows 10 older versions: Use the system32 file location
#     $targetDllPath = $usercplDllPathOld
# }

# # Run Resource Hacker to modify the DLL
# Start-Process $resourceHackerExe -ArgumentList "-modify", "`"$targetDllPath`"", "-add", "`"$usercplResFile`"", "USER", "1033", "-overwrite" -Wait -WindowStyle Hidden

# # PART 2: Import shacct.res into shacct.dll
# $shacctDllFile = Join-Path $scriptDir "Pages\User Accounts CPL\7 Style\system32\shacct.dll\shacct.res"
# $shacctDllPath = "C:\Windows\System32\shacct.dll"

# # Run PowerRun with Resource Hacker to modify shacct.dll
# Start-Process $powerRunExe -ArgumentList "`"$resourceHackerExe`", `"-modify`", "`"$shacctDllPath`"", `"-add`", "`"$shacctDllFile`"", "USER", "1033", "-overwrite" -Wait -WindowStyle Hidden

# # PART 3: Copy usercpl.dll.mui to C:\Windows\System32\en-US
# $enUSDir = Join-Path $scriptDir "Pages\User Accounts CPL\7 Style\system32\en-US"

# # Use PowerRun to copy the item
# Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell", "-ExecutionPolicy", "Bypass", "-Command", "Copy-Item -Path '$enUSDir' -Destination 'C:\Windows\System32' -Recurse -Force" -Wait -WindowStyle Hidden


# Get the directory where the script is being executed
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# PART 1: Import usercpl.res into usercpl.dll.mun or usercpl.dll
$usercplResFile = Join-Path $scriptDir "Pages\User Accounts CPL\7 Style\systemresources\usercpl.dll.mun\usercpl.res"
$usercplDllMunPath = "C:\Windows\SystemResources\usercpl.dll.mun"
$usercplDllPathOld = "C:\Windows\System32\usercpl.dll"

# PowerRun and ResourceHacker paths
$powerRunExe = Join-Path $scriptDir ".\..\PowerRun\PowerRun_x64.exe"
$resourceHackerExe = Join-Path $scriptDir ".\..\resource_hacker\ResourceHacker.exe"

# Check Windows version and decide which path to use
$windowsVersion = [System.Environment]::OSVersion.Version
if ($windowsVersion.Major -ge 10 -and $windowsVersion.Build -ge 17763) {
    # Windows 10 1809 or newer: Use the system resources file location
    $targetDllPath = $usercplDllMunPath
} else {
    # Windows 10 older versions: Use the system32 file location
    $targetDllPath = $usercplDllPathOld
}

# Run Resource Hacker to modify the DLL directly
# & $resourceHackerExe -modify "$targetDllPath" -add "$usercplResFile" USER 1033 -overwrite

# PART 2: Import shacct.res into shacct.dll
# Poprawiona ścieżka do shacct.res
$shacctResFile = "C:\Users\Operator\Downloads\win10-to-win7-transformation-pack-master\CPL Restoration 4.0 H1\Pages\User Accounts CPL\7 Style\system32\shacct.dll\shacct.res"
$shacctDllPath = "C:\Windows\System32\shacct.dll"

# Uruchomienie ResourceHacker dla shacct.dll
& "$resourceHackerExe" -open "$shacctDllPath" -save "$shacctDllPath" -resource "$shacctResFile"

# PART 3: Copy usercpl.dll.mui to C:\Windows\System32\en-US
$enUSDir = Join-Path $scriptDir "Pages\User Accounts CPL\7 Style\system32\en-US"

# Directly copy the files with PowerShell
Copy-Item -Path "$enUSDir" -Destination "C:\Windows\System32\en-US" -Recurse -Force
