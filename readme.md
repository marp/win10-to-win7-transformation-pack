# ![Windows 7 Logo](Windows.png) Windows 10 to Windows 7 Transformation Pack 

This transformation pack is designed using the best available tools and resources to closely replicate the look and feel of Windows 7. It is 
**highly customizable** and **built on open-source foundations**. However, please note that some included components (such as StartIsBack++) may be proprietary software with their own licensing terms. Review the license of each component before use.

## ⚠️ Warning

This pack is still in active development and is not yet complete. You may encounter bugs, compatibility issues, or unexpected behavior during installation or use. The author is not responsible for any issues, data loss, or system instability caused by using this pack.

Before proceeding, please create a full system backup. Use at your own risk.

## ⚙️ Requirements
- Windows 10 version 22H2 (earlier versions have not been tested, but may work)
- PowerShell execution policy must be configured. Run PowerShell as Administrator and execute: 
    ```powershell
    Set-ExecutionPolicy RemoteSigned
    ```
- If you plan to use Explorer7, ensure that you have a Windows 7 ISO or DVD matching the architecture (x86 or x64) and language of your current system. At this time, only the en-US version is supported.

## 📦 Installation

### Table of contents
- [Windhawk](#windhawk)
- [Theming](#theming)
- [Start menu and taskbar](#start-menu-and-taskbar)
- [Sounds](#sounds)
- [Logon screen](#logon-screen)
- [Control Panel Restoration 4.0 H1 Automatic Setup](#control-panel-restoration-40-h1-automatic-setup)
- [Windows 7 Logo Branding](#windows-7-logo-branding)
- [Non-XAML UAC](#non-xaml-uac)
- [HackBGRT](#hackbgrt)

### Windhawk
1. Use `Windhawk\installWindhawk.ps1` for silent install.
2. Run `Windhawk\copyResources.ps1` 
3. After installing Windhawk, open it from the system tray.
4. Then install mods listed in `Windhawk\mods.txt`

### Theming
1. Enable unofficial theme support
    - Install SecureUxTheme (reboot if prompted).

2. Install the Windows 7 Aero theme
    - Run PowerShell as Administrator in the repo root:
      ```powershell
      .\Themes\copy.ps1
      ```
    - Apply the theme in Settings > Personalization > Themes.

3. Enable transparent title bars (DWM Blur Glass)
    - Copy directory `ExplorerTransparency\DWMBlurGlass` to `C:\Windows`
    - Run DWMBlurGlass from there, download symbol files and manually apply the patch

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

### Start menu and taskbar
1. Choose one solution:
  - **Explorer7** (recommended) — Proprietary and experimental, but offers a closer Windows 7 experience because it’s more “native.” May be unstable and can **break UWP apps**.
  - **StartIsBack++** — Proprietary and paid, but stable for daily use. You’ll need additional Windhawk mods to better replicate the Windows 7 Win32 look and feel, but it **won’t break UWP apps**.
2. Install your choice (installers are in StartMenuAndTaskBar):
    - Explorer7:
      - You will need extracted Windows 7 ISO
      - Open `StartMenuAndTaskBar\Explorer7` directory.
      - Unzip the archive and install
    - StartIsBack++:
      - Open `StartMenuAndTaskBar\StartIsBackPlusPlus` directory.
      - Run the installer.
      - You will need to install a lot more Windhawk mods
3. Configure the chosen app for a Windows 7-style Start menu and taskbar

### Sounds
1. Open PowerShell as Administrator in the repo root.
2. Apply the Windows 7 sound scheme:
    ```powershell
    .\Sounds\copyAndApplyWindows7Sounds.ps1
    ```
3. Verify in Control Panel > Sound that the Windows 7 scheme is active.

### Cursors
Click with left mouse and choose install on `Cursors\Install.inf` file.

### Logon screen
Install `AuthUX v0.0.1-beta\AuthUX-setup-x64.exe`

#### Control Panel Restoration 4.0 H1 Automatic Setup
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

### Windows 7 Logo Branding
Run `Branding\copy.ps1`

### Non-XAML UAC
Run `classicuac-1.0.3\NTMU.exe`, select pack.ini from the same directory and apply.

### HackBGRT

Please know that HackBGRT is UEFI-only and you must **disable Secure Boot** in your BIOS setup! Otherwise, it will not work.

You can easily access BIOS setup by doing this (would be recommended to print this out or remember it yourself):
Go to the start menu, hold left shift key and restart. Go to advanced settings and look for an UEFI firmware option. Click on it.
Don't be scared of what it shows. If you have a BIOS password, enter it. Go to the boot tab (or something similar) and disable Secure Boot. Save settings and exit.
It should restart the computer. Now you can use HackBGRT! It is *still advised* you use it with caution, as it can brick your Windows installation.

Run `HackBGRT 2.5.2 (Use with caution!)\setup.exe`


## 🎯 Roadmap & Work in Progress
### 🔧 Currently in Development
- Automation and testing improvements

### 📝 Todo
- **Control Panel Restoration 4.0 H1 Automatic Setup** - Work is in progress on a unified PowerShell script to simplify the installation of legacy Control Panel pages. The goal is to allow users to select desired modules and apply them with minimal manual steps. Some .ps1 scripts are functional, while others are still in development, marked as TODO, DUMMY, or IN PROGRESS in the respective file headers. Please read all accompanying README files carefully before use.

### ⏳ Planned Features
- Automated Setup Script - A unified PowerShell-based installer that can guide users step-by-step through the installation and configuration process.
- Localized Language Support - Currently only en-US is supported. Support for additional languages (e.g. pl-PL, de-DE, etc.) is planned.
- Improved Personalization Options - More pre-configured themes and color schemes resembling Windows 7 Aero styles.

## 🙏 Credits & External Resources
This project wouldn't be possible without the incredible work of the open-source and customization community. Special thanks to the following creators and tools:
- [Windhawk](https://github.com/ramensoftware/windhawk)
- [Explorer7](https://github.com/world-windows-federation/explorer7)
- [AuthUX](https://github.com/world-windows-federation/AuthUX)
- [(v4.0 H1) Restoring Control Panel Pages/Links(1507-10 22H2)](https://winclassic.net/thread/1779/restoring-control-panel-pages-links)
- [SecureUxTheme](https://github.com/namazso/SecureUxTheme)
- [HackBGRT](https://github.com/Metabolix/HackBGRT)
- [Resource Hacker](https://www.angusj.com/resourcehacker/)
- [PowerRun](https://www.sordum.org/9416/powerrun-v1-8-run-with-highest-privileges/)
- Fifty Dinar, a creator of a pack similar to this, his pack contained the Sounds folder which I decided to gather it here.  
- [Winaero](https://winaero.com/), for making Windows 7 games and apps work on Windows 10. (Not 8GadgetPack, that belongs to someone/something else). Also made Winaero Tweaker, too.
- [Scritperkid2](https://www.deviantart.com/scritperkid2), for exporting Windows 7 cursors.
- [vaporvance](https://www.deviantart.com/vaporvance), for Aero10 theme
- [NT Modding Utility](https://get-ntmu.github.io/#!/)
- [Cursors](https://www.rw-designer.com/cursor-set/windows-7-aero-1)