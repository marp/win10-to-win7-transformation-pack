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
    Set-ExecutionPolicy Unrestricted
    ```
- If you plan to use Explorer7, ensure that you have a Windows 7 ISO or DVD matching the architecture (x86 or x64) and language of your current system. At this time, only the en-US version is supported.

## 📦 Installation

> **Note:** A new unified installer (`install.ps1`) is available. See below.

### Quick start (recommended)

**Step-by-step:**

1. **Extract** the pack to a folder like `C:\Win7-Pack` (short path avoids length issues)

2. **Open PowerShell as Administrator** — right-click Start → Windows PowerShell (Admin) or Terminal (Admin)

3. **Navigate to the pack folder**:
   ```powershell
   cd C:\Win7-Pack
   ```

4. **Set execution policy** (one-time):
   ```powershell
   Set-ExecutionPolicy Unrestricted -Scope Process
   ```

5. **Run the interactive installer** — a numbered menu shows all components:
   ```powershell
   .\install.ps1
   ```
   ```
   ========================================
     Windows 10 → Windows 7 Transformation
     Pack Installer
   ========================================

   Select components to install (by number).
   Separate multiple numbers with commas (e.g. 1,3,5).
   Enter 'A' for all, 'Q' to quit.

     1. SecureUxTheme     Enable custom theme support (foundation)
     2. Theme             Windows 7 Aero themes (30 variants, 6 accent colors)
     3. DWMBlurGlass      Transparent title bars (Aero Glass)
     4. AuthUX            Windows 7 logon screen
     5. Windhawk          Windhawk mod platform
     6. Resources         Resource Redirect files + mod list
     7. Sounds            Windows 7 sound scheme
     8. Branding          Windows 7 logo branding
     9. Cursors           Windows 7 cursor scheme
     10. UAC              Classic (non-XAML) UAC dialog
     11. CPL              Control Panel pages restoration
     12. UserTiles        Windows 7 user account pictures
     13. OpenWithEx       Extended Open With dialog
     14. Winaero          Winaero Tweaker (legacy settings)
     15. Games            Windows 7 games (extract + install)
     16. StartMenu        Explorer7 or StartIsBack++
     17. HackBGRT         Windows 7 boot screen (UEFI, risky)
     18. HomeGroup        Restore HomeGroup
     19. DefaultPrograms  Fix Default Programs CPL dead links
   ```
   Enter `A` to install everything, or a comma-separated list like `1,2,4,7,8,9`.

**One-line silent install (everything):**
```powershell
.\install.ps1 -All
```

**Install specific components silently:**
```powershell
.\install.ps1 -Components "SecureUxTheme,Theme,Sounds,Branding" -Silent
```

**Install core + CPL pages without prompts:**
```powershell
.\install.ps1 -Components "SecureUxTheme,Theme,DWMBlurGlass,Windhawk,Resources,Sounds,Branding,Cursors,UserTiles,OpenWithEx,CPL" -Silent
```

**What happens during install:**
- A system restore point is created (unless `-NoRestorePoint`)
- Each component is installed in order
- Setup logs to `install.log` in the pack folder
- Components requiring manual post-steps are highlighted in yellow
- After completion, review the log for any warnings

### Manual installation
Proceed step-by-step if you prefer full control.

### Table of contents
- [Quick start (recommended)](#quick-start-recommended)
- [Unified installer](#unified-installer)
- [Windhawk](#windhawk)
- [Theming](#theming)
- [Start menu and taskbar](#start-menu-and-taskbar)
- [Sounds](#sounds)
- [Logon screen](#logon-screen)
- [Control Panel Restoration 4.0 H1 Automatic Setup](#control-panel-restoration-40-h1-automatic-setup)
- [Default Programs CPL Fix](#default-programs-cpl-fix)
- [HomeGroup Restoration](#homegroup-restoration)
- [Windows 7 Logo Branding](#windows-7-logo-branding)
- [Non-XAML UAC](#non-xaml-uac)
- [HackBGRT](#hackbgrt)
- [Troubleshooting](#troubleshooting)

### Unified installer
The `install.ps1` script at the repo root automates the entire transformation process.

**Features:**
- Creates a system restore point before changes (skip with `-NoRestorePoint`)
- Component selection via interactive menu or `-Components` parameter
- Silent mode (`-All` or `-Components "A,B"` with `-Silent`)
- Full logging to `install.log` + transcript to `install_transcript.log`
- Skips missing components gracefully (no crash on missing files)
- Validates prerequisites (execution policy, OS version, PowerRun presence)
- Auto-resolves component dependencies (e.g. Theme → SecureUxTheme)
- `-WhatIf` dry-run mode — preview what would be installed without changes
- `-Language` parameter for MUI locale selection (default: system locale)

**All parameters:**

| Parameter | Type | Description |
|---|---|---|
| `-All` | Switch | Install every component without prompting |
| `-Components "A,B"` | String | Comma-separated component names (case-sensitive) |
| `-Silent` | Switch | Suppress all prompts (requires `-All` or `-Components`) |
| `-NoRestorePoint` | Switch | Skip system restore point creation |
| `-LogPath "C:\path\to.log"` | String | Custom log file path |
| `-Language "pl-PL"` | String | Locale for MUI files (default: system locale) |
| `-WhatIf` | Switch | Dry-run — show what would be installed without making changes |

**Valid component names:** `SecureUxTheme`, `Theme`, `DWMBlurGlass`, `AuthUX`, `Windhawk`, `Resources`, `Sounds`, `Branding`, `Cursors`, `UAC`, `CPL`, `UserTiles`, `OpenWithEx`, `Winaero`, `Games`, `StartMenu`, `HackBGRT`, `HomeGroup`, `DefaultPrograms`

**Example workflows:**

| Command | What it does |
|---|---|
| `.\install.ps1` | Show interactive menu, ask which components to install |
| `.\install.ps1 -All` | Install everything, prompts before starting |
| `.\install.ps1 -All -Silent` | Install everything, no prompts at all |
| `.\install.ps1 -WhatIf -All` | Preview everything that would install (dry-run) |
| `.\install.ps1 -Components "Theme,Sounds,Branding"` | Install only 3 components, prompts before starting |
| `.\install.ps1 -Components "Theme,Sounds,Branding" -Silent` | Install 3 components silently |
| `.\install.ps1 -All -NoRestorePoint` | Install everything, skip restore point |
| `.\install.ps1 -Components "Windhawk" -Silent` | Single component, fully silent |
| `.\install.ps1 -Language "pl-PL" -All` | Install everything with Polish MUI files if available |
| `.\install.ps1 -Components "SecureUxTheme,Theme,HomeGroup,DefaultPrograms"` | Foundation + HomeGroup + CPL fix, prompts before start |

**Typical output (interactive mode):**

After launching `.\install.ps1` and choosing `1,2,4,7,8,9`, you will see:

```
=== Windows 10 to Windows 7 Transformation Pack Installer ===
Starting installation with components: SecureUxTheme, Theme, AuthUX, Sounds, Branding, Cursors
Log: C:\Win7-Pack\install.log
System restore point created

