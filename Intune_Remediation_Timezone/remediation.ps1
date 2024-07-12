try{
    $RegistryPath1 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location"
    $RegistryProperty1 = "Value"
    $RegistryValue1 = "Allow"

    if (!(Test-Path -LiteralPath $RegistryPath1)) {
        New-Item -Path $RegistryPath1 -Force -ErrorAction SilentlyContinue
    }

    New-ItemProperty -Path $RegistryPath1 -Name $RegistryProperty1 -Value $RegistryValue1 -PropertyType String -Force -ErrorAction SilentlyContinue

    $ServicePath2 = "HKLM:\SYSTEM\CurrentControlSet\Services\tzautoupdate"
    $ServiceProperty2 = "Start"
    $ServiceValue2 = 3

    if (!(Test-Path -LiteralPath $ServicePath2)) {
        New-Item -Path $ServicePath2 -Force -ErrorAction SilentlyContinue
    }

    New-ItemProperty -Path $ServicePath2 -Name $ServiceProperty2 -Value $ServiceValue2 -PropertyType DWord -Force -ErrorAction SilentlyContinue
    exit 0
}
catch{
    $errMsg = $_.Exception.Message
    Write-host $errMsg
    exit 1
}