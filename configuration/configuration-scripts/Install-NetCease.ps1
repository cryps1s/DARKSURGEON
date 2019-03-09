<#  
	.SYNOPSIS  
	Installs NetCease from the Microsoft site using a custom script. 

	.DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT  

	Performs a custom installation of the most recent stable version of NetCease. 
	.NOTES 
#>

# Installs NetCease -- this URL could change and may need to be updated.
$NetCeaseURL = "https://gallery.technet.microsoft.com/Net-Cease-Blocking-Net-1e8dcb5b/file/165596/1/NetCease.zip"
$DestinationFile = "$Env:SystemDrive\packer\NetCease.zip"
$NetCeaseFolder = "$Env:SystemDrive\packer\NetCease\"
$NetCeaseScript = "$NetCeaseFolder\NetCease.ps1"

# Make NetCrase Folder
Try
{
	New-Item $NetCeaseFolder -ItemType Directory -Force | Out-Null
}
Catch
{
	Write-Error "Could not create netcease folder. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1

}

# Download NetCease from Microsoft's site.
Try 
{
	Invoke-WebRequest -Uri $NetCeaseURL -OutFile $DestinationFile
}
Catch
{
	Write-Error "Could not download NetCease from Microsoft. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1
}

# Unzip NetCease ZIP file.
Try
{
	Expand-Archive $DestinationFile -DestinationPath $NetCeaseFolder -Force
}
Catch
{
	Write-Error "Could not unzip NetCease zip file. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1
}

# Execute NetCease.
Try
{
	Start-Process -FilePath $Env:SystemDrive\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ArgumentList "-File $NetCeaseScript","-NoProfile" -NoNewWindow -Wait
}
Catch
{
	Write-Error "Could not install netcease. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1
}