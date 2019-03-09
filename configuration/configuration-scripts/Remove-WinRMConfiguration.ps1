<#  
    .SYNOPSIS  
    Cleans up WinRM configuration.
    .DESCRIPTION  
    Author: Dane Stuckey (@cryps1s)
    License: MIT

    Removes insecure WinRM settings, disables the service, removes firewall rule, sets interface back to Public.  
    .NOTES 
    This script is designed to revert the Set-WinRMConfiguration.ps1 script configurations.
#>  

# Set the firewall to Public 
$InterfaceInfo = Get-NetConnectionProfile
Set-NetConnectionProfile -InterfaceIndex $InterfaceInfo.InterfaceIndex -NetworkCategory Public 

# Stop the WinRM Service.
Stop-Service WinRM
Set-Service WinRM -StartupType Disabled

# Remove WinRM Firewall Rule
Remove-NetFirewallRule -DisplayName "Allow WinRM Connectivity"

# Re-Configure WinRM Settings
winrm set "winrm/config/service" '@{AllowUnencrypted="false"}'
winrm set "winrm/config/service/auth" '@{Basic="false"}'
winrm set "winrm/config/client/auth" '@{Basic="false"}'