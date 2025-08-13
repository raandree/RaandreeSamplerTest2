<#
.SYNOPSIS
Returns a string describing the current operating system version, platform, and service pack.

.DESCRIPTION
The Get-OsVersionString function retrieves the OS version information from the .NET System.Environment class and formats it as a string.

.EXAMPLE
Get-OsVersionString
Returns a string like:
Version: 10.0.19045.0, Platform: Win32NT, Service Pack:

.NOTES
Author: Raandree
#>
function Get-OsVersionString
{
    $osVersion = [System.Environment]::OSVersion
    return "Version: $($osVersion.Version), Platform: $($osVersion.Platform), Service Pack: $($osVersion.ServicePack)"
}