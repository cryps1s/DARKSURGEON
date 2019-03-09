<#  
	.SYNOPSIS  
	Installs PSAttack from the GitHub repository.

	.DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT

	Installs PSAttack from the GitHub repository.

	.NOTES 
	Thanks to Mark Vincze for his script for downloading and parsing the latest release in a GitHub repository. 
	https://blog.markvincze.com/download-artifacts-from-a-latest-github-release-in-sh-and-powershell/

	Thanks to Jared Haight (@jaredhaight) for this awesome resource.

#>

Set-StrictMode -Version Latest

$GitBinary = "$Env:SystemDrive\Program Files\Git\cmd\git.exe"
$ToolsFolder = "$Env:SystemDrive\Users\darksurgeon\tools"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Try 
 { 
	 # Clone the git repo
	 & $GitBinary clone https://github.com/jaredhaight/PSAttack.git $ToolsFolder\git\PSAttack
 }
Catch 
 {
	 Write-Host "Failed to clone the psattack repository from GitHub. Exiting."
	 Write-Host $_.Exception | format-list -force
	 Exit 1 
 }

 Try 
 { 
	 # Clone the git repo
	 & $GitBinary clone https://github.com/jaredhaight/PSAttackBuildTool.git $ToolsFolder\git\PSAttackBuildTool
 }
Catch 
 {
	 Write-Host "Failed to clone the psattackbuildtool repository from GitHub. Exiting."
	 Write-Host $_.Exception | format-list -force
	 Exit 1 
 }

Try
{
	# Grab the latest release from the psattack repository, parse the tag
	$latestRelease = Invoke-WebRequest https://github.com/jaredhaight/PSAttack/releases/latest -Headers @{"Accept"="application/json"}
	$json = $latestRelease.Content | ConvertFrom-Json
	$latestVersion = $json.tag_name

	$numericVersion = $latestVersion.split("v")[1]

	# Construct the appropriate URIs to download the binary and validation file from.
	$binary_url = "https://github.com/jaredhaight/PSAttack/releases/download/$latestVersion/PSAttack-$numericVersion.zip"


	# Download the files.
	Invoke-WebRequest -Uri $binary_url -OutFile "$Env:SystemDrive\Users\darksurgeon\Desktop\PSAttack-$numericVersion.zip"
}
Catch
{
	Write-Error "Could not download PSAttack binaries from Github. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1
}

try 
{	
	# Unzip the downloaded release files.
	Expand-Archive "$Env:SystemDrive\Users\darksurgeon\Desktop\PSAttack-$numericVersion.zip" -DestinationPath "$ToolsFolder\PSAttack"
}
catch 
{
	Write-Error "Could not expand PSAttack ZIP file. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1
}

Try
{
	# Grab the latest release from the psattack repository, parse the tag
	$latestRelease = Invoke-WebRequest https://github.com/jaredhaight/PSAttackBuildTool/releases/latest -Headers @{"Accept"="application/json"}
	$json = $latestRelease.Content | ConvertFrom-Json
	$latestVersion = $json.tag_name

	# Construct the appropriate URIs to download the binary and validation file from.
	$binary_url = "https://github.com/jaredhaight/PSAttackBuildTool/releases/download/$latestVersion/PSAttackBuildTool-$latestVersion.zip"


	# Download the files.
	Invoke-WebRequest -Uri $binary_url -OutFile "$Env:SystemDrive\Users\darksurgeon\Desktop\PSAttackBuildTool-$latestVersion.zip"
}
Catch
{
	Write-Error "Could not download PSAttack binaries from Github. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1
}

try 
{	
	# Unzip the downloaded release files.
	Expand-Archive "$Env:SystemDrive\Users\darksurgeon\Desktop\PSAttackBuildTool-$latestVersion.zip" -DestinationPath "$ToolsFolder\PSAttackBuildTool"
}
catch 
{
	Write-Error "Could not expand PSAttack ZIP file. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1
}