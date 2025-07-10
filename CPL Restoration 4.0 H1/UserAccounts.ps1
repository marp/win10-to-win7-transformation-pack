# Ensure script runs in its own directory
Set-Location -Path (Split-Path -Parent $PSCommandPath)

# Copy "usercpl.dll.mui" located at
# "CPL Restoration\Pages\User Accounts CPL\7 Style\system32\en-US"
# into
# "C:\Windows\System32\en-US"
Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '.\Pages\User Accounts CPL\7 Style\system32\en-US\usercpl.dll.mui' -Destination 'C:\Windows\System32\en-US\' -Recurse -Force" -Wait -WindowStyle Hidden


# KOPY "C:\Windows\SystemResources\usercpl.dll.mun"  into "CPL Restoration 4.0 H1\Pages\User Accounts CPL"
# Use Resource Hacker to import the included resource file(usercpl.res,located in "CPL Restoration\Pages\User Accounts CPL\7 Style\systemresources\usercpl.dll.mun" 
# into the usercpl.dll.mun file 
# KOPY  "CPL Restoration 4.0 H1\Pages\User Accounts CPLusercpl.dll.mun" into "C:\Windows\SystemResources\usercpl.dll.mun" 
Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path 'C:\Windows\SystemResources\usercpl.dll.mun' -Destination '.\Pages\User Accounts CPL\' -Recurse -Force" -Wait -WindowStyle Hidden
Start-Process ".\..\resource_hacker\ResourceHacker.exe" -ArgumentList '-open ".\Pages\User Accounts CPL\usercpl.dll.mun"', '-resource "Pages\User Accounts CPL\7 Style\systemresources\usercpl.dll.mun\usercpl.res"', '-save ".\Pages\User Accounts CPL\usercpl.dll.mun"', '-action addoverwrite'
Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '.\Pages\User Accounts CPL\usercpl.dll.mun' -Destination 'C:\Windows\SystemResources\' -Recurse -Force" -Wait -WindowStyle Hidden
Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Remove-Item -Path 'Pages\User Accounts CPL\usercpl.dll.mun' -Force" -Wait -WindowStyle Hidden

# KOPY "C:\Windows\system32\shacct.dll"  into "CPL Restoration 4.0 H1\Pages\User Accounts CPL"
# Use Resource Hacker to import the included resource file(shacct.res,located in "Pages\User Accounts CPL\7 Style\system32\shacct.dll" 
# into the shacct.dll file located in "CPL Restoration 4.0 H1\Pages\User Accounts CPL"
# KOPY "CPL Restoration 4.0 H1\Pages\User Accounts CPL\shacct.dll" into "C:\Windows\system32" 
Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path 'C:\Windows\system32\shacct.dll' -Destination '.\Pages\User Accounts CPL\' -Recurse -Force" -Wait -WindowStyle Hidden
Start-Process ".\..\resource_hacker\ResourceHacker.exe" -ArgumentList '-open ".\Pages\User Accounts CPL\shacct.dll"', '-resource ".\Pages\User Accounts CPL\7 Style\system32\shacct.dll\shacct.res"', '-save ".\Pages\User Accounts CPL\shacct.dll"', '-action addoverwrite'
Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '.\Pages\User Accounts CPL\shacct.dll' -Destination 'C:\Windows\system32\' -Recurse -Force" -Wait -WindowStyle Hidden
Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Remove-Item -Path 'Pages\User Accounts CPL\shacct.dll' -Force" -Wait -WindowStyle Hidden
