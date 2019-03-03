<#  
	.SYNOPSIS  
	Configures Firefox settings to respect privacy.

	.DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT

	Configures Firefox settings to respect privacy: 
	- Installs privacy-centric extensions.

    .NOTES 
#>

 Set-StrictMode -Version Latest

 try {
	# Set reasonable firefox defaults
	$RegistryKeyPath = "HKLM:\Software\Policies\Mozilla\Firefox\"
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
	 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	# Disable Telemetry
	New-ItemProperty -Path $RegistryKeyPath -Name "DisableFirefoxStudies" -PropertyType DWORD -Value 1 -Force | Out-Null
	New-ItemProperty -Path $RegistryKeyPath -Name "DisableTelemetry" -PropertyType DWORD -Value 1 -Force | Out-Null

	# Disable Password Collection
	New-ItemProperty -Path $RegistryKeyPath -Name "DisableFormHistory" -PropertyType DWORD -Value 1 -Force | Out-Null
	New-ItemProperty -Path $RegistryKeyPath -Name "DisableMasterPasswordCreation" -PropertyType DWORD -Value 1 -Force | Out-Null
	New-ItemProperty -Path $RegistryKeyPath -Name "OfferToSaveLogins" -PropertyType DWORD -Value 0 -Force | Out-Null

	# Disable Pocket
	New-ItemProperty -Path $RegistryKeyPath -Name "DisablePocket" -PropertyType DWORD -Value 1 -Force | Out-Null

	# Enable Bookmarks + Menu Bar
	New-ItemProperty -Path $RegistryKeyPath -Name "DisplayMenuBar" -PropertyType DWORD -Value 1 -Force | Out-Null
	New-ItemProperty -Path $RegistryKeyPath -Name "DisplayBookmarksToolbar" -PropertyType DWORD -Value 1 -Force | Out-Null

	# Clean on Shutdown
	New-ItemProperty -Path $RegistryKeyPath -Name "SanitizeOnShutdown" -PropertyType DWORD -Value 1 -Force | Out-Null

	# Override run pages
	New-ItemProperty -Path $RegistryKeyPath -Name "OverrideFirstRunPage" -PropertyType String -Value "" -Force | Out-Null
	New-ItemProperty -Path $RegistryKeyPath -Name "OverridePostUpdatePage" -PropertyType String -Value "" -Force | Out-Null

	# Set Home Page
	$RegistryKeyPath = "HKLM:\Software\Policies\Mozilla\Firefox\Homepage"
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	New-ItemProperty -Path $RegistryKeyPath -Name "StartPage" -PropertyType String -Value "none" -Force | Out-Null

	# Disable NTLM/SPNEGO
	$RegistryKeyPath = "HKLM:\Software\Policies\Mozilla\Firefox\Authentication\AllowNonFQDN"
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	# Disable NTLM Auth
	New-ItemProperty -Path $RegistryKeyPath -Name "NTLM" -PropertyType DWORD -Value 0 -Force | Out-Null
	# Disable SPNego
	New-ItemProperty -Path $RegistryKeyPath -Name "NTLM" -PropertyType DWORD -Value 0 -Force | Out-Null
 
	# Control Cookie Behavior
	$RegistryKeyPath = "HKLM:\Software\Policies\Mozilla\Firefox\Cookies"
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	# Allow 3rd party cookies from visited
	New-ItemProperty -Path $RegistryKeyPath -Name "AcceptThirdParty" -PropertyType String -Value "from-visited" -Force | Out-Null
	# Default allow cookies
	New-ItemProperty -Path $RegistryKeyPath -Name "Default" -PropertyType DWORD -Value 1 -Force | Out-Null
	# Expire at session end
	New-ItemProperty -Path $RegistryKeyPath -Name "ExpireAtSessionEnd" -PropertyType DWORD -Value 1 -Force | Out-Null
	# Reject tracker cookies
	New-ItemProperty -Path $RegistryKeyPath -Name "RejectTracker" -PropertyType DWORD -Value 1 -Force | Out-Null

	# Control Permissions
	# Disable Camera Usage
	$RegistryKeyPath = "HKLM:\Software\Policies\Mozilla\Firefox\Permissions\Camera"
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	New-ItemProperty -Path $RegistryKeyPath -Name "BlockNewRequests" -PropertyType DWORD -Value 1 -Force | Out-Null

	# Disable Location Usage
	$RegistryKeyPath = "HKLM:\Software\Policies\Mozilla\Firefox\Permissions\Location"
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	New-ItemProperty -Path $RegistryKeyPath -Name "BlockNewRequests" -PropertyType DWORD -Value 1 -Force | Out-Null
	
	# Disable Microphone Usage
	$RegistryKeyPath = "HKLM:\Software\Policies\Mozilla\Firefox\Permissions\Microphone"
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	New-ItemProperty -Path $RegistryKeyPath -Name "BlockNewRequests" -PropertyType DWORD -Value 1 -Force | Out-Null

	# Disable Notifications
	$RegistryKeyPath = "HKLM:\Software\Policies\Mozilla\Firefox\Permissions\Notifications"
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	New-ItemProperty -Path $RegistryKeyPath -Name "BlockNewRequests" -PropertyType DWORD -Value 1 -Force | Out-Null
	
	# Block Popups
	$RegistryKeyPath = "HKLM:\Software\Policies\Mozilla\Firefox\PopupBlocking"
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	New-ItemProperty -Path $RegistryKeyPath -Name "Default" -PropertyType DWORD -Value 0 -Force | Out-Null

}
 catch {
	Write-Error "Could not Firefox privacy registry keys. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1 
 }


 Try 
 {
	# Minimize Data Collection to Security-only
	$RegistryKeyPath = "HKLM:\Software\Policies\Mozilla\Firefox\Extensions\Install\"
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
	 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	# Add UBlock Origin
	New-ItemProperty -Path $RegistryKeyPath -Name "1" -PropertyType String -Value "https://addons.mozilla.org/firefox/downloads/file/1166954" -Force | Out-Null
	# Add HTTPS Everywhere
	New-ItemProperty -Path $RegistryKeyPath -Name "2" -PropertyType String -Value "https://addons.mozilla.org/firefox/downloads/file/1132037" -Force | Out-Null
	# Add uMatrix
	New-ItemProperty -Path $RegistryKeyPath -Name "3" -PropertyType String -Value "https://addons.mozilla.org/firefox/downloads/file/1057194" -Force | Out-Null
	# Add PrivacyBadger
	New-ItemProperty -Path $RegistryKeyPath -Name "4" -PropertyType String -Value "https://addons.mozilla.org/firefox/downloads/file/1183754" -Force | Out-Null
	# Add NoScript
	New-ItemProperty -Path $RegistryKeyPath -Name "5" -PropertyType String -Value "https://addons.mozilla.org/firefox/downloads/file/1189923" -Force | Out-Null
	# Add Proxy SwitchyOmega
	New-ItemProperty -Path $RegistryKeyPath -Name "6" -PropertyType String -Value "https://addons.mozilla.org/firefox/downloads/file/1056777" -Force | Out-Null
	# Add Firefox Multi-Account Containers
	New-ItemProperty -Path $RegistryKeyPath -Name "7" -PropertyType String -Value "https://addons.mozilla.org/firefox/downloads/file/1171317" -Force | Out-Null
	# Add User-Agent Switcher
	New-ItemProperty -Path $RegistryKeyPath -Name "8" -PropertyType String -Value "https://addons.mozilla.org/firefox/downloads/file/969712" -Force | Out-Null
	# Add Disable WebRTC
	New-ItemProperty -Path $RegistryKeyPath -Name "9" -PropertyType String -Value "https://addons.mozilla.org/firefox/downloads/file/847927" -Force | Out-Null
	# Add Canvas Defender
	New-ItemProperty -Path $RegistryKeyPath -Name "10" -PropertyType String -Value "https://addons.mozilla.org/firefox/downloads/file/680137" -Force | Out-Null
 }
 Catch
 {
	Write-Error "Could not write Firefox extension installation registry keys. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1
 }
