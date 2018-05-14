<#  
	.SYNOPSIS  
	Installs Python from the Internet via Chocolatey. 

	.DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT  

	Performs a standard chocolatey installation of the most recent stable version of Python. 

	.NOTES 
	Based on FLAREVM Project - GitHub Project: https://github.com/fireeye/flare-vm 
#>
  
Set-StrictMode -Version Latest

# Load the Install-ChocolateyPackage Function 
. "$($PSScriptRoot)\Install-ChocolateyPackage.ps1"

$PackageName = "python2"
[Array] $OptionalArguments = "--package-parameters","'/InstallDir:`"$Env:SystemDrive\Program Files\Python27`"'"

Try 
{
	Install-ChocolateyPackage -PackageName $PackageName	-OptionalArguments $OptionalArguments
}
Catch 
{
	Write-Host "Fatal erorr installing package $PackageName. Exiting."	
	Exit 1
}

$PackageName = "python2.nopath"
[Array] $OptionalArguments = "--x86","--package-parameters","'/InstallDir:`"$Env:SystemDrive\Program Files (x86)\Python27`"'"

Try 
{
	Install-ChocolateyPackage -PackageName $PackageName	-OptionalArguments $OptionalArguments
}
Catch 
{
	Write-Host "Fatal erorr installing package $PackageName. Exiting."	
	Exit 1
}