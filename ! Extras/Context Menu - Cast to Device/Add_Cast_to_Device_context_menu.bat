@echo off

:: Created by: Shawn Brink
:: Created on: August 24th 2016
:: Tutorial: http://www.tenforums.com/tutorials/61525-cast-device-context-menu-add-remove-windows-10-a.html


REG Delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /V {7AD84985-87B4-4a16-BE58-8B72A5B390F7} /F

taskkill /f /im explorer.exe
start explorer.exe