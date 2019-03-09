<#  
	.SYNOPSIS  
	Installs Hyper-V and Containers Features.

	.DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT  

	Install the Hyper-V and Containers Features from Microsoft. Required for VBS and other security controls.

	.NOTES 
#>

 Set-StrictMode -Version Latest

 Try
 {
	 # Install the Hyper-V containers package, preserve restart
	 Enable-WindowsOptionalFeature -Online -FeatureName containers –All -NoRestart | Out-Null
	 
	 # Install the Hyper-V package, preserve restart
	 Enable-WindowsOptionalFeature -Online -FeatureName:Microsoft-Hyper-V -All -NoRestart | Out-Null
 }
 Catch
 {
	 Write-Error "Could not install Hyper-V and Containers Feature. Exiting."
	 Write-Host $_.Exception | format-list -force
	Exit 1
 }