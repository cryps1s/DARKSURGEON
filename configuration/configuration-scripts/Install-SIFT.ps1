<#  
	.SYNOPSIS  
	Installs the SANS Investigative Forensic Toolkit (SIFT). 

	.DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT  

	Performs an installation of the SANS Investigative Forensic Toolkit (SIFT) inside the Ubuntu WSL installation. 

	.NOTES 
	https://github.com/sans-dfir/sift-cli

	Thanks to Mark Vincze for his script for downloading and parsing the latest release in a GitHub repository. 
	https://blog.markvincze.com/download-artifacts-from-a-latest-github-release-in-sh-and-powershell/
#>

Set-StrictMode -Version Latest

Try
{
	# Grab the latest release from the sift-cli repository, parse the tag
	$latestRelease = Invoke-WebRequest https://github.com/sans-dfir/sift-cli/releases/latest -Headers @{"Accept"="application/json"}
	$json = $latestRelease.Content | ConvertFrom-Json
	$latestVersion = $json.tag_name

	# Construct the appropriate URIs to download the binary and validation file from.
	$siftcli_binary_url = "https://github.com/sans-dfir/sift-cli/releases/download/$latestVersion/sift-cli-linux"
	$siftcli_binary_asc_url = "https://github.com/sans-dfir/sift-cli/releases/download/$latestVersion/sift-cli-linux.sha256.asc"

	# Download the files.
	Invoke-WebRequest -Uri $siftcli_binary_url -OutFile "$Env:SystemDrive\packer\sift-cli-linux"
	Invoke-WebRequest -Uri $siftcli_binary_asc_url -OutFile "$Env:SystemDrive\packer\sift-cli-linux.sha256.asc"
}
Catch
{
	Write-Error "Could not download SIFT binaries from Github. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1
}

Try
{
	# Check for GPG inside WSL.
	If (-not(Test-Path -Path $Env:localappdata\Lxss\rootfs\usr\bin\gpg)) 
	{
		& $Env:SystemDrive\Windows\system32\bash.exe -c 'apt-get install gpg -y'
	}
}
Catch
{
	Write-Error "Could not install GPG in WSL. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1
}

Try
{
	# Download the SIFT GPG Key
  & $Env:SystemDrive\Windows\system32\bash.exe -c 'gpg --keyserver pgp.mit.edu --recv-keys 22598A94'

	# Validate the file integrity of the ASC file.
  & $Env:SystemDrive\Windows\system32\bash.exe -c 'gpg --verify /mnt/c/packer/sift-cli-linux.sha256.asc || Exit 1'
}
Catch
{
	Write-Error "Error validating the package integrity for SIFT. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1
}

Try
{
	# Move the binary into the WSL volume.
  & $Env:SystemDrive\Windows\system32\bash.exe -c 'mv /mnt/c/packer/sift-cli-linux /usr/local/bin/sift'
}
Catch
{
	Write-Error "Could not move the sift-cli-linux file into the WSL filesystem. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1
}

Try
{
	# Install SIFT 
  Write-Host "Installing SIFT. This may take a while..."
  & $Env:SystemDrive\Windows\system32\bash.exe -c 'sudo /usr/local/bin/sift install --mode=packages-only --user=darksurgeon'
}
Catch
{
	Write-Error "Could not install SIFT packages. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1
}