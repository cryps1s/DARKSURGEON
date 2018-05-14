  <#  
   .SYNOPSIS  
    Configures WinRM settings for the initial bake.

   .DESCRIPTION  
  	Author: Dane Stuckey (@cryps1s)
	  License: MIT

    Configures WinRM with insecure settings, forces the firewall to the "private" policy, starts the WinRM service.  
   
    .NOTES 
    Most of these changes are reverted at the end of the Vagrant bake by the Remove-WinRMConfiguration.ps1 script.
 #>  
  
# Supress network location Prompt
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Network\NewNetworkWindowOff" -Force | Out-Null

# Enables WinRM with default settings. Using HTTP transfer protocol on default port. 
winrm quickconfig -q

# Enabling firewall exceptions for WinRM.
New-NetFirewallRule -DisplayName "Packer-Allow-WinRM-5985-TCP" -Direction Inbound  -LocalPort 5985 -Protocol TCP -Action Allow

# Start WinRM Service
Start-Service WinRM
Set-Service WinRM -StartupType Automatic

# Set the firewall to Private 
$InterfaceInfo = Get-NetConnectionProfile
Set-NetConnectionProfile -InterfaceIndex $InterfaceInfo.InterfaceIndex -NetworkCategory Private 

# Modifying WinRM configuration with optimal Vagrant settings.
winrm set winrm/config '@{MaxTimeoutms="1800000"}'
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="2048"}'
winrm set winrm/config/winrs '@{MaxShellsPerUser="30"}'
winrm set winrm/config/winrs '@{MaxProcessesPerShell="25"}'

# Turning on horribly insecure (but very convenient) authentication settings.
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/client/auth '@{Basic="true"}'

# Make Packer Folder for Configuration
New-Item $Env:SystemDrive\packer -ItemType Directory -Force | Out-Null