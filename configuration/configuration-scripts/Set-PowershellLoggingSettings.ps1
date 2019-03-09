<#  
	.SYNOPSIS  
	Configures powershell security logging.

	.DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT

	Enables powershell security logging for (a) module, (b) script-block, and (c) transcription. Outputs transcripts to $Env:SystemDrive\powershell-transcripts\. 

	.NOTES 
	Details on powershell security logging can be found here: https://blogs.msdn.microsoft.com/powershell/2015/06/09/powershell-the-blue-team/
 #>

 # The output location for powershell transcript logs
 $TranscriptLocation = "$Env:SystemDrive\powershell-transcripts\"

 # Set Powershell Transcription Logging
Try
{
	$RegistryKeyPath = "HKLM:\Software\Policies\Microsoft\Windows\PowerShell\Transcription"
	 # Create the registry key if it doesn't exist 
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	# Add registry value to enable scripting
	New-ItemProperty -Path $RegistryKeyPath -Name EnableTranscripting -PropertyType String -Value 1 -Force | Out-Null
	# Add registry value to enable the transcript output path
	New-ItemProperty -Path $RegistryKeyPath -Name OutputDirectory -PropertyType String -Value "$TranscriptLocation" -Force | Out-Null
	# Add registry value to enable the invocation header
	New-ItemProperty -Path $RegistryKeyPath -Name IncludeInvocationHeader -PropertyType String -Value 1 -Force | Out-Null
 }
 Catch
 {
	 Write-Error "Could not implement Powershell Transcription Logging. Exiting."
	 Write-Host $_.Exception | format-list -force; Write-Host $_.Exception | format-list -force
	Exit 1
 }

 # Set Powershell Module Logging
 Try
 {
	 $RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging"
	 # Create the registry key if it doesn't exist 
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	# Add registry value to enable module logging
	New-ItemProperty -Path $RegistryKeyPath -Name EnableModuleLogging -PropertyType DWORD -Value 1 -Force | Out-Null

	$RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging\ModuleNames"
	 # Create the registry key if it doesn't exist 
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	# Add registry value to enable logging of all modules
	New-ItemProperty -Path $RegistryKeyPath -Name * -PropertyType String -Value * -Force | Out-Null
 }
  Catch
 {
	 Write-Error "Could not implement Powershell Module Logging. Exiting."
	 Write-Host $_.Exception | format-list -force; Write-Host $_.Exception | format-list -force
	Exit 1
 }

 # Set Powershell Scriptblock Logging
 Try
 {
	$RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging"
	 # Create the registry key if it doesn't exist 
	If (-not(Test-Path -Path $RegistryKeyPath)) 
	{
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force | Out-Null
	}
	# Add registry value to enable script block logging
	New-ItemProperty -Path $RegistryKeyPath -Name EnableModuleLogging -PropertyType DWORD -Value 1 -Force | Out-Null
	# Add registry value to disable invocation headers
	New-ItemProperty -Path $RegistryKeyPath -Name EnableModuleLogging -PropertyType DWORD -Value 0 -Force | Out-Null
 }
Catch
{
	Write-Error "Could not implement Powershell Script Block logging. Exiting."
	Write-Host $_.Exception | format-list -force; Write-Host $_.Exception | format-list -force
	Exit 1
}