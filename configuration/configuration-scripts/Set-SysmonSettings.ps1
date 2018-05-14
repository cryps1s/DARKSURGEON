<#  
	.SYNOPSIS  
	Configures Sysmon using the Swiftonsecurity public ruleset.

	.DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT

	Configures Sysmon to user the Swiftonsecurity public ruleset. Clones master from the github repository and imports sysmonconfig-export.xml

	.NOTES 
#>

$GitBinary = "$Env:SystemDrive\Program Files\Git\cmd\git.exe"
$SysmonFolder = "$Env:SystemDrive\packer\Sysmon"
$SysmonBinary = "$SysmonFolder\Sysmon64.exe"
$ConfigFolder = "$Env:SystemDrive\packer\git\sysmon-config"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Try 
 { 
	 # Clone the git repo
	 & $GitBinary clone https://github.com/SwiftOnSecurity/sysmon-config.git $ConfigFolder
 }
Catch 
 {
	 Write-Host "Failed to clone the sysmon-config repository for GitHub. Exiting."
	 Write-Host $_.Exception | format-list -force
	 Exit 1 
 }

Try
{
	# Installs Sysmon binary and driver.
  & $SysmonBinary -accepteula -c $ConfigFolder\sysmonconfig-export.xml
}
Catch
{
	Write-Error "Could not install the Sysmon binary and driver. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1
}

Try
{
	# Starts the Sysmon Service
	Start-Service Sysmon64
}
Catch
{
	Write-Error "Could not start the Sysmon64 service. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1
}