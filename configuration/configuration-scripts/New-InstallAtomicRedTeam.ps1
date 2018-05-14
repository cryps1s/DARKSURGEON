<#  
	.SYNOPSIS  
	Installs Red Canary Atomic Red Team from the GitHub repository.

	.DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT

	Installs Red Canary Atomic Red Team from the GitHub repository.

	.NOTES 
	Thanks to Red Canary Co for this awesome resource.
#>

Set-StrictMode -Version Latest

$GitBinary = "$Env:SystemDrive\Program Files\Git\cmd\git.exe"
$ToolsFolder = "$Env:SystemDrive\Users\surgeon\tools"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Try 
 { 
	# Clone the git repo
	& $GitBinary clone https://github.com/redcanaryco/atomic-red-team.git $ToolsFolder\git\atomic-red-team
 }
Catch 
 {
	Write-Host "Failed to clone the Red Canary Atomic Red Team repository from GitHub. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1 
 }