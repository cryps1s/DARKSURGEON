<#  
	.SYNOPSIS  
	Removes Pre-Installed Applications.

	.DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT

	Removes Pre-Installed Applications.

	.NOTES 
	https://docs.microsoft.com/en-us/windows/configuration/manage-connections-from-windows-operating-system-components-to-microsoft-services
#>

Set-StrictMode -Version Latest

 Try
 {
	 # Remove all Apps not published by Microsoft. 
	 Get-AppxPackage | Where-Object -FilterScript {$_.Publisher -notlike "*Microsoft Corporation*"} | Remove-AppxPackage -ErrorAction SilentlyContinue | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue

	 # Remove Unnecessary Apps 
	 $AppBanStrings =@(
		 "Microsoft.Bing*",
		 "Microsoft.Xbox*",
		 "Microsoft.Zune*",
		 "Microsoft.Office*",
		 "Microsoft.Skype*",
		 "Microsoft.Wallet*",
		 "Microsoft.Weather*",
		 "Microsoft.3DBuilder*",
	     "Microsoft.WindowsMaps*",
	     "Microsoft.MicrosoftOfficeHub*",
		 "Microsoft.NetworkSpeedTest*",
		 "Microsoft.MicrosoftSolitaireCollection*",
	     "Microsoft.MicrosoftPowerBIForWindows*",
	     "Microsoft.Messaging*",
	     "Microsoft.People*",
	     "Microsoft.WindowsFeedbackHub*",
	     "Microsoft.Getstarted*",
	     "Microsoft.Windows.Photos*",
	     "Microsoft.Microsoft3DViewer*",
		 "Microsoft.WindowsAlarms*",
		 "Microsoft.Advertising*",
		 "Microsoft.Print3D*",
		 "Microsoft.FreshPaint*",
		 "Microsoft.RemoteDesktop*")

	 # Iterate through the apps with a banned string
	 Foreach ($AppString in $AppBanStrings)
	{
		# Remove the application
		Get-AppxPackage -Name $AppString | Remove-AppxPackage  -ErrorAction SilentlyContinue | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
	}
 }
 Catch
 {
	 Write-Error "Could not remove an application. Exiting."
	 Write-Host $_.Exception | format-list -force
	Exit 1
 }

 Try
 {
	 # Remove OneDrive
	 # Stop OneDrive processes
	 Stop-Process -Name "*OneDrive*" -Force | Out-Null

	 # Run the OneDrive Uninstaller 
	 Start-Process -FilePath "$Env:SystemDrive\Windows\SysWOW64\OneDriveSetup.exe" -ArgumentList "/uninstall"  -Wait -NoNewWindow

	 # Prevent OneDrive Sync via Registry
	 $RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive"
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	 New-ItemProperty -Path $RegistryKeyPath -Name DisableFileSyncNGSC -PropertyType DWord -Value 1 -Force | Out-Null
 }
 Catch
 {
	 Write-Error "Could not remove OneDrive. Exiting."
	 Write-Host $_.Exception | format-list -force
	Exit 1
 }