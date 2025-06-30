Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '.\Control Panel Links\Universal\7 Style\system32\*' -Destination 'C:\Windows\System32\' -Recurse -Force" -Wait -WindowStyle Hidden

Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "Control Panel Links\Universal\7 Style\Run as TrustedInstaller\cpl7.bat"