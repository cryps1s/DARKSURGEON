<#  
	.SYNOPSIS  
	Installs OSXCollector from the GitHub repository.

	.DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT

	Installs OSXCollector from the GitHub repository.

	.NOTES 
	Thanks to Yelp for this awesome resource.

#>

Set-StrictMode -Version Latest

$GitBinary = "$Env:SystemDrive\Program Files\Git\cmd\git.exe"
$ToolsFolder = "$Env:SystemDrive\Users\darksurgeon\tools"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Try 
 { 
	 # Clone the git repo
	 & $GitBinary clone https://github.com/Yelp/osxcollector.git $ToolsFolder\git\OSXCollector
 }
Catch 
 {
	 Write-Host "Failed to clone the OSXCollector repository from GitHub. Exiting."
	 Write-Host $_.Exception | format-list -force
	 Exit 1 
 }

Try 
{ 
	# Clone the git repo
	& $GitBinary clone https://github.com/Yelp/osxcollector_output_filters.git $ToolsFolder\git\OSXCollectorOutputFilters
}
Catch 
{
	Write-Host "Failed to clone the OSXCollector repository from GitHub. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1 
}
