# Reg2CI (c) 2022 by Roger Zander
try {
	if(-NOT (Test-Path -LiteralPath "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location")){ exti 1 };
	if((Get-ItemPropertyValue -LiteralPath 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location' -Name 'Value' -ea SilentlyContinue) -eq 'Allow') { } else { exit 1 };
}
catch { exit 1 }
exit 0