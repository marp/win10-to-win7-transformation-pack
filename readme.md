# ![Windows 7 Logo](Windows.png) Windows 10 to Windows 7 Transformation Pack 

This transformation pack is designed using the best available tools and resources to closely replicate the look and feel of Windows 7. Unlike many other packs, it is highly customizable and fully open-source.

**Warning:** This pack is still in active development.
The author is not responsible for any issues or data loss caused by using this pack. Please make sure to create a full backup before installation or use.

## Requirements
- Windows 10 version 22H2 (earlier versions have not been tested, but may work)
- You must configure PowerShell to allow script execution. Run PowerShell as an Administrator and execute the following command:
    ```powershell
    Set-ExecutionPolicy RemoteSigned
    ```
- To use Explorer7 and Windhawk, you’ll need a Windows 7 ISO or DVD that matches the type and language of your current system. Currently, only the en-US version is supported..

## Installation
1. Windhawk
2. Theming
3. Logon screen
4. Control Panel Restoration 4.0 H1
5. Windows 7 Logo Branding
6.  (Optional) HackBGRT for bootscreen
7. (Optional) Install Win7 Games & Apps
8. (Optional) Sounds, Wallpapers and User tiles
9. Done!

#### Windhawk
Just install this wonderful tool, it will be neccessary in next steps. Use `Windhawk\installWindhawk.ps1` for silent install.

#### Theming
First you need to enable unofficial themes support. To do so install SecureUx. 
Then copy aero theme by running `Themes\copy.ps1`.
To enable transparent title bars copy DWMBlurGlass by running `DWMBlurGlass\copy.ps1` and manually apply the patch.
To change icons look, install `Resource Redirect` mod for Windhawk. Copy resources with `Windhawk\copyResources.ps1` and set theme path to `C:\Windows\ResourceRedirect\theme.ini`
For taskbar install Explorer7


#### Logon screen
Install `AuthUX v0.0.1-beta\AuthUX-setup-x64.exe`

##### Control Panel Restoration 4.0 H1 Automatic Setup
I've created a PowerShell script that makes the installation of the control panel much easier. It's still not complete, so please go through each step carefully and read every README file.

You can select which control panel pages you want to apply: 
- Backup and Restore - `BackupAndRestore.ps1`
- Biometric Devices - `BiometricDevices.ps1`
- Display - `Display.ps1`
- Game Controllers - `GameControllers.ps1`
- Genuine Center - **IN PROGRESS**
- HomeGroups - `HomeGroups.ps1`
- Language - **TODO - DUMMY** `Language.ps1`
- Mobility Center - **TODO**
- Network and Sharing Center - **TODO**
- Network Map  - **TODO**
- Notification Tray Icons  - `NotificationTrayIcons.ps1`
- Parental Controls-Family Safety - `ParentalControls-FamilySafety.ps1`
- Performance Information and Tools - `PerformanceInformationAndTools.ps1`
- Personalization - **CAN'T BE DONE** IMPORTANT README
- ~~Printers - redundant Vista style page `Printers.ps1`~~
- Recovery - `Recovery.ps1`
- Region and Input - **TODO - DUMMY** `RegionAndInput.ps1`
- Security Center and Firewall CPL>) 
- System - **IN PROGRESS**
- User Accounts CPL - **CAN'T BE DONE** 
- Windows Cardspace - **TODO**
- Windows Update - only for decoration `WindowsUpdate.ps1`

#### Windows 7 Logo Branding
Run `Branding\copy.ps1`


#### HackBGRT

Please know that HackBGRT is UEFI-only and you must *disable Secure Boot* in your BIOS setup! Otherwise, it will not work.

You can easily access BIOS setup by doing this (would be recommended to print this out or remember it yourself):
Go to the start menu, hold left shift key and restart. Go to advanced settings and look for an UEFI firmware option. Click on it.
Don't be scared of what it shows. If you have a BIOS password, enter it. Go to the boot tab (or something similar) and disable Secure Boot. Save settings and exit.
It should restart the computer. Now you can use HackBGRT! It is *still advised* you use it with caution, as it can brick your Windows installation.

## 🎯 Roadmap & Work in Progress
### ⏳ Planned Features
- Automated Setup Script - A unified PowerShell-based installer that can guide users step-by-step through the installation and configuration process.
- Localized Language Support - Currently only en-US is supported. Support for additional languages (e.g. pl-PL, de-DE, etc.) is planned.
- Improved Personalization Options - More pre-configured themes and color schemes resembling Windows 7 Aero styles.

### 🔧 Currently in Development
- **Control Panel Restoration 4.0 H1 Automatic Setup** - Work is in progress on a unified PowerShell script to simplify the installation of legacy Control Panel pages. The goal is to allow users to select desired modules and apply them with minimal manual steps. Some .ps1 scripts are functional, while others are still in development, marked as TODO, DUMMY, or IN PROGRESS in the respective file headers. Please read all accompanying README files carefully before use.

## 🙏 Credits & External Resources
This project wouldn't be possible without the incredible work of the open-source and customization community. Special thanks to the following creators and tools:
- [Windhawk](https://github.com/ramensoftware/windhawk)
- [Explorer7](https://github.com/world-windows-federation/explorer7)
- [AuthUX](https://github.com/world-windows-federation/AuthUX)
- [(v4.0 H1) Restoring Control Panel Pages/Links(1507-10 22H2)](https://winclassic.net/thread/1779/restoring-control-panel-pages-links)
- [SecureUxTheme](https://github.com/namazso/SecureUxTheme)
- [HackBGRT](https://github.com/Metabolix/HackBGRT)
- [Resource Hacker](https://www.angusj.com/resourcehacker/)
- [PowerRun](https://www.sordum.org/9416/powerrun-v1-7-run-with-highest-privileges/)
- Fifty Dinar, a creator of a pack similar to this, his pack contained the Sounds folder which I decided to gather it here.  
- Winaero, for making Windows 7 games and apps work on Windows 10. (Not 8GadgetPack, that belongs to someone/something else). Also made Winaero Tweaker, too.
- Scritperkid2 on DeviantArt, for exporting Windows 7 cursors.
- NewInfinitePro and fytuf for making the Windows 7 aero theme.