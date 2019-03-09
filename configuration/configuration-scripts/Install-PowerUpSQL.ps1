<#  
	.SYNOPSIS  
	Installs PowerUpSQL from the GitHub repository.

	.DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT

	Installs PowerUpSQL from the GitHub repository.

	.NOTES 
	Thanks to NetSPI for this awesome resource.

#>

Set-StrictMode -Version Latest

$GitBinary = "$Env:SystemDrive\Program Files\Git\cmd\git.exe"
$ToolsFolder = "$Env:SystemDrive\Users\darksurgeon\tools"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Try 
 { 
	 # Clone the git repo
	 & $GitBinary clone https://github.com/NetSPI/PowerUpSQL $ToolsFolder\git\PowerUpSQL
 }
Catch 
 {
	 Write-Host "Failed to clone the PowerUpSQL repository from GitHub. Exiting."
	 Write-Host $_.Exception | format-list -force
	 Exit 1 
 }