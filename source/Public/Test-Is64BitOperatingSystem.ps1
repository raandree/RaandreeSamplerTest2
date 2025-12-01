<#
.SYNOPSIS
Tests whether the operating system is 64-bit.

.DESCRIPTION
The Test-Is64BitOperatingSystem function checks if the current operating system is running in 64-bit mode.
It returns a boolean value indicating whether the OS is 64-bit (True) or 32-bit (False).

.EXAMPLE
Test-Is64BitOperatingSystem
Returns True if the OS is 64-bit, False if 32-bit.

.NOTES
Author: Raandree
#>
function Test-Is64BitOperatingSystem {
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param ()

    return [System.Environment]::Is64BitOperatingSystem
}
