                 _                   ______
                | |                 |___  /
  _____  ___ __ | | ___  _ __ ___ _ __ / / 
 / _ \ \/ / '_ \| |/ _ \| '__/ _ \ '__/ /  
|  __/>  <| |_) | | (_) | | |  __/ |./ /   
 \___/_/\_\ .__/|_|\___/|_|  \___|_|\_/    
          | |                              
          |_|
==== explorer7 - Ex7forW8, modernized ====

     VERSION: Milestone 2, 15/03/25

==========================================

              N O T I C E S

- This is PRE-RELEASE SOFTWARE. This means, expect bugs, crashes and whatnot.	
  WE REPEAT: THIS IS UNFINISHED SOFTWARE. USE AT YOUR OWN RISK!

- This release is primarily focused on Windows 10 support. 8.1 will still 
  work as it did before, albeit without some newer features such as immersive 
  shell support due to some rather drastic changes in how this works between
  the two operating systems. Usage should be avoided on Windows 11 24H2 and
  later for the time being, unless you are prepared to experience a greater
  number of issues.

- NO distribution of this software is allowed in transformation packs or ISOs.
  No permissions will be conceded to anyone. If you have any questions as to
  why this is the case, please speak to staff members in the Discord server.

- For more information on the state of this project, consult the Discord
  server or the WinClassic thread.

==========================================
 
 I N S T A L L    I N S T R U C T I O N S

NOTE: You MUST have a Windows 7 ISO mounted (or Windows 7 installation on another drive) for the explorer files.

1. First, import the "Import Me.reg" file. This will make sure you have
   all the customization options for the right-side start menu pane. It
   does not interfere with any existing user settings for Windows or other
   shell customization software.

2. Then, run "ex7forw8.exe" to run the patcher. Hit "Specify folder"
   and point to the "sources" folder on your installation DVD, or
   the "Windows" folder on your Windows 7 installation/mount point.

3. Once it's done patching, you can select to "Use Windows 7 explorer" to
   switch to the Windows 7 shell. However, if you wish to not swap your shell,
   you can hit "Cancel", and execute explorer7 manually by killing Windows
   Explorer on task manager, then manually running from the install location
   (X:\wherever\you\extracted\explorer.exe).

4. You're all set!

==========================================
		
                 M I S C

- explorer7 is capable of loading inactive .msstyles files contained within the
  "theme" folder in the installation location. This is required for Windows 10
  users to have proper classes for the start menu. However, if you are on version
  1507 or under (Windows 8.1), you may opt to use a Windows 8.0 msstyles as your
  system theme. If so, you may remove the "aero.msstyles" file from the "theme" 
  folder, or rename the folder to something else.

- Windows 7-era .msstyle files are supported in this inactive theme loader
  system, in case you want to apply custom designs to the taskbar and start
  menu.

- If you are using explorer7 with supplementary software such as OpenGlass, or
  DWMBlurGlass, you should set the "ColorizationOptions" registry value to 0.
  This will ensure you have better results visually - it is only however
  necessary due to a quirk where these tools do not apply glass effects to the
  translucent system accent type. We hope to be able to remove this
  recommendation in the future. 


==========================================

              C R E D I T S

- wiktorwiktor12: Original Research, Lead Developer
- AM_Erizur: Original Research, Developer, Beta Tester
- Ittr: Original Research, Developer, Beta Tester
- kfh83: Original Research, Beta Tester, Designer
- aubymori: Developer, Beta Tester
- rounak: Developer, Beta Tester
- kawapure: Developer
- mishaproductions: Developer
- amrsatrio: Contributor
- tihiy_mozg: Original ex7forw8 developer
- vaporvance, Microsoft: Built-in visual style

==========================================