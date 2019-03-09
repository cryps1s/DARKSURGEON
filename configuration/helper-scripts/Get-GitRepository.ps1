<#  
	.SYNOPSIS  
	Clones a remote git repository to a local directory.

	.DESCRIPTION
	Author: Dane Stuckey (@cryps1s)
	License: MIT  
	
	Clones a remote git respository to a local directory. 

	Includes error-handling and retries in the event of an intermittent issue.

	.NOTES 
	<3 to Jared Haight for making me a better powershell developer.
#>
  
Set-StrictMode -Version Latest
function Get-GitRepository {
	param(
		[String]$RepositoryURL,
		[String]$InstallDirectory,
		[Int]$RetryCounter = 0,
		[Int]$RetryMax = 3,
		[Int]$SleepCounter = 30
	)
	
	# Path to git binary
	$GitBinary = "$Env:SystemDrive\Program Files\Git\cmd\git.exe"

	# Enable TLS 1.2
	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

	If ($InstallDirectory -eq $null)
	{
		# If no directory is specified, use a default location
		$InstallDirectory = "$Env:SystemDrive\Users\darksurgeon\tools\git\"
	}

	Try
	{
		Do
		{
			
			# Try to clone repository
			$Process = Start-Process -FilePath "$GitBinary" -ArgumentList "clone","$RepositoryURL","$InstallDirectory" -NoNewWindow -PassThru -Wait 
			
			# If not a successful exit code, retry
			If ($Process.ExitCode -ne 0)
			{
				$RetryCounter += 1 
				Write-Host "[!] Failed to clone repository $RepositoryURL. Attempt $RetryCounter out of $RetryMax. Sleeping for $SleepCounter seconds before next retry."
				Start-Sleep -Seconds $SleepCounter
			}
		} Until (($Process.ExitCode -eq 0) -or ($RetryCounter -eq $RetryMax))
	
		If (($Process.ExitCode -ne 0))
		{
			Write-Host "[!] Failed to install $RepositoryURL after $RetryMax attempts. Throwing fatal error and exiting."
			Exit 1
		}
	}
	Catch
	{
		Write-Host "[!] Error occurred attempting to clone $RepositoryURL. Exiting."
		Write-Host $_.Exception | format-list -force
		Exit 1
	}
}