<#  
	.SYNOPSIS  
	Enables Data Execution Prevention (DEP).

	.DESCRIPTION  
	Author: Connor Edwards (@c-edw)
	License: MIT

	Enables the Window Data Execution Prevention (DEP) feature to prevent data pages being executed.
#>

# Switch to `cmd.exe`. For some reasons `bcdedit` doesn't function correctly in PowerShell.
cmd

# Set `No-Execute` flag to always be on.
bcdedit /set {current} nx AlwaysOn


