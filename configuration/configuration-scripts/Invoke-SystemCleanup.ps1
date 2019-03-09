  <#  
    .SYNOPSIS  
    Performs cleanup of aesthetic artifacts on the system.

    .DESCRIPTION  
    Author: Dane Stuckey (@cryps1s)
    License: MIT
    
    Performs cleanup of aesthetic artifacts on the system. Specifically, the following is performed: 
    - The SysprepAutounattend.xml file is written to disk for post-packer configuration.
    - User icons on the desktop are removed.
    - Icons in the start menu are removed.
    - Startup entries for applications are removed.
    - Removes scheduled tasks for application/office updates.
    - Non-critical services are disabled.

   .NOTES 

 #>
 Set-StrictMode -Version Latest

# Write Unattend.xml file to disk.
 Try
 {
    Write-Host "Setting up unattended.xml for next boot."
    Copy-Item -Path 'E:\Post-Autounattend.xml' -Destination "$Env:SystemDrive\Windows\system32\unattended.xml" -Force 
 }
 Catch
 {
	  Write-Error "Could not write unattended.xml to disk. Exiting."
    Write-Host $_.Exception | format-list -force
    Exit 1
 }

 # Remove icon files from the desktop.
 Try
 {
    Write-Host "Cleaning up icon files."
    Remove-Item "$Env:SystemDrive\Users\darksurgeon\Desktop\*" -Force -Recurse
    Remove-Item "$Env:SystemDrive\Users\Public\Desktop\*" -Force -Recurse 
 }
 Catch
 {
	  Write-Error "Could not delete desktop icon files s part of the cleanup script. Exiting."
	  Write-Host $_.Exception | format-list -force
	  Exit 1
 }

 # Remove Run Key Persistence
 Try
 {
    Write-Host "Cleaning up registry keys."
    Remove-ItemProperty 'HKLM:\SOFTWARE\Wow6432node\Microsoft\Windows\CurrentVersion\Run' -Name * -Force
    Remove-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name * -Force 
    Remove-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run' -Name * -Force
 }
 Catch
 {
	  Write-Error "Could not remove run keys as part of the cleanup script. Exiting."
	  Write-Host $_.Exception | format-list -force
	  Exit 1
 } 

# Turn off some unused services
 Try
 {
    Write-Host "Disabling unused services."
    #Disable WMP Network Service
    Stop-Service -Name WMPNetworkSvc -Force 
    Set-Service -Name WMPNetworkSvc -StartupType Disabled 

    #Disable Office OSE service
    Stop-Service -Name ose -Force 
    Set-Service -Name ose -StartupType Disabled    

    #Disable IpOverUsbSvc service
    Stop-Service -Name IpOverUsbSvc -Force 
    Set-Service -Name IpOverUsbSvc -StartupType Disabled    

    #Disable Te.Service service
    Stop-Service -Name 'Te.Service' -Force
    Set-Service -Name 'Te.Service' -StartupType Disabled    
 }
 Catch
 {
    Write-Error "Could not disable services as part of the cleanup script. Exiting."
    Write-Host $_.Exception | format-list -force
    Exit 1
 } 
# Delete Packer Directory
Try
{
  Remove-Item -Path "$Env:SystemDrive\packer\" -Recurse -Force | Out-Null
}
Catch
{
   Write-Error "Could not clean up packer folder. Exiting."
   Write-Host $_.Exception | format-list -force
   Exit 1
}