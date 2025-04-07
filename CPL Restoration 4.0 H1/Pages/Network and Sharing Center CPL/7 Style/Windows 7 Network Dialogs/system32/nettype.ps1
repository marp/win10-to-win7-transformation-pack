$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Profiles"
$connectedNetworkProfile = Get-NetConnectionProfile | Where-Object { $_.IPv4Connectivity -ne 'Disconnected' -or $_.IPv6Connectivity -ne 'Disconnected' }
if ($connectedNetworkProfile) {
    $connectedNetworkName = $connectedNetworkProfile.Name
    $profileKeys = Get-ChildItem -Path $registryPath
    foreach ($key in $profileKeys) {
        $networkGuid = $key.PSChildName
        $networkName = Get-ItemProperty -Path "$registryPath\$networkGuid" | Select-Object -ExpandProperty ProfileName
        if ($networkName -eq $connectedNetworkName) {
            Write-Host "Connected Network Name: $networkName"
            Write-Host "GUID: $networkGuid"
            Write-Host "----------------------------------"
            $command = "rundll32.exe pnidui.dll,NwCategoryWiz {$networkGuid} 1"
            Write-Host "Executing command: $command"
            Start-Process -FilePath "rundll32.exe" -ArgumentList "pnidui.dll,NwCategoryWiz $networkGuid 0" -NoNewWindow -Wait
        }
    }
} else {
    Write-Host "No active network connection found."
}
