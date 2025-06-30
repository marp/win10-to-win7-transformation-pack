Add-Type -AssemblyName System.Windows.Forms

# Sprawdzenie TrustedInstaller
$currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
$trustedInstallerSid = "S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464"

if ($currentUser.User.Value -ne $trustedInstallerSid) {
    [System.Windows.Forms.MessageBox]::Show("Ten skrypt musi być uruchomiony jako TrustedInstaller!", "Błąd", 'OK', 'Error')
    exit
}

# Zabicie explorer.exe
Stop-Process -Name explorer -Force

# Lista folderów z DLL do skopiowania
$folderList = @(
    #"Pages\Backup and Restore CPL\7 Style\system32\",
    #"Biometric Devices CPL"

    "Pages\Display CPL\7 Style\system32\",
    #"Pages\Mobility Center CPL\7 Style\system32\",
    #"Pages\Notification Tray Icons CPL\Optional\8.X Style\system32\"
    #"Pages\Windows Update CPL\7 Style\system32\"
    #"Pages\Region and Input CPL\7 Style\"
    #"Pages\Recovery CPL\7 Style\system32\"
    # <-- dodaj kolejne foldery tutaj
)

$destinationFolder = "$env:SystemRoot\System32"

foreach ($relativeFolder in $folderList) {
    $sourceFolder = Join-Path -Path $PSScriptRoot -ChildPath $relativeFolder

    if (Test-Path $sourceFolder) {
        $dllFiles = Get-ChildItem -Path $sourceFolder -Filter *.dll -File
        foreach ($file in $dllFiles) {
            $destPath = Join-Path -Path $destinationFolder -ChildPath $file.Name
            try {
                Copy-Item -Path $file.FullName -Destination $destPath -Force
                Write-Output "✅ Skopiowano: $($file.Name)"
            } catch {
                Write-Output "❌ Błąd kopiowania: $($file.FullName)"
            }
        }
    } else {
        Write-Output "⚠️ Folder nie istnieje: $sourceFolder"
    }
}

# (opcjonalnie) uruchom ponownie explorer.exe
 Start-Process explorer.exe