--- Installing SecureUxTheme ---
SecureUxTheme installed (reboot may be required)

--- Installing Windows 7 Aero Theme ---
Theme files copied. Apply via Settings > Personalization > Themes

--- Installing AuthUX (logon screen) ---
AuthUX installed

--- Applying Windows 7 Sounds ---
Windows 7 sound scheme applied

--- Applying Windows 7 Branding ---
Windows 7 branding applied

--- Installing Windows 7 Cursors ---
  MANUAL STEP: Right-click Cursors\Install.inf and select 'Install'

========================================
Installation complete.
Components installed: 6
Components with errors: 0
Log saved to: C:\Win7-Pack\install.log
========================================

IMPORTANT: Some components require manual steps (see log).
A reboot may be needed for some changes to take effect.
```

### Windhawk
Install the mod platform, resource redirect files, and required mods:

```powershell
# Step 1: Install Windhawk silently
.\Windhawk\installWindhawk.ps1

# Step 2: Copy resource replacement files to C:\Windows\ResourceRedirect\
.\Windhawk\copyResources.ps1
```
- Then open Windhawk from the system tray
- Install the **Resource Redirect** mod
- In its settings, set the theme path to `C:\Windows\ResourceRedirect\theme.ini`
- Install additional mods listed in `Windhawk\mods.txt`

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
Install `AuthUX v0.0.2a-beta\AuthUX-setup-x64.exe`

#### Control Panel Restoration 4.0 H1 Automatic Setup
I've created a PowerShell script that makes the installation of the control panel much easier. It's still not complete, so please go through each step carefully and read every README file.

**Preparation (apply once):**
1. Run `.\CPL Restoration 4.0 H1\_ControlPanelLinks.ps1` — copies control panel link files (choose style in `Control Panel Links\`)
2. Run `.\CPL Restoration 4.0 H1\_ControlPanelRedirection.ps1` — applies registry redirect (choose AHK or VBS redirector, then install the Windhawk `CPL Reborn` mod)

Then select which control panel pages to restore (grouped by status):

**✅ Functional**
| Page | Script | Notes |
|---|---|---|
| Backup and Restore | `BackupAndRestore.ps1` | |
| Biometric Devices | `BiometricDevices.ps1` | |
| Default Programs | `DefaultPrograms.ps1` | Sub-page dead links fixed |
| Display | `Display.ps1` | |
| Game Controllers | `GameControllers.ps1` | |
| Genuine Center | `GenuineCenter.ps1` | |
| HomeGroups | `HomeGroups.ps1` | |
| Language | `Language.ps1` | Decoration on 1809+; use Windhawk for IME |
| Mobility Center | `MobilityCenter.ps1` | |
| Network and Sharing Center | `NetworkAndSharingCenter.ps1` | Auto-patches netcenter.dll via ResourceHacker; PNIDUI.dll for flyout (external) |
| Network Map | `NetworkMap.ps1` | LLTDIO enabled automatically via registry |
| Notification Tray Icons | `NotificationTrayIcons.ps1` | |
| Parental Controls/Family Safety | `ParentalControls-FamilySafety.ps1` | |
| Performance Information and Tools | `PerformanceInformationAndTools.ps1` | |
| Printers | `Printers.ps1` | Built-in Vista style already functional |
| Recovery | `Recovery.ps1` | |
| Region and Input | `RegionAndInput.ps1` | |
| Security Center and Firewall CPL | `SecurityCenterAndFirewall.ps1` | Vista style page |
| System | `System.ps1` | |
| User Accounts CPL | `UserAccounts.ps1` | |
| Windows Cardspace | `WindowsCardspace.ps1` | Requires .NET 3.5 enabled |
| Windows Update | `WindowsUpdate.ps1` | Decoration — tile appears in Control Panel |

**🚫 Won't do**
| Page | Reason |
|---|---|
| Personalization | Can't be done in Windows 10 |

### Default Programs CPL Fix
The `DefaultPrograms.ps1` script fixes dead sub-page links on the Default Programs page (Issue #5). 
Links like "Set your default programs" and "Associate a file type or protocol with a program" 
will function correctly after applying this registry fix.
```powershell
.\CPL Restoration 4.0 H1\DefaultPrograms.ps1
```

### HomeGroup Restoration
Restores HomeGroup functionality removed since Windows 10 1803. Includes `stobject.dll` 
version 10.0.14393.7426 from Windows 10 Anniversary Update.

```powershell
.\CPL Restoration 4.0 H1\Extras\HomeGroup\InstallHomeGroup.ps1
```

The script replaces stobject.dll, imports registry keys, configures svchost services, and starts 
HomeGroupListener / HomeGroupProvider services. A reboot is recommended after installation.

### Windows 7 Logo Branding
Run `Branding\copy.ps1`

### Non-XAML UAC
Run `classicuac-1.0.3\NTMU.exe`, select pack.ini from the same directory and apply.

### Theme Color Variants
The pack includes **30 theme variants** across 3 base styles (Seven, Vista, Metro), each with 6 accent colors:

| Style | Colors |
|---|---|
| Aero10 Seven | Default Blue, Ruby Red, Emerald Green, Amethyst Purple, Teal, Orange, Hot Pink |
| Aero10 Vista | Default Blue, Ruby Red, Emerald Green, Amethyst Purple, Teal, Orange, Hot Pink |
| Aero10 Metro | Default Blue, Ruby Red, Emerald Green, Amethyst Purple, Teal, Orange, Hot Pink |

After running `install.ps1 -Components Theme`, all variants are available under **Settings > Personalization > Themes**.

### Localization
The pack defaults to system locale (fallback: en-US). To use a specific language:

```powershell
.\install.ps1 -Language "pl-PL"
```

To add a new language:
1. Run `.\Localization\New-Locale.ps1 -Locale "de-DE"` to create directory structure
2. Translate the en-US MUI files in each CPL page directory
3. Place translated files in the corresponding locale directories
4. Install with `.\install.ps1 -Language "de-DE"`

See `Localization\README.txt` for detailed instructions.

### Environment Test
Before installing, run the diagnostic script to check your system:

```powershell
.\Test-InstallEnvironment.ps1
```

This checks: OS version, architecture, PowerShell version, execution policy, admin rights, disk space, PowerRun, Resource Hacker, ViveTool, and the integrity of all component files and CPL scripts.

### HackBGRT

Please know that HackBGRT is UEFI-only and you must **disable Secure Boot** in your BIOS setup! Otherwise, it will not work.

You can easily access BIOS setup by doing this (would be recommended to print this out or remember it yourself):
Go to the start menu, hold left shift key and restart. Go to advanced settings and look for an UEFI firmware option. Click on it.
Don't be scared of what it shows. If you have a BIOS password, enter it. Go to the boot tab (or something similar) and disable Secure Boot. Save settings and exit.
It should restart the computer. Now you can use HackBGRT! It is *still advised* you use it with caution, as it can brick your Windows installation.

Run `HackBGRT-2.6.0 (Use with caution!)\setup.exe`


## ❓ Troubleshooting

### Installation fails or components don't appear
1. Make sure you ran PowerShell **as Administrator**
2. Set execution policy: `Set-ExecutionPolicy RemoteSigned`
3. Check `install.log` in the repo root for error details
4. Try installing components individually to isolate the problem

### Theme not showing in Personalization
- SecureUxTheme must be installed first (reboot if prompted)
- Run `Themes\copy.ps1` as Administrator
- The theme files appear under `C:\Windows\Resources\Themes\Aero10\`

### Windhawk mods not loading
- Ensure ResourceRedirect is copied: `Windhawk\copyResources.ps1`
- In Windhawk, set Resource Redirect theme path to: `C:\Windows\ResourceRedirect\theme.ini`
- Install each mod from `Windhawk\mods.txt` manually

### UWP apps broken after installing Explorer7
Explorer7 replaces Windows Explorer and may break UWP/Store apps. Switch to **StartIsBack++** if this is an issue.

### HackBGRT boot screen not working
- UEFI mode is required (not Legacy BIOS)
- **Secure Boot must be disabled** in BIOS/UEFI settings
- If Windows fails to boot, use Windows Recovery to restore the original boot logo

### Rollback / uninstall
1. Open **System Restore** and restore to the point created before installation
2. Or manually reverse each step:
   - Uninstall apps via Settings > Apps (Windhawk, AuthUX, SecureUxTheme, etc.)
   - Restore default sound scheme via `Sounds\copyAndApplyWindows10Sounds.ps1`
   - Delete custom themes from `C:\Windows\Resources\Themes\`
   - Delete `C:\Windows\ResourceRedirect\`
   - Delete `C:\Windows\DWMBlurGlass\`
   - **CPL restoration**: Restore original `system32` DLLs from backup; delete imported registry keys listed in each CPL page readme
   - **HomeGroup**: Restore original `stobject.dll` from `C:\Windows\System32\` backup
   - **Default Programs fix**: Delete the `{17cd9488-...}` CLSID key added by `DefaultPrograms.ps1`

## 🎯 What's New
### ✅ Recently Completed
- **Unified installer** (`install.ps1`) — interactive, silent, component-selection, restore point, logging
- **Default Programs CPL fix** — sub-page dead links resolved (Issue #5)
- **HomeGroup restoration** — registry keys, svchost config, stobject.dll replacement
- **30 theme variants** — 6 accent colors (Ruby Red, Emerald Green, Amethyst Purple, Teal, Orange, Hot Pink) x 3 base styles (Seven, Vista, Metro) — plus originals
- **Localization framework** — `Localization/New-Locale.ps1` helper, `-Language` parameter in installer, documentation for translators
- **Environment test script** (`Test-InstallEnvironment.ps1`) — checks prerequisites, component integrity, disk space, CPL script presence before installation
- **Installer improvements** — `-WhatIf` dry-run mode, automatic dependency resolution, dependency warnings, language detection

## 🎨 Theming other applications
- Firefox: 
  - Echelon: https://echelon-theme.github.io/ (for version 115ESR only)
  - Photon: https://github.com/zapSNH/zapsCoolPhotonTheme
- Thunderbird:
  - coming soon
- Steam:
  - Classic Steam Library: https://steambrew.app/theme?id=r2XyxiKzVyAIqsO3VIRF
  - OldSteam: https://steambrew.app/theme?id=8YTvx3fAAfwQSu6MNOfH


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
- [NT Modding Utility](https://get-ntmu.github.io/#!/), classic UAC
- [Cursors](https://www.rw-designer.com/cursor-set/windows-7-aero-1)
