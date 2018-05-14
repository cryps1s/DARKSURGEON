<#  
	.SYNOPSIS  
	Configures initial power settings.

	.DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT

	Set computer to never sleep/hibernate, disable screen saver, disable hibernation 

	.NOTES 
	Script code from Jeremiah Peschka (https://facility9.com/2015/07/controlling-the-windows-power-plan-with-powershell/)    
 #>

Try
{
	# Look for high performance power plan
	$HighPerf = powercfg -l | %{if($_.contains("High performance")) {$_.split()[3]}}
	# Get current power plan
	$CurrPlan = $(powercfg -getactivescheme).split()[3]
	# Enable high performance plan if it's not already enabled
	If ($CurrPlan -ne $HighPerf) 
	{
		powercfg -setactive $HighPerf
	}
	# Disable all the idle timeouts
	powercfg.exe -x -monitor-timeout-ac 0
	powercfg.exe -x -monitor-timeout-dc 0
	powercfg.exe -x -disk-timeout-ac 0
	powercfg.exe -x -disk-timeout-dc 0
	powercfg.exe -x -standby-timeout-ac 0
	powercfg.exe -x -standby-timeout-dc 0
	powercfg.exe -x -hibernate-timeout-ac 0
	powercfg.exe -x -hibernate-timeout-dc 0

	# Disable Hibernation File
	Set-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Control\Power\ -name HiberFileSizePercent -value 0
	Set-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Control\Power\ -name HibernateEnabled -value 0
}

Catch
{
	Write-Error "Could not implement high performance power settings. Exiting."
	Write-Host $_.Exception | format-list -force; Write-Host $_.Exception | format-list -force
	Exit 1
}