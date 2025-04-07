Dim objShell, objFSO
Set objShellApp = CreateObject("Shell.Application")
Set objShell = CreateObject("WScript.Shell")
Set objArgs = WScript.Arguments
Set objFSO = CreateObject("Scripting.FileSystemObject")

If objArgs.Count > 0 Then
    Select Case objArgs(0)
        Case "ms-settings:"
            objShellApp.Open "shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}"
        Case "ms-settings:display"
            objShellApp.Open "shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\1\::{C555438B-3C23-4769-A71F-B6D3D9B6053A}"
        Case "ms-settings:display-advanced"
            objShellApp.Open "shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\1\::{C555438B-3C23-4769-A71F-B6D3D9B6053A}\settings"
        Case "ms-settings:personalization", "ms-settings:easeofaccess-highcontrast"
            objShellApp.Open "shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\1\::{ED834ED6-4B5A-4bfe-8F11-A626DCB6A921}"
        Case "ms-settings:personalization-background"
            objShellApp.Open "shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\1\::{ED834ED6-4B5A-4bfe-8F11-A626DCB6A921}\pagewallpaper"
        Case "ms-settings:personalization-colors", "ms-settings:colors"
            objShellApp.Open "shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\1\::{ED834ED6-4B5A-4bfe-8F11-A626DCB6A921}\pagecolorization"
        Case "ms-settings:themes"
            objShellApp.Open "shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\1\::{ED834ED6-4B5A-4bfe-8F11-A626DCB6A921}"
        Case "ms-settings:fonts"
            objShellApp.Open "shell:::{BD84B380-8CA2-1069-AB1D-08000948F534}"
        Case "ms-settings:sound-devices"
            objShellApp.Open "shell:::{F2DDFC82-8F12-4CDD-B7DC-D4FE1425AA4D}"
		Case "ms-settings:batterysaver", "ms-settings:batterysaver-usagedetails"
            objShellApp.Open "shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\2\::{025A5937-A6BE-4686-A844-36FE4BEC8B6D}"
		Case "ms-settings:batterysaver-settings", "ms-settings:powersleep"
            objShellApp.Open "shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\2\::{025A5937-A6BE-4686-A844-36FE4BEC8B6D}\pageglobalsettings"
        Case "ms-settings:deviceencryption"
            objShellApp.Open "shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\5\::{D9EF8727-CAC2-4e60-809E-86F80A666C91}"
		Case "ms-settings:about"
            objShellApp.Open "shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\5\::{BB06C0E4-D293-4f75-8A90-CB05B6477EEE}"
		Case "ms-settings:connecteddevices", "ms-settings:printers", "ms-settings:mobile-devices"
            objShellApp.Open "shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\2\::{A8A91A66-3A7D-4424-8D24-04E180695C7A}"
		Case "ms-settings:autoplay"
            objShellApp.Open "shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\2\::{9C60DE1E-E5FC-40f4-A487-460851A8D915}"
		Case "ms-settings:appsfeatures", "ms-settings:appsfeatures-app"
            objShellApp.Open "shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\8\::{7b81be6a-ce2b-4676-a29e-eb907a5126c5}"
		Case "ms-settings:defaultapps"
            objShellApp.Open "shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\8\::{17cd9488-1228-4b2f-88ce-4298e93e0966}"
		Case "ms-settings:yourinfo", "ms-settings:emailandaccounts", "ms-settings:signinoptions"
            objShellApp.Open "shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\9\::{60632754-c523-4b62-b45c-4172da012619}"
		Case "ms-settings:otherusers"
            objShellApp.Open "shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\9\::{60632754-c523-4b62-b45c-4172da012619}\pageadmintasks"
		Case "ms-settings:sync"
            objShellApp.Open "shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\0\::{9C73F5E5-7AE7-4E32-A8E8-8D23B85255BF}"
		Case "ms-settings:dateandtime"
            objShellApp.Open "shell:::{E2E7934B-DCE5-43C4-9576-7FE4F75E7480}"
		Case "ms-settings:regionformatting", "ms-settings:regionlanguage", "ms-settings:regionlanguage-languageoptions"
            objShellApp.Open "shell:::{62D8ED13-C9D0-4CE8-A914-47DD628FB1B0}"
		Case "ms-settings:keyboard"
            objShellApp.Open "shell:::{725BE8F7-668E-4C7B-8F90-46BDB0936430}"
		Case "ms-settings:speech"
            objShellApp.Open "shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\7\::{58E3C745-D971-4081-9034-86E34B30836A}"
		Case "ms-settings:easeofaccess-cursorandpointersize", "ms-settings:easeofaccess-mouse"
            objShellApp.Open "shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\7\::{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageEasierToClick"
		Case "ms-settings:easeofaccess-magnifier"
            objShellApp.Open "shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\7\::{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageEasierToSee"
		Case "ms-settings:easeofaccess-narrator", "ms-settings:easeofaccess-audio"
            objShellApp.Open "shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\7\::{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageEasierWithSounds"
		Case "ms-settings:easeofaccess-keyboard"
            objShellApp.Open "shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\7\::{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageKeyboardEasierToUse"
		Case "ms-settings:search-moredetails", "ms-settings:cortana-windowssearch"
            objShellApp.Open "shell:::{9343812e-1c37-4a49-a12e-4b2d810d956b}"
		Case "ms-settings:windowsupdate", "ms-settings:windowsupdate-action"
            objShellApp.Open "shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\5\::{36eef7db-88ad-4e81-ad49-0e313f0c35f8}"
		Case "ms-settings:windowsupdate-history"
            objShellApp.Open "shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\5\::{36eef7db-88ad-4e81-ad49-0e313f0c35f8}\pageupdatehistory"
		Case "ms-settings:windowsupdate-restartoptions", "ms-settings:windowsupdate-options", "ms-settings:windowsupdate-activehours"
            objShellApp.Open "shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\5\::{36eef7db-88ad-4e81-ad49-0e313f0c35f8}\pagesettings"
		Case "ms-settings:windowsupdate-optionalupdates", "ms-settings:windowsinsider"
            objShellApp.Open "shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\5\::{36eef7db-88ad-4e81-ad49-0e313f0c35f8}\pageFeaturedUpdates"
		Case "ms-settings:backup"
            objShellApp.Open "shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\5\::{B98A2BEA-7D42-4558-8BD1-832F41BAC6FD}"
		Case "ms-settings:troubleshoot"
            objShellApp.Open "shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\0\::{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}"
		Case "ms-settings:recovery"
            objShellApp.Open "shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\0\::{9FE63AFD-59CF-4419-9775-ABCC3849F861}"
		Case "ms-settings:notifications"
            objShellApp.Open "shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\0\::{05d7b0f4-2121-4eff-bf6b-ed3f69b894d9}"
		Case "ms-settings:taskbar"
			If objFSO.FileExists("c:\windows\tbconf.exe") Then
				objShell.Run """c:\windows\tbconf.exe""", 1, False  ' Run tbconf.exe if the file exists
			Else
				If objFSO.FileExists(objShell.ExpandEnvironmentStrings("%ProgramFiles(x86)%") & "\startisback\StartIsBackCfg.exe") Then
					objShell.Run """" & objShell.ExpandEnvironmentStrings("%ProgramFiles(x86)%") & "\startisback\StartIsBackCfg.exe" & """", 1, False  ' Run StartIsBackCfg.exe if the file exists
				Else
					WScript.Quit 0
				End If
			End If
		Case "ms-settings:personalization-start", "ms-settings:personalization-start-places"
				If objFSO.FileExists(objShell.ExpandEnvironmentStrings("%ProgramFiles(x86)%") & "\startisback\StartIsBackCfg.exe") Then
					objShell.Run """" & objShell.ExpandEnvironmentStrings("%ProgramFiles(x86)%") & "\startisback\StartIsBackCfg.exe" & """", 1, False  ' Run StartIsBackCfg.exe if the file exists
				Else
					WScript.Quit 0
				End If

		Case "ms-settings:regionlanguage-setdisplaylanguage", "ms-settings:regionlanguage-adddisplaylanguage"
            objShell.Run "lpksetup.exe", 1, False
		Case "ms-settings:optionalfeatures"
            objShell.Run "optionalfeatures.exe", 1, False
		Case "ms-settings:apps-volume"
            objShell.Run "sndvol.exe -t 99490633", 1, False
		Case "ms-settings:remotedesktop"
            objShell.Run "mstsc.exe", 1, False
        Case Else
            WScript.Quit 0
    End Select
Else
    WScript.Quit 0
End If
