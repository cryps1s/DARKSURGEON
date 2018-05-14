<#  
    .SYNOPSIS  
    Installs Windows Subsystem for Linux (WSL).

    .DESCRIPTION  
  	Author: Dane Stuckey (@cryps1s)
  	License: MIT

    Install the Windows Subsystem for Linux (WSL) binaries from Microsoft.

    .NOTES 
#>

Set-StrictMode -Version Latest

Try
{
  # Install the WSL package, preserve restart
  Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart | Out-Null
}
Catch
{
  Write-Error "Could not install WSL package. Exiting."
  Write-Host $_.Exception | format-list -force
  Exit 1
}