Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '.\Pages\Display CPL\7 Style\system32\*' -Destination 'C:\Windows\System32\' -Recurse -Force" -Wait -WindowStyle Hidden
Start-Process reg.exe -ArgumentList 'import "Pages\Display CPL\import normally\scaling.reg"' -WindowStyle Hidden -Wait
Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList 'reg import "Pages\Display CPL\import as TrustedInstaller\display.reg"' -WindowStyle Hidden -Wait
