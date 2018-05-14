<#  
	.SYNOPSIS  
	Removes SMBv1 client support. 
	
	.DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT

	Removes support for SMBv1 from the client. This removes legacy code that is often targeted by exploits. 

	.NOTES 
#>

 Try
 {
	 # Disable SMBv1 Support
	 Set-SmbServerConfiguration -EnableSMB1Protocol $false -Force | Out-Null
 }
 Catch
 {
	 Write-Error "Could not remove SMBv1 support. Exiting."
	 Write-Host $_.Exception | format-list -force
 }

 Try 
 {
	 # Remove the SMBv1 Package
	 Disable-WindowsOptionalFeature -NoRestart -Online -FeatureName smb1protocol | Out-Null
 }
 Catch
 {
	 Write-Error "Could not uninstall the SMBv1 package. Exiting."
	 Write-Host $_.Exception | format-list -force
 }
 