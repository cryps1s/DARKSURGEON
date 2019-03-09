<#  
	.SYNOPSIS  
	Removes NetBIOS over TCP/IP (NBT). 

	.DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT

	Removes support for NetBIOS over TCP/IP (NBT) which is targeted by various MITM and exploit techniques. 

	.NOTES 
	Script borrowed from Alexandre Viot (https://www.alexandreviot.net/2014/10/09/powershell-disable-netbios-interface/)
 #>

 Try
 {
	 # Disable NBT 
	 $adapters = (gwmi win32_networkadapterconfiguration )
	 foreach ($adapter in $adapters)
	 {
		$adapter.settcpipnetbios(2) | Out-Null
	 }
 }

 Catch
 {
	 Write-Error "Could not create registry key to disable LLMNR. Exiting."
	 Write-Host $_.Exception | format-list -force
	Exit 1
 }