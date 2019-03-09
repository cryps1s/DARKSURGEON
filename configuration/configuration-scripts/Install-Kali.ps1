<#  
		.SYNOPSIS  
		Installs the Kali apt repositories. 

		.DESCRIPTION  
		Author: Dane Stuckey (@cryps1s)
		License: MIT  

		Installs the Kali apt repositories inside the Ubuntu WSL installation. 

		.NOTES 
#>

Set-StrictMode -Version Latest

Try
{
	# Download the Kali GPG Key
  & $Env:SystemDrive\Windows\system32\bash.exe -c 'apt-key adv --keyserver pgp.mit.edu --recv-keys ED444FF07D8D0BF6'
}
Catch
{
	Write-Error "Error downloading the Kali GPG key. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1
}

Try
{
	# Add the Kali Repositories to /etc/apt/sources.list
  & $Env:SystemDrive\Windows\system32\bash.exe -c "echo 'deb http://http.kali.org/kali kali-rolling main contrib non-free' >> /etc/apt/sources.list"
  & $Env:SystemDrive\Windows\system32\bash.exe -c "echo 'deb-src http://http.kali.org/kali kali-rolling main contrib non-free' >> /etc/apt/sources.list"

}
Catch
{
	Write-Error "Could not add kali repositories to WSL apt/sources.list file. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1
}

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