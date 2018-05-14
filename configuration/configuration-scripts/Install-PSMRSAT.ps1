<#  
	.SYNOPSIS  
	Installs RSAT from the Internet via a custom script.

	.DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT  

	Downloads Windows 10 Threshold RSAT via powershell, validates file signature, installs.

	.NOTES
	Code forked from Drew Robinson (https://blogs.technet.microsoft.com/drew/2016/12/23/installing-remote-server-admin-tools-rsat-via-powershell/)
#>

# Disables IE First Run 
Try
{
	 $RegistryKeyPath = "HKLM:\Software\Policies\Microsoft\Internet Explorer\Main"
	 If (-not(Test-Path -Path $RegistryKeyPath)) 
	 {
		 New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	 }
	 # Add registry value
	 New-ItemProperty -Path $RegistryKeyPath -Name DisableFirstRunCustomize -PropertyType DWord -Value 1 -Force | Out-Null

}
Catch
{
	Write-Error "Could not add the "Disable First Run Customize" registry key. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1 
}

Try
{

	$web = Invoke-WebRequest https://www.microsoft.com/en-us/download/confirmation.aspx?id=45520
	$MachineOS= (Get-WmiObject Win32_OperatingSystem).Name
    $Link=(($web.AllElements |where class -eq "multifile-failover-url").innerhtml[0].split(" ")|select-string href).tostring().replace("href=","").trim('"')
	$DLPath= ($ENV:USERPROFILE) + "\Downloads\" + ($link.split("/")[8])
	Write-Host "Downloading RSAT MSU file" -foregroundcolor yellow
	Start-BitsTransfer -Source $Link -Destination $DLPath
	$Authenticatefile=Get-AuthenticodeSignature $DLPath
	$WusaArguments = $DLPath + " /quiet"
	if($Authenticatefile.status -ne "valid") {write-host "Can't confirm download, exiting";break}
	Write-host "Installing RSAT for Windows 10 - please wait" -foregroundcolor yellow
	Start-Process -FilePath "$Env:SystemDrive\Windows\System32\wusa.exe" -ArgumentList $WusaArguments -Wait
}
Catch
{
	Write-Error "Could not download the RSAT x64 file from Microsoft. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1 
}