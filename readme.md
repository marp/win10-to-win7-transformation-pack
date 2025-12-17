# ![Windows 7 Logo](Windows.png) Windows 10 to Windows 7 Transformation Pack 

This transformation pack is designed using the best available tools and resources to closely replicate the look and feel of Windows 7. Unlike many other packs, it is highly customizable and fully open-source.

## ⚠️ Development Status

**This project is currently under active development and is not yet complete.** Please be aware of the following:

- **Experimental Nature:** Many features are still being developed, tested, and refined. The project may contain incomplete implementations, bugs, or unexpected behavior.
- **Potential Issues:** You may encounter errors, system instability, or compatibility problems. Some features may not work as intended or may require manual troubleshooting.
- **Breaking Changes:** Updates and improvements are ongoing, which means future releases may introduce breaking changes or require reinstallation.
- **Use at Your Own Risk:** While we strive to make this pack as stable and reliable as possible, the author and contributors are not responsible for any issues, system damage, or data loss that may occur from using this transformation pack.

**Recommendation:** Before proceeding with installation, it is strongly recommended to:
- Create a full system backup
- Create a system restore point
- Test the pack in a non-production environment first
- Read all documentation and README files carefully

We appreciate your understanding and welcome feedback, bug reports, and contributions to help improve this project!

## Requirements
- Windows 10 version 22H2 (earlier versions have not been tested, but may work)
- You must configure PowerShell to allow script execution. Run PowerShell as an Administrator and execute the following command:
    ```powershell
    Set-ExecutionPolicy RemoteSigned
    ```
- To use Explorer7 and Windhawk, you’ll need a Windows 7 ISO or DVD that matches the type and language of your current system. Currently, only the en-US version is supported..

## Installation
### Table of contents
- [Windhawk](#windhawk)
- [Theming](#theming)
- [Start menu and taskbar](#start-menu-and-taskbar)
- [Sounds](#sounds)
- [Logon screen](#logon-screen)
- [Control Panel Restoration 4.0 H1 Automatic Setup](#control-panel-restoration-40-h1-automatic-setup)
- [Windows 7 Logo Branding](#windows-7-logo-branding)
- [HackBGRT (optional)](#hackbgrt)

#### Windhawk
Just install this wonderful tool, it will be neccessary in next steps. Use `Windhawk\installWindhawk.ps1` for silent install.

#### Theming
1. Enable unofficial theme support
    - Install SecureUxTheme (reboot if prompted).

2. Install the Windows 7 Aero theme
    - Run PowerShell as Administrator in the repo root:
      ```powershell
      .\Themes\copy.ps1
      ```
    - Apply the theme in Settings > Personalization > Themes.

3. Enable transparent title bars (DWM Blur Glass)
    - Copy files:
      ```powershell
      .\DWMBlurGlass\copy.ps1
      ```
    - Manually apply the patch as instructed in the included README.

4. Apply Windows 7 icons and other resources via Windhawk
    - In Windhawk, install the “Resource Redirect” mod.
    - Copy resources:
      ```powershell
      .\Windhawk\copyResources.ps1
      ```
    - In the mod settings, set Theme path to:
      ```
      C:\Windows\ResourceRedirect\theme.ini
      ```


#### Start menu and taskbar
1. Choose one solution:
    - Explorer7 — Open-source, experimental, may be unstable.
    - StartIsBack++ — Proprietary, paid, stable for daily use.
2. Install your choice (installers are in StartMenuAndTaskBar):
    - Explorer7:
      - You will need Windows 7 ISO
      - Open StartMenuAndTaskBar\Explorer7 directory.
      - Unzip the archive and install
    - StartIsBack++:
      - Open StartMenuAndTaskBar\StartIsBackPlusPlus directory.
      - Run the installer, activate a license.
3. Configure the chosen app for a Windows 7-style Start menu and taskbar

#### Sounds
1. Open PowerShell as Administrator in the repo root.
2. Apply the Windows 7 sound scheme:
    ```powershell
    .\Sounds\copyAndApplyWindows7Sounds.ps1
    ```
3. Verify in Control Panel > Sound that the Windows 7 scheme is active.

#### Logon screen
Install `AuthUX v0.0.1-beta\AuthUX-setup-x64.exe`

##### Control Panel Restoration 4.0 H1 Automatic Setup
I've created a PowerShell script that makes the installation of the control panel much easier. It's still not complete, so please go through each step carefully and read every README file.

You can select which control panel pages you want to apply: 
- Backup and Restore - `BackupAndRestore.ps1`
- Biometric Devices - `BiometricDevices.ps1`
- Display - `Display.ps1`
- Game Controllers - `GameControllers.ps1`
- Genuine Center - `GenuineCenter.ps1`
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
- Security Center and Firewall CPL - Vista style page `SecurityCenterAndFirewall.ps1`
- System - `System.ps1`
- User Accounts CPL - `UserAccounts.ps1`
- Windows Cardspace - **IN PROGRESS**  `WindowsCardspace.ps1`
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