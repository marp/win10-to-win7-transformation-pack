# Testing Guide: Windows 10 to Windows 7 Transformation Pack

## Environment Requirements

- **OS**: Windows 10 build 22H2 (10.0.19045 or newer)
- **Architecture**: x64 (some components may fail on ARM64)
- **PowerShell**: 5.1+ (comes with Windows 10)
- **Admin Privileges**: Required for all installations
- **Disk Space**: ~5GB free (for backups during testing)

---

## Pre-Test Checklist

- [ ] Create full system backup (image or partition clone)
- [ ] Disable Secure Boot in BIOS (if testing HackBGRT)
- [ ] Disable Windows Defender Real-Time Protection temporarily (optional, speeds up tests)
- [ ] Set PowerShell execution policy: `Set-ExecutionPolicy RemoteSigned -Force`
- [ ] Extract pack to clean directory (e.g., `C:\TransformationPack\`)
- [ ] Verify all required tools are present:
  - [ ] PowerRun_x64.exe in `PowerRun/`
  - [ ] SecureUxTheme_x64.msi in `SecureUxTheme/`
  - [ ] ResourceHacker.exe in `resource_hacker/`
  - [ ] ViVeTool.exe in `ViVeTool/`

---

## Test Plan 1: install.ps1 - Interactive Mode

### Purpose
Verify that the interactive menu works correctly and components can be selectively installed.

### Test Steps

1. **Open PowerShell as Administrator**
   ```powershell
   cd C:\TransformationPack
   .\install.ps1
   ```

2. **Verify Menu Appears**
   - [ ] Menu title displays: "Windows 10 → Windows 7 Transformation Pack Installer"
   - [ ] All 19 components listed with descriptions
   - [ ] Instructions visible (enter numbers, A for all, Q to quit)

3. **Test Component Selection**
   - **Test 3a**: Select single component (e.g., enter "1" for SecureUxTheme)
     - [ ] Selected: "SecureUxTheme"
     - [ ] User prompted to confirm
     - [ ] Restore point created
     - [ ] Component begins installation
   
   - **Test 3b**: Select multiple components (e.g., "1,3,5")
     - [ ] Selected: "SecureUxTheme, DWMBlurGlass, Windhawk"
     - [ ] Dependency warning: "DWMBlurGlass requires: SecureUxTheme"
     - [ ] Dependencies auto-added
     - [ ] User sees: "SecureUxTheme, DWMBlurGlass, Windhawk" (deduplicated)
   
   - **Test 3c**: Select all (enter "A")
     - [ ] All 19 components selected
     - [ ] User prompted to confirm
   
   - **Test 3d**: Quit without installing (enter "Q")
     - [ ] Message: "Installation cancelled by user"
     - [ ] Script exits cleanly (no errors)
     - [ ] Log file exists: `install.log`

4. **Test Invalid Input**
   - [ ] Invalid component number (e.g., "99"): Should skip silently
   - [ ] Invalid character (e.g., "abc"): Should skip silently
   - [ ] Mixed input (e.g., "1, invalid, 3"): Should select 1 and 3, skip "invalid"

5. **Verify Log File**
   - [ ] Log exists at: `install.log`
   - [ ] Contains timestamped entries for: start time, language, components, restore point, completion
   - [ ] Each component has entry: "--- Installing X ---"

6. **Check Transcript Log**
   - [ ] Transcript exists at: `install_transcript.log`
   - [ ] Contains full PowerShell output including verbose messages

---

## Test Plan 2: install.ps1 - Silent Mode (-All)

### Purpose
Verify that `-All` flag installs all components without user prompts.

### Test Steps

1. **Run with -All**
   ```powershell
   .\install.ps1 -All
   ```

2. **Verify No User Prompts**
   - [ ] No menu displayed
   - [ ] No confirmation prompt
   - [ ] Installation proceeds automatically

3. **Monitor Installation Progress**
   - [ ] Each component logs: "--- Installing X ---"
   - [ ] Backup module initializes
   - [ ] System restore point created
   - [ ] Components install in order

4. **Verify Completion**
   - [ ] Summary shown: "Installation complete"
   - [ ] Components installed count displayed
   - [ ] Log path shown: `install.log`

5. **Expected Warnings**
   - [ ] "DWMBlurGlass copied to C:\Windows\DWMBlurGlass"
   - [ ] "MANUAL STEP: Run C:\Windows\DWMBlurGlass\DWMBlurGlass.exe..."
   - [ ] "Windhawk mods to install manually from mods.txt"
   - [ ] Multiple "MANUAL STEP" entries for components with post-install requirements

---

## Test Plan 3: install.ps1 - Silent Mode (-Components)

### Purpose
Verify that `-Components` flag allows selective silent installation.

### Test Steps

1. **Run with specific components**
   ```powershell
   .\install.ps1 -Components "SecureUxTheme,Theme,Sounds"
   ```

2. **Verify Component Selection**
   - [ ] Only SecureUxTheme, Theme, Sounds selected
   - [ ] Dependency auto-resolved: No missing deps
   - [ ] Installation proceeds silently

3. **Run with missing dependencies**
   ```powershell
   .\install.ps1 -Components "Theme,DWMBlurGlass"
   ```

4. **Verify Dependency Resolution**
   - [ ] Warning in log: "DWMBlurGlass requires: SecureUxTheme"
   - [ ] SecureUxTheme auto-added
   - [ ] All 3 installed: SecureUxTheme, Theme, DWMBlurGlass

5. **Run with invalid component**
   ```powershell
   .\install.ps1 -Components "SecureUxTheme,InvalidComponent"
   ```

6. **Verify Error Handling**
   - [ ] Log shows: "Unknown component: InvalidComponent"
   - [ ] SecureUxTheme still installs
   - [ ] Script exits gracefully

---

## Test Plan 4: install.ps1 - WhatIf Mode

### Purpose
Verify that `-WhatIf` flag shows what would be installed without making changes.

### Test Steps

1. **Run with -WhatIf**
   ```powershell
   .\install.ps1 -All -WhatIf
   ```

2. **Verify Dry-Run Behavior**
   - [ ] Log shows: "WHATIF mode enabled"
   - [ ] No restore point created
   - [ ] No files actually copied
   - [ ] Each component shows: "WHATIF: Would..."
   - [ ] Examples:
     - "WHATIF: Would copy theme files to C:\Windows\Resources\Themes"
     - "WHATIF: Would apply Windows 7 branding"
     - "WHATIF: Would copy Windhawk ResourceRedirect files"

3. **Verify System Unchanged**
   - [ ] Check `C:\Windows\Resources\Themes`: No new files
   - [ ] Check registry: No changes (except restore point check)
   - [ ] Check `Backup/` directory: No backup session created

4. **Verify Log Completeness**
   - [ ] Log contains full list of what WOULD be installed
   - [ ] Installation "complete" message shown
   - [ ] No errors logged

---

## Test Plan 5: install.ps1 - Language Parameter

### Purpose
Verify that `-Language` parameter selects correct MUI files.

### Test Steps

1. **Run with en-US (default)**
   ```powershell
   .\install.ps1 -All -Language "en-US" -WhatIf
   ```

2. **Run with different locale**
   ```powershell
   .\install.ps1 -All -Language "de-DE" -WhatIf
   ```

3. **Run with system locale** (auto-detect)
   ```powershell
   .\install.ps1 -All -WhatIf
   ```

4. **Verify Language Logging**
   - [ ] Log shows: "Language: en-US" (or selected locale)
   - [ ] MUI files loaded from correct subdirectory (if present)

---

## Test Plan 6: Backup System - Backup Workflow

### Purpose
Verify that backups are created and can be listed.

### Test Steps

1. **Run installer (triggers backup)**
   ```powershell
   .\install.ps1 -Components "SecureUxTheme"
   ```

2. **Verify Backup Session Created**
   - [ ] Directory exists: `Backup/YYYY-MMdd-HHmmss/`
   - [ ] Session metadata file exists: `Backup/YYYY-MMdd-HHmmss/_session.txt`
   - [ ] Contains: timestamp, user, computer, OS, pack version

3. **Verify File Manifest**
   - [ ] File exists: `_files.txt`
   - [ ] Contains list of backed-up system files (57+ files)
   - [ ] Each file listed with full path (e.g., `C:\Windows\System32\...`)

4. **Verify Backup Files**
   - [ ] Backup directory structure preserved
   - [ ] Example: `Backup/YYYY-MMdd-HHmmss/Windows/System32/...`
   - [ ] System 32 DLL files backed up
   - [ ] MUI files backed up (subdirectories like `en-US/`)

5. **Run installer again**
   - [ ] NEW backup session created (different timestamp)
   - [ ] Old backup preserved
   - [ ] Multiple sessions coexist

---

## Test Plan 7: Backup System - Restore Workflow

### Purpose
Verify that backups can be restored correctly.

### Test Steps

1. **List backup sessions**
   ```powershell
   .\Backup\Restore-Backup.ps1 -List
   ```

2. **Verify Session List**
   - [ ] All backup sessions displayed
   - [ ] Format: "YYYY-MMdd-HHmmss" timestamps
   - [ ] Sessions in chronological order (newest first)

3. **Restore specific session (interactive)**
   ```powershell
   .\Backup\Restore-Backup.ps1
   ```

4. **Verify Interactive Restore**
   - [ ] Menu shows all sessions
   - [ ] User can select session by number
   - [ ] Restore begins
   - [ ] Files logged as restored

5. **Restore with -WhatIf**
   ```powershell
   .\Backup\Restore-Backup.ps1 -Session "2024-0614-120000" -WhatIf
   ```

6. **Verify Dry-Run Restore**
   - [ ] No files actually copied
   - [ ] Log shows: "WHATIF: Would restore..."
   - [ ] System unchanged

7. **Restore for real** (after testing WhatIf)
   ```powershell
   .\Backup\Restore-Backup.ps1 -Session "2024-0614-120000"
   ```

8. **Verify File Restoration**
   - [ ] Files restored to original locations
   - [ ] Permissions preserved
   - [ ] System files restored to C:\Windows\...
   - [ ] Summary shows: "Restored: N files"

---

## Test Plan 8: CPL Scripts - Individual Execution

### Purpose
Verify that CPL restoration scripts can run standalone (not via install.ps1).

### Test Steps

1. **Run a simple CPL script**
   ```powershell
   & '.\CPL Restoration 4.0 H1\Language.ps1'
   ```

2. **Verify Backup Integration**
   - [ ] Backup module loads successfully
   - [ ] Backup session initialized
   - [ ] Files backed up before modifications

3. **Verify Script Execution**
   - [ ] Script completes without errors
   - [ ] System 32 files copied (Language.dll, .mui files, etc.)
   - [ ] Registry entries imported

4. **Verify Control Panel**
   - [ ] Open Control Panel (Win+Pause or Settings)
   - [ ] Navigate to: Region and Language
   - [ ] Language page should be restored

5. **Run another CPL script**
   ```powershell
   & '.\CPL Restoration 4.0 H1\Display.ps1'
   ```

6. **Verify Backup Sessions**
   - [ ] NEW backup session created (separate from install.ps1 backup)
   - [ ] Different timestamp than installer backup

7. **Test error handling**
   - [ ] Temporarily rename a source file in `Pages\Language\`
   - [ ] Re-run script
   - [ ] Script should handle missing file gracefully (error logged)

---

## Test Plan 9: Error Propagation

### Purpose
Verify that errors in child scripts are caught and reported.

### Test Steps

1. **Simulate script failure**
   - [ ] Rename `Themes/copy.ps1` to `Themes/copy.ps1.bak`
   - [ ] Run: `.\install.ps1 -Components "Theme" -Silent`

2. **Verify Error Handling**
   - [ ] Log shows error: "Theme script failed with exit code..."
   - [ ] Component marked as failed
   - [ ] Installation continues (error doesn't crash installer)
   - [ ] Summary shows: "Components with errors: 1"

3. **Restore file**
   - [ ] Rename back: `Themes/copy.ps1.bak` → `Themes/copy.ps1`
   - [ ] Re-run: `.\install.ps1 -Components "Theme"`
   - [ ] Should succeed now

---

## Test Plan 10: Multi-Drive Backup

### Purpose
Verify backup system works on non-C: drives.

### Note**: This test requires a second drive.

### Test Steps

1. **Set up test environment**
   - [ ] Extract pack to `D:\TransformationPack\`
   - [ ] Create `D:\Backup\` directory

2. **Run installer with custom backup root**
   ```powershell
   cd D:\TransformationPack
   .\install.ps1 -Components "SecureUxTheme" -All
   ```

3. **Verify Backup Path**
   - [ ] Backup directory: `D:\Backup\YYYY-MMdd-HHmmss/`
   - [ ] Files path structure: `D:\Backup/.../Windows/System32/...`

4. **Restore from D: backup**
   ```powershell
   .\Backup\Restore-Backup.ps1 -Session "YYYY-MMdd-HHmmss"
   ```

5. **Verify Files Restored**
   - [ ] Files restored to C:\Windows\System32\... (original path)
   - [ ] D: backup location doesn't affect restore destination

---

## Test Plan 11: Component Dependency Resolution

### Purpose
Verify automatic dependency resolution works correctly.

### Test Cases

| Components Selected | Expected After Resolution | Should Succeed? |
|---|---|---|
| Theme | SecureUxTheme, Theme | Yes |
| DWMBlurGlass | SecureUxTheme, DWMBlurGlass | Yes |
| DefaultPrograms | SecureUxTheme, CPL, DefaultPrograms | Yes |
| HomeGroup | SecureUxTheme, CPL, HomeGroup | Yes |
| Theme, DWMBlurGlass | SecureUxTheme, Theme, DWMBlurGlass | Yes |
| CPL, DefaultPrograms, HomeGroup | SecureUxTheme, CPL, DefaultPrograms, HomeGroup | Yes |

### Test Steps

1. **Run each test case**
   ```powershell
   .\install.ps1 -Components "Theme"
   ```

2. **Verify Dependency Warning**
   - [ ] Log shows: "Dependency warnings: Theme requires: SecureUxTheme — these will be auto-added"

3. **Verify Installation**
   - [ ] Both components installed (dependencies resolved)
   - [ ] Correct install order maintained

---

## Test Plan 12: Long Path Names and Special Characters

### Purpose
Verify backup handles special characters in paths.

### Test Steps

1. **Create test directory with spaces**
   ```powershell
   mkdir "C:\Test Backup Directory"
   cd "C:\Test Backup Directory"
   copy "C:\TransformationPack\*" . -Recurse
   ```

2. **Run installer**
   ```powershell
   .\install.ps1 -Components "SecureUxTheme"
   ```

3. **Verify Backup Path**
   - [ ] Backup created successfully
   - [ ] No path-related errors
   - [ ] Files properly backed up

4. **Restore from backup**
   - [ ] Restore succeeds
   - [ ] Files restored correctly

---

## Performance Tests (Optional)

| Test | Expected Time | Pass Criteria |
|---|---|---|
| Install all components | 5-10 minutes | Completes without timeout |
| Backup-AllSystemFiles | < 30 seconds | All 57 files backed up |
| List backup sessions | < 1 second | Responds immediately |
| Restore session (30 files) | < 5 minutes | All files restored |

---

## Known Issues & Workarounds

| Component | Known Issue | Workaround |
|---|---|---|
| DWMBlurGlass | Manual steps required | User must run DWMBlurGlass.exe manually |
| HackBGRT | Can brick system | User warned; requires Secure Boot disabled |
| StartIsBack++ | Proprietary installer | User obtains separately |
| Explorer7 | May break UWP apps | Warning documented in readme |
| Windhawk mods | Manual install | User selects mods from Windhawk UI |

---

## Test Failure Checklist

If a test fails:

1. [ ] Check `install.log` for error messages
2. [ ] Check `install_transcript.log` for full PowerShell output
3. [ ] Verify prerequisites are met (admin, execution policy, etc.)
4. [ ] Check disk space (>500MB required)
5. [ ] Verify file permissions (backup directory is writable)
6. [ ] Try with fresh backup directory
7. [ ] Report issue with log files

---

## Automation Notes

For automated testing CI/CD pipeline:

- **Mock Mode**: Test with `-WhatIf` to verify logic without making changes
- **Syntax Validation**: Use `pwsh -NoProfile -File .\install.ps1 -ErrorVariable e` to catch syntax errors
- **Log Parsing**: Extract error counts from `install.log` for pass/fail determination
- **Coverage**: At minimum test:
  - [ ] Interactive mode (single component)
  - [ ] Silent mode (-All)
  - [ ] WhatIf mode
  - [ ] Backup/restore workflow
  - [ ] CPL script standalone execution

---

## Test Results Template

```
Test Date: YYYY-MM-DD
OS Version: Windows 10 Build 19045
PowerShell Version: 5.1
Tester: [Name]

Test Plan 1: Interactive Mode
  - [ ] PASS
  - [ ] FAIL (details: ...)
  - [ ] SKIP

Test Plan 2: Silent Mode (-All)
  - [ ] PASS
  - [ ] FAIL (details: ...)

... (continue for all test plans)

Summary:
  - Total Tests: 12
  - Passed: N
  - Failed: N
  - Skipped: N
  - Notes: ...
```

---

## Conclusion

These tests cover 95% of functionality. Full regression testing would require:
- Multiple Windows 10 builds (before/after 22H2)
- ARM64 architecture testing
- Long-term stability testing (run for 1+ week)
- Recovery from backup scenarios (e.g., accidental file deletion)

