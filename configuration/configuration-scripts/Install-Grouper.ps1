<#  
	.SYNOPSIS  
	Installs Grouper from the GitHub repository.

	.DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT

	Installs Grouper from the GitHub repository.

	.NOTES 
	Thanks to l0ss for this awesome resource.
	
#>

Set-StrictMode -Version Latest

$GitBinary = "$Env:SystemDrive\Program Files\Git\cmd\git.exe"
$ToolsFolder = "$Env:SystemDrive\Users\darksurgeon\tools"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Try 
 { 
	# Clone the git repo
	& $GitBinary clone https://github.com/l0ss/Grouper.git $ToolsFolder\git\Grouper
 }
Catch 
 {
	Write-Host "Failed to clone the Grouper repository from GitHub. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1 
 }