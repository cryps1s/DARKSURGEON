<#  
	.SYNOPSIS  
	Installs Neo4J Community from the Internet via Chocolatey. 

	.DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT  

	Performs a standard chocolatey installation of the most recent stable version of Neo4J Community. 

	.NOTES 
#>

Set-StrictMode -Version Latest

# Load the Install-ChocolateyPackage Function 
. "$($PSScriptRoot)\Install-ChocolateyPackage.ps1"

$PackageName = "neo4j-community"

Try 
{
	Install-ChocolateyPackage -PackageName $PackageName	
}
Catch 
{
	Write-Host "Fatal erorr installing package $PackageName. Exiting."	
	Exit 1
}

# Disable and Stop the Neo4j service
Try
{
	Stop-Service -Name neo4j -Force
	Set-Service -Name neo4j -StartupType Disabled

}
Catch 
{
	Write-Host "[!] Error occurred attempting to stop the Neo4J service. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1
}