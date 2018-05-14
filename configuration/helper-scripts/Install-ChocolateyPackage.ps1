<#  
	.SYNOPSIS  
	Installs a chocolatey package with error handling and retries.

	.DESCRIPTION
	Author: Dane Stuckey (@cryps1s)
	License: MIT  
	
	Performs a standard chocolatey installation of the most recent stable version from configured repositories. 

	Includes error-handling and retries in the event of an intermittent issue.

	.NOTES 
	<3 to Jared Haight for making me a better powershell developer.
#>
  
Set-StrictMode -Version Latest
function Install-ChocolateyPackage {
	param(
		[String]$PackageName,
		[Parameter(Mandatory=$false)]
		[Array]$OptionalArguments, 
		[Int]$RetryCounter = 0,
		[Int]$RetryMax = 3,
		[Int]$SleepCounter = 30
	)

	Try
	{
		Do
		{
			If ($OptionalArguments -ne $null)
			{
				# Try to Install Package with optional arguments
				$Process = Start-Process -FilePath "choco.exe" -ArgumentList "install","$PackageName","--limit-output","$OptionalArguments" -NoNewWindow -PassThru -Wait 
			}
			else 
			{
				# Try to Install Package without optional arguments
				$Process = Start-Process -FilePath "choco.exe" -ArgumentList "install","$PackageName","--limit-output" -NoNewWindow -PassThru -Wait 

			}
			
			# If not a successful exit code, retry
			If ($Process.ExitCode -ne 0)
			{
				$RetryCounter += 1 
				Write-Host "[!] Failed to install package $PackageName. Attempt $RetryCounter out of $RetryMax. Sleeping for $SleepCounter seconds before next retry."
				Start-Sleep -Seconds $SleepCounter
			}
		} Until (($Process.ExitCode -eq 0) -or ($RetryCounter -eq $RetryMax))
	
		If (($Process.ExitCode -ne 0))
		{
			Write-Host "[!] Failed to install $PackageName after $RetryMax attempts. Throwing fatal error and exiting."
			Exit 1
		}
	}
	Catch
	{
		Write-Host "[!] Error occurred attempting to install $PackageName. Exiting."
		Write-Host $_.Exception | format-list -force
		Exit 1
	}
}