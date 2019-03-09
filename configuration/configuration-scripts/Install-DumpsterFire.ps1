<#  
	.SYNOPSIS  
	Installs Dumpsterfire from the GitHub repository.

	.DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT

	Installs Dumpsterfire from the GitHub repository.

	.NOTES 
	Thanks to TryCatchHCF for this awesome resource.
	
#>

Set-StrictMode -Version Latest

$GitBinary = "$Env:SystemDrive\Program Files\Git\cmd\git.exe"
$ToolsFolder = "$Env:SystemDrive\Users\darksurgeon\tools"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Try 
 { 
	# Clone the git repo
	& $GitBinary clone https://github.com/TryCatchHCF/DumpsterFire.git $ToolsFolder\git\Dumpsterfire
 }
Catch 
 {
	Write-Host "Failed to clone the Dumpsterfire repository from GitHub. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1 
 }