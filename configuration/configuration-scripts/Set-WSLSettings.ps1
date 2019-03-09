<#  
    .SYNOPSIS  
    Configures Windows Subsystem for Linux (WSL).

    .DESCRIPTION  
    Author: Dane Stuckey (@cryps1s)
    License: MIT

    Configures the WIndows Subsystem for Linux (WSL) to install Ubuntu and configure the root user.

    .NOTES 
#>

Set-StrictMode -Version Latest

Try
{
# Install Bash for WSL with user as root. No password.
  Start-Process -FilePath "$Env:SystemDrive\Windows\system32\LxRun.exe" -ArgumentList "/install /y" -NoNewWindow -wait
}
Catch
{
	Write-Error "Could not confiugre Bash for WSL. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1
}