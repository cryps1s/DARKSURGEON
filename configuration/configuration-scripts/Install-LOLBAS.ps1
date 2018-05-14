<#  
	.SYNOPSIS  
	Installs Living Off The Land Binaries And Scripts (LOLBAS) from the GitHub repository.

	.DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT

	Installs Living Off The Land Binaries And Scripts (LOLBAS) from the GitHub repository.

	.NOTES 
	Thanks to api0cradle for this awesome resource.
	
#>

Set-StrictMode -Version Latest

$GitBinary = "$Env:SystemDrive\Program Files\Git\cmd\git.exe"
$ToolsFolder = "$Env:SystemDrive\Users\darksurgeon\tools"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Try 
 { 
	# Clone the git repo
	& $GitBinary clone https://github.com/api0cradle/LOLBAS.git $ToolsFolder\git\LOLBAS
 }
Catch 
 {
	Write-Host "Failed to clone the LOLBAS repository from GitHub. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1 
 }