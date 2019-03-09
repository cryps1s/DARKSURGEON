<#  
	.SYNOPSIS  
	Configures DARKSURGEON Theme Settings.

	.DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT

	Configures DARKSURGEON Theme Settings with the following:
	- Blanks out the start menu.

	.NOTES 

#>

 # Set Start Menu Layout
Try
{
	# Export the XML to a file on disk
	Copy-Item -Path "$Env:SystemDrive\packer\start_layout.xml" -Destination "$env:userprofile\Documents\start_layout.xml" -Force

	$RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer"
	 # Create the registry key if it doesn't exist 
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	# Add registry value to use the layout
	New-ItemProperty -Path $RegistryKeyPath -Name LockedStartLayout -PropertyType DWORD -Value 1 -Force | Out-Null
	# Add registry value to use the layout
	New-ItemProperty -Path $RegistryKeyPath -Name StartLayoutFile -PropertyType ExpandString -Value "$env:userprofile\Documents\start_layout.xml" -Force | Out-Null
}
Catch
{
	Write-Error "Could not apply Windows 10 Start Menu themeing. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1
}

# Customize Start Menu
Try 
{
	$RegistryKeyPath = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"
	# Create the registry key if it doesn't exist 
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	# Disables "Frequent Programs" entry in start menu.
	New-ItemProperty -Path $RegistryKeyPath -Name NoStartMenuMFUprogramsList -PropertyType DWORD -Value 1 -Force | Out-Null
	# Removes recently added applications from start menu. 
	New-ItemProperty -Path $RegistryKeyPath -Name HideRecentlyAddedApps -PropertyType DWORD -Value 1 -Force | Out-Null
}
Catch 
{
	
}

# Customize Explorer Preferences
Try
{
	$RegistryKeyPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\"
	 # Create the registry key if it doesn't exist 
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	# Add registry values
	New-ItemProperty -Path $RegistryKeyPath -Name HideFileExt -PropertyType DWORD -Value 0 -Force | Out-Null
	New-ItemProperty -Path $RegistryKeyPath -Name Hidden -PropertyType DWORD -Value 1 -Force | Out-Null
	New-ItemProperty -Path $RegistryKeyPath -Name SuperHidden -PropertyType DWORD -Value 0 -Force | Out-Null

	# Add for DEFAULT user
	$RegistryKeyPath = "Registry::HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\"
	# Create the registry key if it doesn't exist 
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	# Add registry values
	New-ItemProperty -Path $RegistryKeyPath -Name HideFileExt -PropertyType DWORD -Value 0 -Force | Out-Null
	New-ItemProperty -Path $RegistryKeyPath -Name Hidden -PropertyType DWORD -Value 1 -Force | Out-Null
	New-ItemProperty -Path $RegistryKeyPath -Name SuperHidden -PropertyType DWORD -Value 0 -Force | Out-Null
}
Catch
{
	Write-Error "Could not apply Windows Explorer Themeing. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1
}