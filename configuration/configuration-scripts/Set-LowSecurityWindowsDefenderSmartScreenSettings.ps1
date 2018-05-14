<#  
	.SYNOPSIS  
	Remove Defender SmartScreen.

	.DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT

	Removes Defender SmartScreen support from the following applications:
	- System
	- Internet Explorer
	- Edge
	- Windows 10 Apps 

	.NOTES 
#>

Set-StrictMode -Version Latest

 Try 
 {
	 # Force SmartScreen to be Off for the System
	 $RegistryKeyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer"
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	 # Add registry value to disable telemetry
	 New-ItemProperty -Path $RegistryKeyPath -Name SmartScreenEnabled -PropertyType String -Value "Off" -Force | Out-Null

	 # Force SmartScreen to be Off for the System
	 $RegistryKeyPath = "HKLM:\Software\Policies\Microsoft\Windows\System"
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	 New-ItemProperty -Path $RegistryKeyPath -Name EnableSmartScreen -PropertyType Dword -Value 0 -Force | Out-Null

	 # Disable SmartScreen for Edge
	 $RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter"
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	 New-ItemProperty -Path $RegistryKeyPath -Name EnabledV9 -PropertyType Dword -Value 0 -Force | Out-Null

	 # Disable SmartScreen for Internet Explorer
	 $RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\ Internet Explorer\PhishingFilter"
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	 New-ItemProperty -Path $RegistryKeyPath -Name EnabledV9 -PropertyType Dword -Value 0 -Force | Out-Null

	 # Force SmartScreen to be Off for Windows 10 Apps.
	 $RegistryKeyPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\AppHost"
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	 New-ItemProperty -Path $RegistryKeyPath -Name EnableWebContentEvaluation -PropertyType Dword -Value 0 -Force | Out-Null
	 New-ItemProperty -Path $RegistryKeyPath -Name PreventOverride -PropertyType Dword -Value 0 -Force | Out-Null
 }
 Catch
 {
	 Write-Error "Could not write SmartScreen registry keys. Exiting."
	 Write-Host $_.Exception | format-list -force; Write-Host $_.Exception | format-list -force
	Exit 1
 }
