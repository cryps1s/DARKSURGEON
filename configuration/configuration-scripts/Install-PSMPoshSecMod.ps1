<#  
	.SYNOPSIS  
	Installs Posh-Secmod from the Internet via the Powershell Gallery. 

	.DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT  

	Performs a standard installation of Posh-Secmod using the Powershell Gallery.

	.NOTES 
	Thanks to Carlos Perez (@darkoperator) for this awesome resource.
#>

Set-StrictMode -Version Latest

# Load the Install-PowershellModule Function 
. "$($PSScriptRoot)\Install-PowershellModule.ps1"

$PackageName = "Posh-SecMod"

Try 
{
	Install-PowershellModule -PackageName $PackageName	
}
Catch 
{
	Write-Host "Fatal erorr installing package $PackageName. Exiting."	
	Exit 1
}