<#  
	.SYNOPSIS  
	Removes WPAD (Web Proxy Auto-Discovery Protocol). 

	.DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT

	Removes support for WPAD (Web Proxy Auto-Discovery Protocol), which is targeted by various MITM and exploit techniques. 

	.NOTES 
#>

 Set-StrictMode -Version Latest

 Try
 {
	 # Disable WPAD via Registry Key
	 $RegistryKeyPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Wpad"
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	 Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Wpad" -Name "WpadOverride" -Value 1 -Type DWord -Force  | Out-Null
 }
 Catch
 {
	Write-Error "Could not add WPAD registry key. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1	 
 }

 Try 
 {
	 # Disable WPAD via hosts file
	$HostFileEntry = "
### Added by DARKSURGEON PACKER ###
255.255.255.255 wpad
255.255.255.255 wpad.
### Added by DARKSURGEON PACKER ###
"

	$HostFileEntry | Out-File -FilePath "$env:systemroot\System32\drivers\etc\hosts" -Append 
 }
 Catch 
 {
	Write-Error "Could not modify HOSTS file with WPAD entry. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1	 
 }