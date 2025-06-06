# Windows 10 to Windows 7 Transformation Pack

This transformation pack contains code made by many different people, check credits for details.

This pack is under development. Tested on Windows 10 22H2.

### Requirements
For explorer7 you need Windows 7 ISO or DVD, it should match type and language of your system.

### Installation
1. Install everything from each folder, order is not important.
2. Windhawk
2.1. Copy `Windhawk\ResourceRedirect` to `C:\Windows\ResourceRedirect`
2.2. Open Windhawk, install **Resource Redirect**, go to Resource Redirect settings, set Theme folder to: `C:\Windows\ResourceRedirect\`
3. Install SecureUx and apply the patch
3. Copy Themes\ to C:\Windows\Resources\Themes
4. (Optional) ConsoleLogonHook
4. (Optional) Branding
4. (Optional) HackBGRT for bootscreen
4. (Optional) Install Win7 Games & Apps
5. Done!

#### Note

Please know that HackBGRT is UEFI-only and you must *disable Secure Boot* in your BIOS setup! Otherwise, it will not work.

You can easily access BIOS setup by doing this (would be recommended to print this out or remember it yourself):
Go to the start menu, hold left shift key and restart. Go to advanced settings and look for an UEFI firmware option. Click on it.
Don't be scared of what it shows. If you have a BIOS password, enter it. Go to the boot tab (or something similar) and disable Secure Boot. Save settings and exit.
It should restart the computer. Now you can use HackBGRT! It is *still advised* you use it with caution, as it can brick your Windows installation.

### Credits
Here are credits to a few:  
- Fifty Dinar, a creator of a pack similar to this, his pack contained the Sounds folder which I decided to gather it here.  
- 2013Windows8.1, made the Windows 7 icon pack.
- Winaero, for making Windows 7 games and apps work on Windows 10. (Not 8GadgetPack, that belongs to someone/something else). Also made Winaero Tweaker, too.
- Scritperkid2 on DeviantArt, for exporting Windows 7 cursors.
- NewInfinitePro and fytuf for making the Windows 7 aero theme.
- ReimuHakurei for making DLL file in Windows shell to disable the dark context menu of Taskbar

### Changelog:
- updated Winaero Twekaer to 1.63.0.0
- updated OpenShell to 4.4.191
- added WindHawk, StartIsBack 2.9.20, DWMBlurGlass, Themes
- removed Windows Blinds, Windows 7 IconPack By 2013Windows8.1,
- updated version of OpenShell to 4.4.190
- updated version of 7+ Taskbar Tweaker to 5.14.1
- updated version of OldNewExplorer to 1.1.19
- added [Customizer God](https://www.door2windows.com/customizergod/) 1.7.6.1 for changing taskbar icons
- added taskbar icons to replace (experimental)
- added classic context menu in taskbar [Windows 10 Taskbar Context Menu Tweaker](https://www.askvg.com/tip-get-rid-of-dark-context-menu-in-windows-10-taskbar/)
- added explorer7

### Todo:
- Control panel from Windows 7
