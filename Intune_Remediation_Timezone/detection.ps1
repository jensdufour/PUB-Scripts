try {
	if (-not (Test-Path -LiteralPath "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location")) {
		return $false
		exit 1
	}
	if ((Get-ItemPropertyValue -LiteralPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location' -Name 'Value' -ea SilentlyContinue) -eq 'Allow') {
		return $true
		exit 0
	} else {
		return $false
		exit 1
	}
} 
catch {		
	return $false
	exit 1
}