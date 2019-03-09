<#  
	.SYNOPSIS  
	Sets global chocolatey settings and attempts to upgrade if a valid license is found.

	.DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT

	Sets global chocolatey settings.

	Specifically: 
	- Disables empty checksums. 
	- Disables package exit codes.
	- Accepts installation without prompting. 
	- Uses private download cache (if professional).
	- Enables virus checking (if professional).

	Attempts to upgrade if a valid license file is identified on the E:\ drive (assuming an ISO is already mounted at D:\) 

	.NOTES 
 #>

 Set-StrictMode -Version Latest

[String]$ChocolateySourceLicenseFile = "$Env:SystemDrive\packer\chocolatey.license.xml"
[String]$ChocolateyLicenseFolder = "$Env:SystemDrive\ProgramData\chocolatey\license"
[String]$ChocolateyLicenseDestinationFile = "$Env:SystemDrive\ProgramData\chocolatey\license\chocolatey.license.xml"

Try 
{
	# Set Default Chocolatey Settings
	
	# Set global confirmation
	choco feature enable -n allowGlobalConfirmation

	# Allow empty checksums
	choco feature enable -n allowEmptyChecksums

	# Disable package exit codes
	choco feature disable -n usePackageExitCodes

	# Disable animated download progress bar
	choco feature disable -n showDownloadProgress

	# Attempt to Upgrade License (If Present)
	If (Test-Path $ChocolateySourceLicenseFile)
	{
		Write-Host "Chocolatey license detected. Attempting to upgrade."
		# Create the directory
		New-Item $ChocolateyLicenseFolder -ItemType Directory -Force | Out-Null  
		
		# Copy the license file to the directory
		Copy-Item $ChocolateySourceLicenseFile -Destination $ChocolateyLicenseDestinationFile -Force | Out-Null 

		# Upgrade to professional
		choco upgrade chocolatey.extension -y --no-progress

		# Use private download caches (professional only)
		choco feature enable -n downloadCache

		# Enable virus checking by default (professional only)
		choco feature enable -n virusCheck

		Write-Host "Upgraded chocolatey license and applied settings."
		Exit 0
	}
	Else
	{
		Write-Host "Did not find a Chocolatey license. Proceeding without upgrade."
		Exit 0
	}

}
Catch
{
	Write-Host "[!] Error occurred in Set-ChocolateyProfessional.ps1. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1
}
