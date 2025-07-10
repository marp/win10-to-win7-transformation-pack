Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList 'reg import "Pages\Windows Cardspace CPL\Import as TrustedInstaller\cardspacePlusSVC.reg"' -WindowStyle Hidden -Wait

Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '.\Pages\Windows Cardspace CPL\7 Style\system32\*' -Destination 'C:\Windows\System32' -Recurse -Force" -Wait -WindowStyle Hidden
Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Copy-Item -Path '.\Pages\Windows Cardspace CPL\7 Style\Microsoft.NET\*' -Destination 'C:\Windows\Microsoft.NET' -Recurse -Force" -Wait -WindowStyle Hidden
# Set-Service '' -StartupType Automatic