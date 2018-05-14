  <#  
   .SYNOPSIS  
	Installs dnspy from the Internet via Chocolatey (FLARE). 
	
   .DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT

	Performs a standard chocolatey installation of the most recent stable version of dnspy. (FLARE) 
	
   .NOTES 
    Based on FLAREVM Project - GitHub Project: https://github.com/fireeye/flare-vm 
    Requires configuration of the FLAREVM chocolately repository. Added in Set-ChocolateyFLARERepo.
 #> 
  
Set-StrictMode -Version Latest

# Load the Install-ChocolateyPackage Function 
. "$($PSScriptRoot)\Install-ChocolateyPackage.ps1"

$PackageName = "dnspy"
[Array] $OptionalArguments = "--skip-virus-check"

Try 
{
	Install-ChocolateyPackage -PackageName $PackageName	-OptionalArguments $OptionalArguments
}
Catch 
{
	Write-Host "Fatal erorr installing package $PackageName. Exiting."	
	Exit 1
}