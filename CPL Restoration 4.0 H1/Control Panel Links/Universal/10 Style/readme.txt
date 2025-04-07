Check the resources that need to be imported before placing the DLL files in the correct location. 

The resources are located in the "CPL Restoration\Control Panel Links\10 Style\systemresources\shell32.dll.mun" folder.

Use Resource Hacker to import the included resource(.res) files into the shell32.dll.mun file located in the "C:\Windows\SystemResources" folder. 

Choose "overwrite" if prompted.

Afterwards, copy the files in "CPL Restoration\Control Panel Links\10 Style\system32" folder to "C:\Windows\System32" and restart explorer.

If you want to hide every applet that was not in Windows 10(1507) from category view, run the batch script(cpl10.bat),

located at "CPL Restoration\Control Panel Links\10 Style\Run as TrustedInstaller" as TrustedInstaller.