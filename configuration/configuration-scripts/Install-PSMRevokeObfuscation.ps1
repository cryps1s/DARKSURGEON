<#  
	.SYNOPSIS  
	Installs Revoke-Obfuscation from the Internet via the Powershell Gallery. 

	.DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT  

	Performs a standard installation of Revoke-Obfuscation using the Powershell Gallery.

	.NOTES 
#>

Set-StrictMode -Version Latest

# Load the Install-PowershellModule Function 
. "$($PSScriptRoot)\Install-PowershellModule.ps1"

$PackageName = "Revoke-Obfuscation"

Try 
{
	Install-PowershellModule -PackageName $PackageName	
}
Catch 
{
	Write-Host "Fatal erorr installing package $PackageName. Exiting."	
	Exit 1
}