<#  
	.SYNOPSIS  
	Installs Timeline Explorer from the Internet via Chocolatey. 

	.DESCRIPTION 
	Author: Dane Stuckey (@cryps1s)
	License: MIT  
	
	Performs a standard chocolatey installation of the most recent stable version of Timeline Explorer. 

	.NOTES 
#>

Set-StrictMode -Version Latest

# Load the Install-ChocolateyPackage Function 
. "$($PSScriptRoot)\Install-ChocolateyPackage.ps1"

$PackageName = "timelineexplorer"

Try 
{
	Install-ChocolateyPackage -PackageName $PackageName	
}
Catch 
{
	Write-Host "Fatal erorr installing package $PackageName. Exiting."	
	Exit 1
}