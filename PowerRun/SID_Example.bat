@Echo Off

Call :IsAdmin
CD /D %~dp0\

Set tApp=PowerRun_x64.exe
If /i "%processor_architecture%"=="x86" Set tApp=PowerRun.exe
If "%tApp%"=="" Set tApp=PowerRun.exe

If "%Temp%"=="C:\Windows\TEMP" (TITLE System)

REM ~ %tApp% /SID >%~dp0\SID_Output.txt
Call :GetSID tSID %tApp% /SID

REM ~ Example commands
Call :RegQuery tUserName "HKEY_USERS\%tSID%\Volatile Environment" "USERNAME"
Call :RegQuery tUserProfile "HKEY_USERS\%tSID%\Volatile Environment" "USERPROFILE"
Call :RegQuery tUserDesktop "HKEY_USERS\%tSID%\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" "Desktop"
Cls

Echo Desktop User Information:
Echo User SID: %tSID%
Echo User Name: %tUserName%
Echo User Profile Path: %tUserProfile%
Echo User Dektop Path: %tUserDesktop%
Echo.

REM ~ Pause & Exit
Cmd.exe /k & Exit

:GetSID
For /F "tokens=*" %%A in ('"%~2" %~3') do Set %~1=%%A
if not defined %~1 (Set %~1=???)
goto:eof

:RegQuery
for /F "tokens=3" %%A in ('Reg.exe Query "%~2" /v "%~3"') do Set %~1=%%A
if not defined %~1 (Set %~1=???)
goto:eof

:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ...
 Pause & Exit
)
Cls
goto:eof

