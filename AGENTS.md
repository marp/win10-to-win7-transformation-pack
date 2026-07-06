# AGENTS.md

This is a **Windows 10 → Windows 7 transformation pack** — a collection of third-party tools, themes, scripts, and resources. It is **not** a software project with builds or tests. All operations are Windows-specific (PowerShell, registry, MSI installers, UEFI).

## Requirements
- Windows 10 **22H2** only
- PowerShell must run **as Administrator**
- Execution policy must be set: `Set-ExecutionPolicy RemoteSigned`
- Explorer7 requires a Windows 7 ISO (en-US, matching architecture)

## Key structure
| Directory | Purpose |
|---|---|
| `Windhawk/` | Windhawk mod loader: `installWindhawk.ps1` → `copyResources.ps1` → install mods from `mods.txt` |
| `Themes/` | Aero10 theme variants; run `copy.ps1` as Admin to install |
| `Sounds/` | `copyAndApplyWindows7Sounds.ps1` to apply sound scheme |
| `Branding/` | `copy.ps1` for Windows 7 logo branding |
| `AuthUX/` | Logon screen replacement installer |
| `classicuac-1.0.3/` | Non-XAML UAC — use `NTMU.exe` with `pack.ini` |
| `CPL Restoration 4.0 H1/` | 21 functional `.ps1` scripts per Control Panel page (+ 2 prep scripts) |
| `ExplorerTransparency/DWMBlurGlass/` | Copied to `C:\Windows`, then run manually |
| `StartMenuAndTaskBar/` | Contains Explorer7 (experimental) and StartIsBack++ (paid) installers |
| `Cursors/` | Install via `Install.inf` (right-click) |
| `HackBGRT 2.6.0/` | UEFI boot screen — requires **Secure Boot disabled** |
| `Outdated_and_unfinished_autoinstaller.ps1.deprecated` | **Do not use** — outdated, partial, lacks safety checks |

## Installer
- **`install.ps1`** (repo root) is the unified installer: supports interactive menu, `-All`, and `-Components "A,B,C"`
- Creates a system restore point; logs to `install.log`
- Components with manual post-steps are flagged in the log
- `Outdated_and_unfinished_autoinstaller.ps1.deprecated` is deprecated — do not use

## Critical notes
- StartIsBack++ and Explorer7 are proprietary (StartIsBack++ is paid)
- HackBGRT can brick the Windows install if Secure Boot is not disabled
- Explorer7 may **break UWP apps**
- Always create a **full system backup** before applying anything
- No CI, no tests, no lint/typecheck — this is a distribution repo only
- `Windhawk/ResourceRedirect/theme.ini` is the resource redirect config
- `Windhawk/RemoveWindows10sUWPTitlebars.txt` is a reference file (not applied automatically)
