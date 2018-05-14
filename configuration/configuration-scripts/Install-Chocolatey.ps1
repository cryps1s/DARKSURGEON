<#  
	.SYNOPSIS  
	Installs Chocolatey from the Internet.

	.DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT

	Performs a standard chocolatey installation from the Internet using the beautiful windows version of curl | bash. 

	.NOTES 
#>

Set-StrictMode -Version Latest

# Installs Chocolatey
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
# Forces an exit 0 due to the chocolatey installer. If chocolatey fails to install as expected, this will fail on the first choco install function.
Exit 0