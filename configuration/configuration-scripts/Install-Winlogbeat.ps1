<#  
	.SYNOPSIS  
	Installs Winlogbeat from the Internet via Chocolatey. 

	.DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT

	Performs a standard chocolatey installation of the most recent stable version of Winlogbeat. 

	.NOTES 
#>

Set-StrictMode -Version Latest

# Load the Install-ChocolateyPackage Function 
. "$($PSScriptRoot)\Install-ChocolateyPackage.ps1"

$PackageName = "winlogbeat"

Try 
{
	Install-ChocolateyPackage -PackageName $PackageName	
}
Catch 
{
	Write-Host "Fatal erorr installing package $PackageName. Exiting."	
	Exit 1
}

# Disable and Stop the winlogbeat service
Try
{
	Stop-Service -Name winlogbeat -Force
	Set-Service -Name winlogbeat -StartupType Disabled

}
Catch 
{
	Write-Host "[!] Error occurred attempting to stop the winlogbeat service. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1
}