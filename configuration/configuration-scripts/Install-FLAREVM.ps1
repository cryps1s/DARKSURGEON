  <#  
   .SYNOPSIS  
	Installs FlareVM 	

   .DESCRIPTION  
	Author: Dane Stuckey (@cryps1s)
	License: MIT

	Performs a standard installation of the most recent stable version of FlareVM.
	
   .NOTES 
    Based on FLAREVM Project - GitHub Project: https://github.com/fireeye/flare-vm 
 #>

 Set-StrictMode -Version Latest


 $GitBinary = "$Env:SystemDrive\Program Files\Git\cmd\git.exe"
 $ToolsFolder = "$Env:SystemDrive\Users\darksurgeon\tools"
 [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

 Try 
 { 
	# Clone the git repo
	& $GitBinary clone https://github.com/fireeye/flare-vm.git $ToolsFolder\git\FlareVM
 }
Catch 
 {
	Write-Host "Failed to clone the FlareVM repository from GitHub. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1 
 }

Try 
{
	# Add the FLARE repository for chocolatey.
	$flareFeed = "https://www.myget.org/F/flare/api/v2"
	Invoke-Expression -Command "choco sources add -n=flare -s $flareFeed --priority 1"
	# Add the FLARE repository for boxstarter. 
	Set-BoxstarterConfig -NugetSources "https://www.myget.org/F/flare/api/v2;https://chocolatey.org/api/v2"
	# Upgrade some packages.
	Invoke-Expression "choco upgrade -y vcredist-all.flare"
	Install-BoxstarterPackage -PackageName $ToolsFolder\git\FlareVM\flarevm.installer.flare 
}
Catch 
{
	Write-Host "Fatal erorr installing FlareVM. Exiting."	
	Write-Host $_.Exception | format-list -force
	Exit 1
}