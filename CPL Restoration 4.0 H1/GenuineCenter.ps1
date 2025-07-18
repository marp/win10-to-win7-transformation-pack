# You have to use this together with the 8.X styled System CPL located at "CPL Restoration\Pages\System CPL\8.X Style" to make it appear correctly.

# Ensure script runs in its own directory
Set-Location -Path (Split-Path -Parent $PSCommandPath)

#Import the .reg files located at "CPL Restoration\Pages\Genuine Center CPL\Import as TrustedInstaller" as TrustedInstaller.
Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList 'reg import "Pages\Genuine Center CPL\Import as TrustedInstaller\genuine.reg"' -WindowStyle Hidden -Wait

#Check for the resources that need to be imported before placing the DLL in the correct location. The resources are located in the "CPL Restoration\Pages\Genuine Center CPL\systemresources\ActionCenterCPL.dll.mun" folder.
#Always Choose "overwrite" if prompted!

#Use Resource Hacker to import the included files from
# "CPL Restoration\Pages\Genuine Center CPL\systemresources
#\ActionCenterCPL.dll.mun" into "ActionCenterCPL.dll.mun" 
#file located at "C:\Windows\SystemResources".
#Choose "overwrite" if prompted.
Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path 'C:\Windows\SystemResources\ActionCenterCPL.dll.mun' -Destination 'Pages\Genuine Center CPL\' -Recurse -Force" -Wait -WindowStyle Hidden
Start-Process ".\..\resource_hacker\ResourceHacker" -ArgumentList '-open ".\Pages\Genuine Center CPL\ActionCenterCPL.dll.mun"', '-resource "Pages\Genuine Center CPL\systemresources\ActionCenterCPL.dll.mun\genuinepage.res"', '-save ".\Pages\Genuine Center CPL\ActionCenterCPL.dll.mun"', '-action addoverwrite'
Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path 'Pages\Genuine Center CPL\ActionCenterCPL.dll.mun' -Destination 'C:\Windows\SystemResources\' -Recurse -Force" -Wait -WindowStyle Hidden
Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Remove-Item -Path 'Pages\Genuine Center CPL\ActionCenterCPL.dll.mun' -Force" -Wait -WindowStyle Hidden


# Use Resource Hacker to import the included files from 
# "CPL Restoration\Pages\Genuine Center CPL\system32\en-US
# \ActionCenterCPL.dll.mui" into "ActionCenterCPL.dll.mui"
#  file located at "C:\Windows\System32\en-US". 
# Choose "overwrite" if prompted.
Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path 'C:\Windows\System32\en-US\ActionCenterCPL.dll.mui' -Destination 'Pages\Genuine Center CPL\' -Recurse -Force" -Wait -WindowStyle Hidden
Start-Process ".\..\resource_hacker\ResourceHacker" -ArgumentList '-open ".\Pages\Genuine Center CPL\ActionCenterCPL.dll.mui"', '-resource "Pages\Genuine Center CPL\system32\en-US\ActionCenterCPL.dll.mui\StringTable.res"', '-save ".\Pages\Genuine Center CPL\ActionCenterCPL.dll.mui"', '-action addoverwrite'
Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path 'Pages\Genuine Center CPL\ActionCenterCPL.dll.mui' -Destination 'C:\Windows\System32\en-US\' -Recurse -Force" -Wait -WindowStyle Hidden
Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Remove-Item -Path 'Pages\Genuine Center CPL\ActionCenterCPL.dll.mui' -Force" -Wait -WindowStyle Hidden


# Copy "GenuineCenter.dll" located at
# "CPL Restoration\Pages\Genuine Center CPL\system32"
# and "genuinecenter.dll.mui" located at
# "CPL Restoration\Pages\Genuine Center CPL\system32\en-us"
# to "C:\Windows\System32" and "C:\Windows\System32\en-us" 
# respectively.
Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '.\Pages\Genuine Center CPL\system32\*' -Destination 'C:\Windows\System32\' -Recurse -Force" -Wait -WindowStyle Hidden

