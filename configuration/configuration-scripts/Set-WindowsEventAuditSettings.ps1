<#  
	.SYNOPSIS  
	Configures Windows Audit Settings.

	.DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT

	Configures Windows Audit Settings based on Palantir windows event forwarding guidance. 

	.NOTES 
	https://github.com/palantir/windows-event-forwarding
 #>

# Enable Audit Settings
Try
{
	# Set Security Log to 1GB 
	wevtutil set-log "Security" /maxsize:1073742000
	
	# Set Application Log to 1GB 
	wevtutil set-log "Application" /maxsize:1073742000
	
	# Set System Log to 1GB 
	wevtutil set-log "System" /maxsize:1073742000

	# Set Powershell Log to 1GB
	wevtutil set-log "Windows PowerShell" /maxsize:1073742000

	# Set Powershell Operational Log to 100MB
	wevtutil set-log "Microsoft-Windows-PowerShell/Operational" /maxsize:104857600

	# Set Bits-Client Log to 100MB
	wevtutil set-log "Microsoft-Windows-Bits-Client/Operational" /maxsize:104857600

	# Set Code Integrity Log to 100MB 
	wevtutil set-log "Microsoft-Windows-CodeIntegrity/Operational" /maxsize:104857600
	
	# Set Device Guard Log to 100MB
	wevtutil set-log "Microsoft-Windows-DeviceGuard/Operational" /maxsize:104857600

	# Set Windows AppLocker (EXE/DLL) Log to 100MB
	wevtutil set-log "Microsoft-Windows-AppLocker/EXE and DLL" /maxsize:104857600

	# Set Windows AppLocker (MSI/Script) Log to 100MB
	wevtutil set-log "Microsoft-Windows-AppLocker/MSI and Script" /maxsize:104857600

	# Configure System Audit Settings
	auditpol /set /subcategory:"Security System Extension","System Integrity","Other System Events","Security State Change" /failure:enable /success:enable     

	# Configure Logon/Logoff Settings
	auditpol /set /subcategory:"Logon","Logoff","Special Logon","Other Logon/Logoff Events","User / Device Claims","Group Membership" /failure:enable /success:enable   

	# Configure Object Access
	auditpol /set /subcategory:"File System","Registry","File Share","Other Object Access Events","Detailed File Share","Removable Storage" /failure:enable /success:enable   

	# Configure Privilege Use 
	auditpol /set /subcategory:"Non Sensitive Privilege Use" /failure:enable
	auditpol /set /subcategory:"Other Privilege Use Events","Sensitive Privilege Use" /failure:enable /success:enable

	# Configure Detailed Tracking
	auditpol /set /subcategory:"Process Creation","DPAPI Activity","Plug and Play Events" /failure:enable /success:enable

	# Configure Policy Change
	auditpol /set /subcategory:"Audit Policy Change","Authentication Policy Change","MPSSVC Rule-Level Policy Change","Other Policy Change Events" /failure:enable /success:enable

	# Enable Advanced Audit Policies (Forced)
	Set-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Control\Lsa -Name "SCENoApplyLegacyAuditPolicy" -Value 1 -Type DWord

	# Enable Command Line Auditing
	Set-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System\Audit -Name ProcessCreationIncludeCmdLine_Enabled -Value 1 -Type DWord
}

Catch
{
	Write-Error "Could not implement an auditing setting. Exiting."
	Write-Host $_.Exception | format-list -force;
	Exit 1
}