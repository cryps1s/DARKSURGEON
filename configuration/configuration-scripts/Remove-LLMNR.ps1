<#  
	.SYNOPSIS  
	Removes LLMNR (Link-Local Multicast Name Resolution). 

	.DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT

	Removes support for LLMNR (Link-Local Multicast Name Resolution), which is targeted by various MITM and exploit techniques. 

	.NOTES 
#>

 Set-StrictMode -Version Latest

 Try
 {
	 # Disable LLMNR 
	 $RegistryKeyPath = "HKLM:\Software\Policies\Microsoft\Windows NT\DNSClient"
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force  | Out-Null
	 }
	 Set-ItemProperty "HKLM:\Software\Policies\Microsoft\Windows NT\DNSClient" -Name "EnableMulticast" -Value 1 -Type DWord -Force  | Out-Null
 }
 Catch
 {
	 Write-Error "Could not create registry key to disable LLMNR. Exiting."
	 Write-Host $_.Exception | format-list -force
	Exit 1
 }