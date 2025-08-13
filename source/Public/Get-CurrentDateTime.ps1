<#
.SYNOPSIS
Returns the current date and time.

.DESCRIPTION
The Get-CurrentDateTime function returns the current system date and time as a string in ISO 8601 format.

.EXAMPLE
Get-CurrentDateTime
Returns a string like: 2025-08-13T14:23:45

.NOTES
Author: Raandree
#>
function Get-CurrentDateTime {
    [CmdletBinding()]
    param ()
    return (Get-Date).ToString('yyyy-MM-ddTHH:mm:ss')
}
