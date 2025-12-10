:: Created by: Shawn Brink
:: http://www.tenforums.com
:: Tutorial: http://www.tenforums.com/tutorials/3476-recent-items-frequent-places-reset-clear.html 


del /F /Q %APPDATA%\Microsoft\Windows\Recent\*

del /F /Q %APPDATA%\Microsoft\Windows\Recent\AutomaticDestinations\*

del /F /Q %APPDATA%\Microsoft\Windows\Recent\CustomDestinations\*

taskkill /f /im explorer.exe

start explorer.exe

