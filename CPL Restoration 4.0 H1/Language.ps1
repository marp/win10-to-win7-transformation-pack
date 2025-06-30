# THIS APPLET IS ONLY FOR DECORATION(on Windows 10 1809 and above)
Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList 'reg import "Pages\Language CPL\import as TrustedInstaller\LANGUAGE.reg"' -WindowStyle Hidden -Wait

Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '.\Pages\Language CPL\8.X Style\System32\*' -Destination 'C:\Windows\System32\' -Recurse -Force" -Wait -WindowStyle Hidden
