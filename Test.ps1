# Check if running as administrator
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    # Relaunch as administrator
    Start-Process PowerShell -Verb RunAs "-File `"$PSCommandPath`""
    exit
}

# Ensure script runs in its own directory
Set-Location -Path (Split-Path -Parent $PSCommandPath)

# Install AuthUX
$authUxPath = "$PSScriptRoot/AuthUX v0.0.1-beta/AuthUX-setup-x64.exe"
if (Test-Path $authUxPath) {
    Write-Host "Installing AuthUX..."
    Start-Process -FilePath $authUxPath -ArgumentList "/S" -Wait
} else {
    Write-Warning "AuthUX installer not found at: $authUxPath"
}

# Install SecureUxTheme
$msiPath = "$PSScriptRoot/SecureUxTheme/SecureUxTheme_x64.msi"
Write-Host "Ścieżka do MSI: $msiPath"

if (Test-Path $msiPath) {
    # Get file info for diagnostics
    $fileInfo = Get-Item $msiPath
    Write-Host "File size: $($fileInfo.Length) bytes"
    Write-Host "File last modified: $($fileInfo.LastWriteTime)"
    
    # Try to verify MSI file integrity
    Write-Host "Verifying MSI file..."
    try {
        $msiInfo = Get-AppxPackage -Path $msiPath -ErrorAction SilentlyContinue
    } catch {
        # This is expected for MSI files, ignore
    }
    
    Write-Host "Installing SecureUxTheme..."
    
    # First try with full path and different arguments
    try {
        $fullMsiPath = (Get-Item $msiPath).FullName
        Write-Host "Full MSI path: $fullMsiPath"
        
        # Try with /quiet instead of /qb!
        $arguments = @("/i", "`"$fullMsiPath`"", "/passive", "/norestart")
        Write-Host "MSI arguments: $($arguments -join ' ')"
        
        $process = Start-Process -FilePath "msiexec.exe" -ArgumentList $arguments -Wait -PassThru -NoNewWindow
        
        switch ($process.ExitCode) {
            0 { Write-Host "SecureUxTheme installed successfully" }
            3010 {  
                Write-Host "SecureUxTheme installed successfully - restart required to complete installation"
                Write-Warning "A system restart is required to complete the SecureUxTheme installation"
            }
            1619 { 
                Write-Host "MSI package error (1619). Trying alternative method..."
                # Try running MSI directly
                $altProcess = Start-Process -FilePath $fullMsiPath -Wait -PassThru -ErrorAction SilentlyContinue
                if ($altProcess.ExitCode -eq 0) {
                    Write-Host "SecureUxTheme installed via direct execution"
                } else {
                    Write-Error "Alternative installation also failed. The MSI file may be corrupted or incompatible."
                }
            }
            1602 { Write-Warning "Installation was cancelled by user" }
            1603 { Write-Error "Fatal error during installation" }
            1618 { Write-Error "Another installation is already in progress" }
            default { Write-Error "SecureUxTheme installation failed with exit code: $($process.ExitCode)" }
        }
    }
    catch {
        Write-Error "Error installing SecureUxTheme: $($_.Exception.Message)"
    }
} else {
    Write-Error "MSI file not found at: $msiPath"
}
# Copy themes
$themesScript = "$PSScriptRoot/Themes/copy.ps1"
if (Test-Path $themesScript) {
    Write-Host "Copying themes..."
    & $themesScript
} else {
    Write-Warning "Themes script not found at: $themesScript"
}

# Install Windhawk
$windhawkPath = "$PSScriptRoot/Windhawk/windhawk_setup.exe"
if (Test-Path $windhawkPath) {
    Write-Host "Installing Windhawk..."
    Start-Process -FilePath $windhawkPath -ArgumentList "/S" -Wait
} else {
    Write-Warning "Windhawk installer not found at: $windhawkPath"
}

# Copy Windhawk Redirect Resource Files
$windhawkRedirectResourceFilesScript = "$PSScriptRoot/Windhawk/copyResources.ps1"
if (Test-Path $windhawkRedirectResourceFilesScript) {
    Write-Host "Copying Windhawk redirect resource files..."
    & $windhawkRedirectResourceFilesScript
} else {
    Write-Warning "Windhawk redirect resource files script not found at: $windhawkRedirectResourceFilesScript"
}

# Apply branding
$brandingScript = "$PSScriptRoot/Branding/copy.ps1"
if (Test-Path $brandingScript) {
    Write-Host "Applying branding..."
    & $brandingScript
} else {
    Write-Warning "Branding script not found at: $brandingScript"
}

Write-Host "Installation complete!"

# Copy and apply Windows 7 sounds
$soundsScript = "$PSScriptRoot/Sounds/copyAndApplyWindows7Sounds.ps1"
if (Test-Path $soundsScript) {
    Write-Host "Copying and applying Windows 7 sounds..."
    & $soundsScript
} else {
    Write-Warning "Windows 7 sounds script not found at: $soundsScript"
}

