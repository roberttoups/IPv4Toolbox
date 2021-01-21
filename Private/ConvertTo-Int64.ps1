<#
.SYNOPSIS

  Converts an IPv4 address into a sixty-four bit integer.

.DESCRIPTION

  Converts an IPv4 address into a sixty-four bit integer.

.PARAMETER IPv4Address

  IPv4 Address in with four octets.

.EXAMPLE

  ConvertTo-Int64 -IPv4Address "192.168.1.1"

  3232235777

.LINK

  http://www.github.com/roberttoups/IPv4Toolbox

#>
function ConvertTo-Int64 {
  [CmdletBinding()]
  [OutputType([Int64])]
  param (
    [Parameter(
      Mandatory = $true
    )]
    [Alias('IPAddress')]
    [ValidatePattern(
      '^(?:(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\.){3}(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])$'
    )]
    [String]
    $IPv4Address
  )
  begin {}

  process {
    $Octets = $IPv4Address.Split('.')
    [Int64]([Int64]$Octets[0] * 16777216 + [Int64]$Octets[1] * 65536 + [Int64]$Octets[2] * 256 + [Int64]$Octets[3])
  }

  end {}
}
