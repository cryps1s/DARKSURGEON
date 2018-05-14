<#  
	.SYNOPSIS  
	Installs Sysmon from the Microsoft site using a custom script. 

	.DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT  

	Performs a custom installation of the most recent stable version of Sysmon. 

	.NOTES 
#>

# Installs Sysmon -- this URL could change and may need to be updated.
$SysmonURL = "https://download.sysinternals.com/files/Sysmon.zip"
$SysmonFolder = "$Env:SystemDrive\packer\Sysmon\"
$DestinationFile = "$Env:SystemDrive\packer\Sysmon\Sysmon.zip"
$SysmonBinary = "$SysmonFolder\Sysmon64.exe"

# Make Sysmon Folder
Try
{
	New-Item $SysmonFolder -ItemType Directory -Force | Out-Null
}
Catch
{
	Write-Error "Could not create sysmon folder. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1

}

# Download Sysmon from Microsoft's site.
Try 
{
	Invoke-WebRequest -Uri $SysmonURL -OutFile $DestinationFile
}
Catch
{
	Write-Error "Could not download Sysmon from Microsoft. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1
}

# Unzip Sysmon ZIP file.
Try
{
	Expand-Archive $DestinationFile -DestinationPath $SysmonFolder -Force
}
Catch
{
	Write-Error "Could not unzip Sysmon zip file. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1
}

# Validate Sysmon Binary Integrity
Try
{
	# Validates file signature using authenticode
	$Authenticatefile=Get-AuthenticodeSignature $SysmonBinary
	If ($Authenticatefile.status -ne "valid") 
	{
		Write-Error "Could not validate the file integrity for the Sysmon64 binary. Exiting."
		Write-Host $_.Exception | format-list -force
	Exit 1 
	}
}
Catch
{
		Write-Error "Could not validate the file integrity for the Sysmon64 binary. Exiting."
		Write-Host $_.Exception | format-list -force
	Exit 1 
}

# Installs Sysmon binary and driver.
Try
{
	Start-Process -FilePath $SysmonBinary -ArgumentList "-accepteula","-i" -NoNewWindow -Wait
}
Catch
{
	Write-Error "Could not install the Sysmon binary and driver. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1
}