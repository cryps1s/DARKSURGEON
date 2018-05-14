<#  
	.SYNOPSIS  
	Installs DotNet3.5 from the Internet via Chocolatey. 

	.DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT

	Performs a standard Chocolatey installation of the most recent stable version of DotNet3.5. 

	.NOTES 
#>

Set-StrictMode -Version Latest

# Load the Install-ChocolateyPackage Function 
. "$($PSScriptRoot)\Install-ChocolateyPackage.ps1"

$PackageName = "dotnet3.5"

Try 
{
	Install-ChocolateyPackage -PackageName $PackageName	
}
Catch 
{
	Write-Host "Fatal erorr installing package $PackageName. Exiting."	
	Exit 1
}