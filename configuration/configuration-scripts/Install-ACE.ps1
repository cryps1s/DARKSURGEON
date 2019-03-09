<#  
	.SYNOPSIS  
	Installs ACE from the GitHub repository.

	.DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT

	Installs ACE from the GitHub repository.

	.NOTES 
	Thanks to Jared Atkinson (@jaredcatkinson) and Rob Winchester (@robwinchester3) for this awesome resource.

#>

Set-StrictMode -Version Latest

# Load the Get-GitRepository Function 
. "$($PSScriptRoot)\Get-GitRepository.ps1"

$RepositoryURL = "https://github.com/Invoke-IR/ACE.git"

Try 
{
	Get-GitRepository -RepositoryURL $RepositoryURL 
}
Catch 
{
	Write-Host "Fatal erorr installing cloning $RepositoryURL. Exiting."	
	Exit 1
}
