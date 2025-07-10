Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList 'reg import "Pages\Security Center and Firewall CPL\Import as TrustedInstaller\vistaFWall.reg"' -WindowStyle Hidden -Wait
Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList 'reg import "Pages\Security Center and Firewall CPL\Import as TrustedInstaller\vistaSeCen.reg"' -WindowStyle Hidden -Wait

Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '.\Pages\Security Center and Firewall CPL\Vista Style\system32\*' -Destination 'C:\Windows\System32' -Recurse -Force" -Wait -WindowStyle Hidden
