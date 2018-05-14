<#  
	.SYNOPSIS  
	Configures Windows 10 Telemetry settings to respect privacy.

	.DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT

	Configures Windows 10 Telemetry settings to respect privacy: 
	- Data Collection is Disabled
	- Cortana is Disabled
	- Diagnostics Tracking Service is Disabled
	- diagnosticshub.standardcollector.service Service is Disabled
	- Connected User Experiences and Telemetry Service is Disabled
	- Malicious Software Removal Tool Reporting is Disabled
	- Find My Device is Disabled
	- Insider Previews are Disabled
	- Internet Explorer Telemetry is Disabled
	- Edge Telemetry is Disabled
	- Windows Timeline is Disabled

    .NOTES 
    https://docs.microsoft.com/en-us/windows/configuration/manage-connections-from-windows-operating-system-components-to-microsoft-services
#>

 Set-StrictMode -Version Latest

 Try
 {
	 # Disable Connected User Experiences and Telemetry Service
	 Stop-Service -Name dmwappushservice -Force
	 Set-Service -Name dmwappushservice -StartupType Disabled
 }
 Catch
 {
	 Write-Error "Could not disable dmwappushservice service. Exiting."
	 Write-Host $_.Exception | format-list -force
	Exit 1
 }

 Try
 {
	 # Disable Diagnostics Tracking Service
	 Stop-Service -Name DiagTrack -Force
	 Set-Service -Name DiagTrack -StartupType Disabled
 }
 Catch
 {
	 Write-Error "Could not disable DiagTrack service. Exiting."
	 Write-Host $_.Exception | format-list -force
	Exit 1
 }

  Try
 {
	 # Disable diagnosticshub.standardcollector.service Service
	 Stop-Service -Name "diagnosticshub.standardcollector.service" -Force
	 Set-Service -Name "diagnosticshub.standardcollector.service" -StartupType Disabled
 }
 Catch
 {
	 Write-Error "Could not disable diagnosticshub.standardcollector.service service. Exiting."
	 Write-Host $_.Exception | format-list -force
	Exit 1
 }

 Try 
 {
	 # Disable auto signin on restart
	 $RegistryKeyPath = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System"
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	 # Add registry value to disable telemetry
	 New-ItemProperty -Path $RegistryKeyPath -Name DisableAutomaticRestartSignOn -PropertyType DWord -Value 1 -Force | Out-Null
 }
 Catch
 {
	 Write-Error "Could not write registry keys to disable auto signin on restart. Exiting."
	 Write-Host $_.Exception | format-list -force
	Exit 1
 }

 Try 
 {
	 # Minimize Data Collection to Security-only
	 $RegistryKeyPath = "HKLM:\Software\Policies\Microsoft\Windows\DataCollection"
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	 # Add registry value to disable telemetry
	 New-ItemProperty -Path $RegistryKeyPath -Name AllowTelemetry -PropertyType DWord -Value 0 -Force | Out-Null
	 # Suppress feedback notifications
	 New-ItemProperty -Path $RegistryKeyPath -Name DoNotShowFeedbackNotifications -PropertyType DWord -Value 1 -Force | Out-Null
 }
 Catch
 {
	 Write-Error "Could not write DataCollection registry keys. Exiting."
	 Write-Host $_.Exception | format-list -force
	Exit 1
 }

  Try 
 {
	 # Disable Malicious Software Removal Tool Infection Reporting
	 $RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\MRT"
	 # Create the registry key if it doesn't exist 
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	 # Add registry value to disable telemetry
	 New-ItemProperty -Path $RegistryKeyPath -Name DontReportInfectionInformation -PropertyType DWord -Value 1 -Force | Out-Null
	 New-ItemProperty -Path $RegistryKeyPath -Name DontOfferThroughWUAU -PropertyType DWord -Value 1 -Force | Out-Null
 }
 Catch
 {
	 Write-Error "Could not write MRT registry keys. Exiting."
	 Write-Host $_.Exception | format-list -force
	Exit 1
 }

 Try
 {
	 # Disable Cortana
	 $RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
	 # Create the registry key if it doesn't exist 
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	 # Add registry value to disable cortana
	 New-ItemProperty -Path $RegistryKeyPath -Name AllowCortana -PropertyType DWord -Value 0 -Force | Out-Null
	 # Add registry value to disable web search
	 New-ItemProperty -Path $RegistryKeyPath -Name DisableWebSearch -PropertyType DWord -Value 1 -Force | Out-Null
	 # Add registry value to disable search location
	 New-ItemProperty -Path $RegistryKeyPath -Name AllowSearchToUseLocation -PropertyType DWord -Value 1 -Force | Out-Null
	 # Add registry value to disable ConnectedSearchUseWeb
	 New-ItemProperty -Path $RegistryKeyPath -Name ConnectedSearchUseWeb -PropertyType DWord -Value 0 -Force | Out-Null
	 # Add registry value to disable Bing Sharing
	 New-ItemProperty -Path $RegistryKeyPath -Name ConnectedSearchPrivacy -PropertyType DWord -Value 3 -Force | Out-Null
 }
 Catch
 {
	 Write-Error "Could not disable Cortana. Exiting."
	 Write-Host $_.Exception | format-list -force
	Exit 1
 }

 Try
 {
	 # Disable Find My Device
	 $RegistryKeyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata"
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	 # Add registry value to disable Device Metadata Upload
	 New-ItemProperty -Path $RegistryKeyPath -Name PreventDeviceMetadataFromNetwork -PropertyType DWord -Value 1 -Force | Out-Null

	 # Disable Find My Device
	 $RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\FindMyDevice"
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	 # Add registry value to disable Find My Device
	 New-ItemProperty -Path $RegistryKeyPath -Name AllowFindMyDevice -PropertyType DWord -Value 0 -Force | Out-Null
 }
 Catch
 {
	 Write-Error "Could not write Find My Device registry keys. Exiting."
	 Write-Host $_.Exception | format-list -force
	Exit 1
 }

 Try
 {
	 # Disable Windows Experience Customer Improvement Program
	 $RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds"
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	 # Add registry value to disable Build Previews
	 New-ItemProperty -Path $RegistryKeyPath -Name AllowBuildPreview -PropertyType DWord -Value 0 -Force | Out-Null
	 # Add registry value to disable Build Config Flighting
	 New-ItemProperty -Path $RegistryKeyPath -Name EnableConfigFlighting -PropertyType DWord -Value 0 -Force | Out-Null
 }
 Catch
 {
	 Write-Error "Could not write WIP registry keys. Exiting."
	 Write-Host $_.Exception | format-list -force
	Exit 1
 }

 Try
 {
	 # Disable Live Tiles for current user
	 $RegistryKeyPath = "HKCU:\Software\Policies\Microsoft\Windows\CurrentVersion\PushNotifications"
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	 New-ItemProperty -Path $RegistryKeyPath -Name NoCloudApplicationNotification -PropertyType Dword -Value 1 -Force | Out-Null

	# Disable Live Tiles for all users
	 $RegistryKeyPath = "Registry::HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\PushNotifications"
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	 New-ItemProperty -Path $RegistryKeyPath -Name NoCloudApplicationNotification -PropertyType Dword -Value 1 -Force | Out-Null

	 # Disable spotlight
	 $RegistryKeyPath = "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	 New-ItemProperty -Path $RegistryKeyPath -Name DisableWindowsSpotlightFeatures -PropertyType Dword -Value 1 -Force | Out-Null
 
	# Disable spotlight
	$RegistryKeyPath = "Registry::HKEY_USERS\.DEFAULT\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	New-ItemProperty -Path $RegistryKeyPath -Name DisableWindowsSpotlightFeatures -PropertyType Dword -Value 1 -Force | Out-Null

 }
 Catch
 {
	 Write-Error "Could not write Live Tile registry keys. Exiting."
	 Write-Host $_.Exception | format-list -force
	Exit 1
 }

  Try
 {
	 # Internet Explorer Settings
	 # Disable Suggestions
	 $RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer"
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	 New-ItemProperty -Path $RegistryKeyPath -Name AllowServicePoweredQSA -PropertyType DWord -Value 0 -Force | Out-Null

	 # Disable Suggested Sites
	 $RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Suggested Sites"
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	 New-ItemProperty -Path $RegistryKeyPath -Name Enabled -PropertyType DWord -Value 0 -Force | Out-Null
	 
	 # Disable Geolocation
	 $RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Geolocation"
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	 New-ItemProperty -Path $RegistryKeyPath -Name AllowServicePoweredQSA -PropertyType DWord -Value 0 -Force | Out-Null

	# Disable AutoSuggest / AutoComplete
	$RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\AutoComplete"
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	New-ItemProperty -Path $RegistryKeyPath -Name AutoSuggest -PropertyType String -Value "no" -Force | Out-Null	 

	# Disable AutoSuggest / AutoComplete
	$RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Geolocation"
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	New-ItemProperty -Path $RegistryKeyPath -Name PolicyDisableGeolocation  -PropertyType DWORD -Value 1 -Force | Out-Null	 

	 # Disable AutoSuggest / AutoComplete
	 $RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Explorer\AutoComplete"
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	 New-ItemProperty -Path $RegistryKeyPath -Name AutoSuggest -PropertyType String -Value "no" -Force | Out-Null

	 # Disable First Run
	 $RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main"
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	 New-ItemProperty -Path $RegistryKeyPath -Name DisableFirstRunCustomize -PropertyType Dword -Value 1 -Force | Out-Null

	 # Disable RSS Feeds
	 $RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Feeds"
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	 New-ItemProperty -Path $RegistryKeyPath -Name BackgroundSyncStatus -PropertyType Dword -Value 0 -Force | Out-Null

	 # Disable Compatibility Mode
	 $RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\BrowserEmulation"
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	 New-ItemProperty -Path $RegistryKeyPath -Name DisableSiteListEditing -PropertyType Dword -Value 1 -Force | Out-Null

	 # Disable Flip Ahead Mode
	 $RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\FlipAhead"
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	 New-ItemProperty -Path $RegistryKeyPath -Name Enabled -PropertyType Dword -Value 0 -Force | Out-Null

	 # Set New Tab to Blank
	 $RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\TabbedBrowsing"
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	 New-ItemProperty -Path $RegistryKeyPath -Name NewTabPageShow -PropertyType Dword -Value 0 -Force | Out-Null

	 # Set Homepage and Search Page to Blank
	 $RegistryKeyPath = "HKCU:\Software\Microsoft\Internet Explorer\Main"
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	 New-ItemProperty -Path $RegistryKeyPath -Name "Search Page" -PropertyType String -Value "about:blank" -Force | Out-Null
	 New-ItemProperty -Path $RegistryKeyPath -Name "Start Page" -PropertyType String -Value "about:blank" -Force | Out-Null

	 # Set Homepage and Search Page to Blank
	 $RegistryKeyPath = "Registry::HKEY_USERS\.DEFAULT\Software\Microsoft\Internet Explorer\Main"
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	 New-ItemProperty -Path $RegistryKeyPath -Name "Search Page" -PropertyType String -Value "about:blank" -Force | Out-Null
	 New-ItemProperty -Path $RegistryKeyPath -Name "Start Page" -PropertyType String -Value "about:blank" -Force | Out-Null
 }
 Catch
 {
	 Write-Error "Could not write Internet Explorer registry keys. Exiting."
	 Write-Host $_.Exception | format-list -force
	Exit 1
 }

 Try
 {
	 #Configure Edge Settings
	 # Disable Compatibility Mode
	 $RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\BrowserEmulation"
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	 New-ItemProperty -Path $RegistryKeyPath -Name MSCompatibilityMode -PropertyType DWord -Value 0 -Force | Out-Null

	 # Set Homepage to Blank
	 $RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Internet Settings"
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	 New-ItemProperty -Path $RegistryKeyPath -Name ProvisionedHomePages -PropertyType String -Value "<about:blank>" -Force | Out-Null

	 $RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main"
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	 # Disable Passwords
	 New-ItemProperty -Path $RegistryKeyPath -Name "FormSuggest Passwords" -PropertyType String -Value "no" -Force | Out-Null
	 # Disable First Run
	 New-ItemProperty -Path $RegistryKeyPath -Name PreventFirstRunPage -PropertyType Dword -Value 1 -Force | Out-Null
	 # Disable Live Tile Data Collection
	 New-ItemProperty -Path $RegistryKeyPath -Name PreventLiveTileDataCollection -PropertyType Dword -Value 1 -Force | Out-Null
	 # Disable Form Suggestion
	 New-ItemProperty -Path $RegistryKeyPath -Name "Use FormSuggest" -PropertyType String -Value "no" -Force | Out-Null

	 # Disable Search Suggestions
	 $RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\SearchScopes"
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	 New-ItemProperty -Path $RegistryKeyPath -Name ShowSearchSuggestionsGlobal -PropertyType DWord -Value 0 -Force | Out-Null

 	 # Disable New Tab Content
	 $RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\ServiceUI"
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	 New-ItemProperty -Path $RegistryKeyPath -Name AllowWebContentOnNewTabPage -PropertyType DWord -Value 0 -Force | Out-Null

	# Disable Address Bar Suggestions
	$RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\ServiceUI"
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	New-ItemProperty -Path $RegistryKeyPath -Name ShowOneBox -PropertyType DWord -Value 0 -Force | Out-Null

	# Disable Books Library Updates
	$RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\AllowConfigurationUpdateForBooksLibrary"
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	New-ItemProperty -Path $RegistryKeyPath -Name AllowConfigurationUpdateForBooksLibrary -PropertyType DWord -Value 0 -Force | Out-Null
 
	# Disable Books Library Updates
	$RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\AllowConfigurationUpdateForBooksLibrary"
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	New-ItemProperty -Path $RegistryKeyPath -Name AllowConfigurationUpdateForBooksLibrary -PropertyType DWord -Value 0 -Force | Out-Null
 
	# Enable DoNotTrack
	$RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main"
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	New-ItemProperty -Path $RegistryKeyPath -Name DoNotTrack -PropertyType DWord -Value 1 -Force | Out-Null

}
 Catch
 {
	 Write-Error "Could not write Edge registry keys. Exiting."
	 Write-Host $_.Exception | format-list -force
	Exit 1
 }

 Try 
 {
 	 # Disable OneDrive
	 $RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive"
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	 New-ItemProperty -Path $RegistryKeyPath -Name DisableFileSyncNGSC -PropertyType DWord -Value 1 -Force | Out-Null
 }
 Catch
 {
	 Write-Error "Could not write registry keys to disable onedrive. Exiting."
	 Write-Host $_.Exception | format-list -force
	Exit 1
 }

 Try 
 {
 	 # Disable Network Connection Stratus Indicator Testing
	 $RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\NetworkConnectivityStatusIndicator"
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	 New-ItemProperty -Path $RegistryKeyPath -Name NoActiveProbe -PropertyType DWord -Value 1 -Force | Out-Null
 }
 Catch
 {
	 Write-Error "Could not write network connection status indicator registry keys. Exiting."
	 Write-Host $_.Exception | format-list -force
	Exit 1
 }

 Try 
 {
 	 # Disable Windows Timeline
	 $RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	 New-ItemProperty -Path $RegistryKeyPath -Name EnableActivityFeed -PropertyType DWord -Value 0 -Force | Out-Null
	 New-ItemProperty -Path $RegistryKeyPath -Name PublishUserActivities -PropertyType DWord -Value 0 -Force | Out-Null
	 New-ItemProperty -Path $RegistryKeyPath -Name UploadUserActivities -PropertyType DWord -Value 0 -Force | Out-Null
 }
 Catch
 {
	 Write-Error "Could not write registry keys to disable windows timeline. Exiting."
	 Write-Host $_.Exception | format-list -force
	Exit 1
 }

 Try 
 {
 	 # Disable Advertising
	 $RegistryKeyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo"
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	 New-ItemProperty -Path $RegistryKeyPath -Name Enabled -PropertyType DWord -Value 0 -Force | Out-Null
	 New-ItemProperty -Path $RegistryKeyPath -Name DisabledByGroupPolicy -PropertyType DWord -Value 1 -Force | Out-Null
 }
 Catch
 {
	 Write-Error "Could not write registry keys to disable advertising. Exiting."
	 Write-Host $_.Exception | format-list -force
	Exit 1
 }

 Try 
 {
	# Privacy Settings
	# Disable language list fetching
	$RegistryKeyPath = "HKCU:\Control Panel\International\User Profile"
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	New-ItemProperty -Path $RegistryKeyPath -Name HttpAcceptLanguageOptOut -PropertyType Dword -Value 1 -Force | Out-Null

	# Disable tracking of process executions
	$RegistryKeyPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	New-ItemProperty -Path $RegistryKeyPath -Name Start_TrackProgs -PropertyType Dword -Value 0 -Force | Out-Null

	# Disable app location tracking
	$RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy"
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	New-ItemProperty -Path $RegistryKeyPath -Name LetAppsAccessLocation -PropertyType Dword -Value 2 -Force | Out-Null

	# Disable location sensors
	$RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors"
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	New-ItemProperty -Path $RegistryKeyPath -Name DisableLocation -PropertyType Dword -Value 1 -Force | Out-Null

	# Disable input learning
	$RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\InputPersonalization"
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	New-ItemProperty -Path $RegistryKeyPath -Name RestrictImplicitInkCollection -PropertyType Dword -Value 1 -Force | Out-Null

	# Disable privacy acceptance
	$RegistryKeyPath = "HKCU:\SOFTWARE\Microsoft\Personalization\Settings"
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	New-ItemProperty -Path $RegistryKeyPath -Name AcceptedPrivacyPolicy -PropertyType Dword -Value 0 -Force | Out-Null

	# Disable harvestcontacts
	$RegistryKeyPath = "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore"
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	New-ItemProperty -Path $RegistryKeyPath -Name HarvestContacts -PropertyType Dword -Value 0 -Force | Out-Null

	# Disable speech data updates
	$RegistryKeyPath = "HKLM:\SOFTWARE\Microsoft\Speech_OneCore\Preferences"
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	New-ItemProperty -Path $RegistryKeyPath -Name ModelDownloadAllowed -PropertyType Dword -Value 0 -Force | Out-Null

	# Disable language list fetching
	$RegistryKeyPath = "Registry::HKEY_USERS\.DEFAULT\Control Panel\International\User Profile"
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	New-ItemProperty -Path $RegistryKeyPath -Name HttpAcceptLanguageOptOut -PropertyType Dword -Value 1 -Force | Out-Null

	# Disable tracking of process executions
	$RegistryKeyPath = "Registry::HKEY_USERS\.DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	New-ItemProperty -Path $RegistryKeyPath -Name Start_TrackProgs -PropertyType Dword -Value 0 -Force | Out-Null
	
	# Disable privacy acceptance
	$RegistryKeyPath = "Registry::HKEY_USERS\.DEFAULT\SOFTWARE\Microsoft\Personalization\Settings"
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	New-ItemProperty -Path $RegistryKeyPath -Name AcceptedPrivacyPolicy -PropertyType Dword -Value 0 -Force | Out-Null

	# Disable harvestcontacts
	$RegistryKeyPath = "Registry::HKEY_USERS\.DEFAULT\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore"
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	New-ItemProperty -Path $RegistryKeyPath -Name HarvestContacts -PropertyType Dword -Value 0 -Force | Out-Null

	# Disable cipboard history
	$RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	New-ItemProperty -Path $RegistryKeyPath -Name AllowClipboardHistory -PropertyType Dword -Value 0 -Force | Out-Null

	# Disable shared devices
	$RegistryKeyPath = "HKLM:\Software\Policies\Microsoft\Windows\AppPrivacy"
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	New-ItemProperty -Path $RegistryKeyPath -Name LetAppsSyncWithDevices -PropertyType Dword -Value 2 -Force | Out-Null

	# Disable diagnostic access for apps
	$RegistryKeyPath = "HKLM:\Software\Policies\Microsoft\Windows\AppPrivacy"
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	New-ItemProperty -Path $RegistryKeyPath -Name LetAppsGetDiagnosticInfo -PropertyType Dword -Value 2 -Force | Out-Null
	
	# Disable CDP App Sharing
	$RegistryKeyPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\CDP"
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	New-ItemProperty -Path $RegistryKeyPath -Name CdpSessionUserAuthzPolicy -PropertyType Dword -Value 0 -Force | Out-Null
	New-ItemProperty -Path $RegistryKeyPath -Name NearShareChannelUserAuthzPolicy -PropertyType Dword -Value 0 -Force | Out-Null
	New-ItemProperty -Path $RegistryKeyPath -Name RomeSdkChannelUserAuthzPolicy -PropertyType Dword -Value 0 -Force | Out-Null
	
	# Disable CDP App Sharing
	$RegistryKeyPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\CDP\SettingsPage"
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	New-ItemProperty -Path $RegistryKeyPath -Name RomeSdkChannelUserAuthzPolicy -PropertyType Dword -Value 0 -Force | Out-Null

	# Disable CDP App Sharing
	$RegistryKeyPath = "Registry::HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\CDP"
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	New-ItemProperty -Path $RegistryKeyPath -Name CdpSessionUserAuthzPolicy -PropertyType Dword -Value 0 -Force | Out-Null
	New-ItemProperty -Path $RegistryKeyPath -Name NearShareChannelUserAuthzPolicy -PropertyType Dword -Value 0 -Force | Out-Null
	New-ItemProperty -Path $RegistryKeyPath -Name RomeSdkChannelUserAuthzPolicy -PropertyType Dword -Value 0 -Force | Out-Null
	
	# Disable CDP App Sharing
	$RegistryKeyPath = "Registry::HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\CDP\SettingsPage"
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	New-ItemProperty -Path $RegistryKeyPath -Name RomeSdkChannelUserAuthzPolicy -PropertyType Dword -Value 0 -Force | Out-Null

 }
 Catch
 {
	 Write-Error "Could not write registry keys for privacy. Exiting."
	 Write-Host $_.Exception | format-list -force
	Exit 1
 }