<#  
	.SYNOPSIS
	Configures Windows Defender with optimal settings for malware analysis. 

	.DESCRIPTION
	Author: Dane Stuckey (@cryps1s)
	License: MIT

	Configures Windows Defender Settings with optimal settings for malware analysis. This includes: 

	- Disable On-Access Scanning
	- Disable Scanning of Mounted/Network Shares/Drives
	- Disable Cloud Reputation and Reporting
	- Disable Response to Detected Items
	- Enable 1 Hour Signature Updates (For On-Demand Scanning) 
	- Adds exceptions for malware folders under $Env:SystemDrive\username\malware

	.NOTES 
#>

Set-StrictMode -Version Latest

Try
{
	# Create Malware folder for exceptions for scanning.
	New-Item -Path "$Env:SystemDrive\Users\darksurgeon\malware" -ItemType Directory -Force | Out-Null
	New-Item -Path "$Env:SystemDrive\Users\unprivileged\malware" -ItemType Directory -Force | Out-Null

	# Create Tools folder for exceptions for scanning.
	New-Item -Path "$Env:SystemDrive\Users\darksurgeon\tools" -ItemType Directory -Force | Out-Null
	New-Item -Path "$Env:SystemDrive\Users\unprivileged\tools" -ItemType Directory -Force | Out-Null
}
Catch
{
	Write-Error "Could not create malware directory. Exiting."
	Write-Host $_.Exception | format-list -force; Write-Host $_.Exception | format-list -force
	Exit 1
}

Try
{
	# Start the WinDefend Service
	Start-Service WinDefend
}
Catch
{
	Write-Error "Could not configure the WinDefend service. Exiting."
	Write-Host $_.Exception | format-list -force; Write-Host $_.Exception | format-list -force
	Exit 1
}

Try 
{
	# Perform Hourly Signature Updates
	Set-MpPreference -SignatureUpdateInterval 1

	# Check for new Signatures before Scanning
	Set-MpPreference -CheckForSignaturesBeforeRunningScan $true

	# Enable Archive Scanning
	Set-MpPreference -DisableArchiveScanning $false 

	# Disable Behavior Monitoring
	Set-MpPreference -DisableBehaviorMonitoring $true 

	# Disable Block at First Seen
	Set-MpPreference -DisableBlockAtFirstSeen $true 

	# Disable Catchup Full Scan
	Set-MpPreference -DisableCatchupFullScan $true

	# Disable Catchup Quick Scan
	Set-MpPreference -DisableCatchupQuickScan $true

	# Disable Email Scanning
	Set-MpPreference -DisableEmailScanning $true 

	# Disable IO AV Protection (e.g. Downloads)
	Set-MpPreference -DisableIOAVProtection $true 

	# Disable Intrusion Prevention System
	Set-MpPreference -DisableIntrusionPreventionSystem $true 

	# Disable Privacy Mode 
	Set-MpPreference -DisablePrivacyMode $true 

	# Disable Realtime Protection
	Set-MpPreference -DisableRealtimeMonitoring $true 

	# Disable Removable Drive Scanning
	Set-MpPreference -DisableRemovableDriveScanning $true 

	# Disable Restore Points
	Set-MpPreference -DisableRestorePoint $true 

	# Disable Mapped Drive Scans
	Set-MpPreference -DisableScanningMappedNetworkDrivesForFullScan $true 

	# Disable Scanning of Network Files
	Set-MpPreference -DisableScanningNetworkFiles $true 

	# Disable Script Scans
	Set-MpPreference -DisableScriptScanning $true

	# Disable PUA Protection
	Set-MpPreference -PUAProtection Disabled

	# Create Exclusions for Malware Folders
	Set-MpPreference -ExclusionPath "$Env:SystemDrive\Users\darksurgeon\malware"
	Set-MpPreference -ExclusionPath "$Env:SystemDrive\Users\unprivileged\malware"

	# Create Exclusions for Tools Folders
	Set-MpPreference -ExclusionPath "$Env:SystemDrive\Users\darksurgeon\tools"
	Set-MpPreference -ExclusionPath "$Env:SystemDrive\Users\unprivileged\tools"

	# Create Exclusions for Chocolatey Installs
	Set-MPPreference -ExclusionPath "$Env:SystemDrive\ProgramData\chocolatey"

	# Create Exclusions for Windows 10 Apps. Basically needed for Kali and other WSL. 
	Set-MpPreference -ExclusionPath "$Env:SystemDrive\Program Files\WindowsApps\"

	# Never Submit Samples
	Set-MpPreference -SubmitSamplesConsent Never 

	# Ignore Unknown Threats 
	Set-MpPreference -UnknownThreatDefaultAction NoAction

	# Ignore Severe Threats
	Set-MpPreference -SevereThreatDefaultAction NoAction

	# Ignore High Threat 
	Set-MpPreference -HighThreatDefaultAction NoAction

	# Ignore Moderate Threats
	Set-MpPreference -ModerateThreatDefaultAction NoAction

	# Ignore Low Threat 
	Set-MpPreference -LowThreatDefaultAction NoAction

	# Disable MAPS Reporting
	Set-MpPreference -MAPSReporting Disabled
}
Catch
{
	Write-Error "Could not configure Defender settings. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1
}
 