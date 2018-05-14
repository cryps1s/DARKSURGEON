<#  
	.SYNOPSIS  
	Installs yara-python from the Internet via Chocolatey. 

	.DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT  

	Performs a standard chocolatey installation of the most recent stable version of yara-python. 

	.NOTES 
#>

Set-StrictMode -Version Latest

[String]$PackageName = "yara-python"
[Int]$RetryCounter = 0
[Int]$RetryMax = 3 
[Int]$SleepCounter = 30

# Load the Install-ChocolateyPackage Function 
. "$($PSScriptRoot)\Install-ChocolateyPackage.ps1"

$PackageName = "yara-python"
[Array] $OptionalArguments = "-source","python"

Try 
{
	Install-ChocolateyPackage -PackageName $PackageName -OptionalArguments $OptionalArguments
}
Catch 
{
	Write-Host "Fatal erorr installing package $PackageName. Exiting."	
	Exit 1
}