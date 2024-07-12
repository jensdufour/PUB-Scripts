try{
		if (Test-Path -LiteralPath "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location") {
		$value = Get-ItemPropertyValue -LiteralPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location' -Name 'Value' -ErrorAction SilentlyContinue
		if ($value -eq 'Allow') {
			write-host "Success"
			exit 0
		}
	}
}
catch{
	$errMsg = $_.Exception.Message
	write-host $errMsg
	exit 1
}