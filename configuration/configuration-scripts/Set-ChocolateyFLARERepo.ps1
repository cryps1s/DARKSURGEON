<#  
   	.SYNOPSIS  
	Adds the FLAREVM Chocolatey Repository. 
	
	.DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT

    Adds the FLAREVM Chocolatey Repository, which contains nuget packages related to malware analysis. 
   
	.NOTES 
	Based on FLAREVM Project - GitHub Project: https://github.com/fireeye/flare-vm 
	FLARE Chocolately Repository: https://www.myget.org/F/flare/api/v2
 #>

 Set-StrictMode -Version Latest

Try
{
	# Add the FLAREVM nuget repository as a source.
	choco sources add -n=flare -s "https://www.myget.org/F/flare/api/v2" --priority 1
}

Catch
{
	Write-Error "Could not add the FLAREVM chocolatey repository. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1
}