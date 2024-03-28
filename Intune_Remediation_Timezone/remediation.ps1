$RegistryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location"
$RegistryProperty = "Value"
$RegistryValue = "Allow"

if (!(Test-Path -LiteralPath $RegistryPath)) {
    New-Item -Path $RegistryPath -Force -ErrorAction SilentlyContinue
}

New-ItemProperty -Path $RegistryPath -Name $RegistryProperty -Value $RegistryValue -PropertyType String -Force -ErrorAction SilentlyContinue

$ServicePath = "HKLM:\SYSTEM\CurrentControlSet\Services\tzautoupdate"
$ServiceProperty = "Start"
$ServiceValue = 3

if (!(Test-Path -LiteralPath $ServicePath)) {
    New-Item -Path $ServicePath -Force -ErrorAction SilentlyContinue
}

New-ItemProperty -Path $ServicePath -Name $ServiceProperty -Value $ServiceValue -PropertyType DWord -Force -ErrorAction SilentlyContinue
