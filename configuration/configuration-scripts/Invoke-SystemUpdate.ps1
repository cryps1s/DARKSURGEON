  <#  
   .SYNOPSIS  
    Performs installation of Windows Updates.

   .DESCRIPTION  
    Author: Dane Stuckey (@cryps1s)
	  License: MIT
    
    Performs installation of Windows updates via BoxStarter.

   .NOTES 

 #>
Set-StrictMode -Version Latest

Try
{
		Install-WindowsUpdate -getUpdatesFromMS -acceptEula -SuppressReboots
}
Catch
{
	Write-Host "[!] Error occurred while attempting to perform installation of Windows Updates. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1
}