<#  
  .SYNOPSIS  
  Performs update and package upgrades on the WSL environment.

  .DESCRIPTION  
  Author: Dane Stuckey (@cryps1s)
  License: MIT
  
  Performs update and package upgrades on the WSL environment.

  .NOTES 

#>
Set-StrictMode -Version Latest

Try
{
  # Perform apt-get update
  & $Env:SystemDrive\Windows\system32\bash.exe -c 'apt-get update -m'
}
Catch
{
	Write-Host "[!] Error occurred while attempting to perform apt-get update within the WSL environment. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1
}

Try
{
  # Perform apt-get upgrade and suppress prompts
  & $Env:SystemDrive\Windows\system32\bash.exe -c "DEBIAN_FRONTEND='noninteractive' apt-get -y -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' upgrade"
}
Catch
{
	Write-Host "[!] Error occurred while attempting to perform apt-get upgrade -y within the WSL environment. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1
}

Try
{
  # Perform apt-get dist-upgrade
  & $Env:SystemDrive\Windows\system32\bash.exe -c "DEBIAN_FRONTEND='noninteractive' apt-get -y -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' dist-upgrade"
}
Catch
{
	Write-Host "[!] Error occurred while attempting to perform apt-get dist-upgrade -y within the WSL environment. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1
}

Try
{
  # Perform apt-get cleanup
  & $Env:SystemDrive\Windows\system32\bash.exe -c 'apt-get -y autoremove'
  & $Env:SystemDrive\Windows\system32\bash.exe -c 'apt-get -y clean'
  & $Env:SystemDrive\Windows\system32\bash.exe -c 'apt-get -y autoclean'
}
Catch
{
	Write-Host "[!] Error occurred while attempting to perform apt-get cleanup within the WSL environment. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1
}