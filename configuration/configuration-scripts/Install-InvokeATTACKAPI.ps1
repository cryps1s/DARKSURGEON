<#  
	.SYNOPSIS  
	Installs Invoke-ATTACKAPI from the GitHub repository.

	.DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT

	Installs Invoke-ATTACKAPI from the GitHub repository.

	.NOTES 
	Thanks to Roberto Rodriguez (@cyb3rward0g) for this awesome resource.
#>

Set-StrictMode -Version Latest

$GitBinary = "$Env:SystemDrive\Program Files\Git\cmd\git.exe"
$ToolsFolder = "$Env:SystemDrive\Users\darksurgeon\tools"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Try 
 { 
	# Clone the git repo
	& $GitBinary clone https://github.com/Cyb3rWard0g/Invoke-ATTACKAPI $ToolsFolder\git\Invoke-ATTACKAPI
 }
Catch 
 {
	Write-Host "Failed to clone the Invoke-ATTACKAPI repository from GitHub. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1 
 }