<#  
	.SYNOPSIS  
	Installs Bloodhound from the GitHub repository.

	.DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT

	Installs Bloodhound from the GitHub repository.

	.NOTES 
	Thanks to Mark Vincze for his script for downloading and parsing the latest release in a GitHub repository. 
	https://blog.markvincze.com/download-artifacts-from-a-latest-github-release-in-sh-and-powershell/

	Thanks to @_wald0, @CptJesus, and @harmj0y for this awesome resource.

#>

Set-StrictMode -Version Latest

$GitBinary = "$Env:SystemDrive\Program Files\Git\cmd\git.exe"
$ToolsFolder = "$Env:SystemDrive\Users\darksurgeon\tools"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Try 
 { 
	 # Clone the git repo
	 & $GitBinary clone https://github.com/BloodHoundAD/SharpHound $ToolsFolder\git\Sharphound
 }
Catch 
 {
	 Write-Host "Failed to clone the Sharphound repository from GitHub. Exiting."
	 Write-Host $_.Exception | format-list -force
	 Exit 1 
 }

 Try 
 { 
	 # Clone the git repo
	 & $GitBinary clone https://github.com/BloodHoundAD/BloodHound $ToolsFolder\git\Bloodhound
 }
Catch 
 {
	 Write-Host "Failed to clone the Bloodhoundbuildtool repository from GitHub. Exiting."
	 Write-Host $_.Exception | format-list -force
	 Exit 1 
 }

Try
{
	# Grab the latest release from the Bloodhound repository, parse the tag
	$latestRelease = Invoke-WebRequest https://github.com/BloodHoundAD/BloodHound/releases/latest -Headers @{"Accept"="application/json"}
	$json = $latestRelease.Content | ConvertFrom-Json
	$latestVersion = $json.tag_name

	$numericVersion = $latestVersion.split("v")[1]

	# Construct the appropriate URIs to download the binary and validation file from.
	$binary_url = "https://github.com/jaredhaight/Bloodhound/releases/download/$latestVersion/BloodHound-win32-x64.zip"


	# Download the files.
	Invoke-WebRequest -Uri $binary_url -OutFile "$Env:SystemDrive\Users\darksurgeon\Downloads\Bloodhound-$numericVersion-win32-x64.zip"
}
Catch
{
	Write-Error "Could not download Bloodhound binaries from Github. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1
}

try 
{	
	# Unzip the downloaded release files.
	Expand-Archive "$Env:SystemDrive\Users\darksurgeon\Desktop\Bloodhound-$numericVersion-win32-x64.zip" -DestinationPath "$ToolsFolder\Bloodhound"
}
catch 
{
	Write-Error "Could not expand Bloodhound ZIP file. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1
}
