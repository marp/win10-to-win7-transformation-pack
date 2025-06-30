Start-Process ".\..\PowerRun\PowerRun_x64.exe" -ArgumentList "powershell -ExecutionPolicy Bypass -Command Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\don''t load' -Name 'joy.cpl' -Force" -WindowStyle Hidden -Wait
reg import ".\Pages\Game Controllers CPL\Vista Style\Import Normally\joy.reg"
