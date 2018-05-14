<#  
    .SYNOPSIS  
    Creates a breakpoint in the packer build process.

    .DESCRIPTION  
    Author: Dane Stuckey (@cryps1s)
    License: MIT

    Creates a breakpoint in the packer build process. This will break the packer build process, but is useful for debugging.

    .NOTES 
#>

# Sleeps for 4 hours. This should be enough time to cause packer to artificially end it's build process.
Start-Sleep -Seconds 14400