<#  
.SYNOPSIS  
Installs hashtab from the Internet via Chocolatey. 

.DESCRIPTION  
Author: Dane Stuckey (@cryps1s)
License: MIT  

Performs a standard chocolatey installation of the most recent stable version of hashtab. 

.NOTES 
#>
  
Set-StrictMode -Version Latest

# Load the Install-ChocolateyPackage Function 
. "$($PSScriptRoot)\Install-ChocolateyPackage.ps1"

$PackageName = "hashtab"

Try 
{
	Install-ChocolateyPackage -PackageName $PackageName	
}
Catch 
{
	Write-Host "Fatal erorr installing package $PackageName. Exiting."	
	Exit 1
}