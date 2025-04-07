$registryPath = RegistryHKEY_CLASSES_ROOTCLSID{D4901DB7-8296-40be-837C-0046F28B9E49}

if (Test-Path $registryPath) {
    try {
        Remove-Item -Path $registryPath -Recurse -Force
        Write-Output Klucz został usunięty $registryPath
    } catch {
        Write-Error Błąd podczas usuwania klucza $_
    }
} else {
    Write-Output Klucz nie istnieje $registryPath
}
