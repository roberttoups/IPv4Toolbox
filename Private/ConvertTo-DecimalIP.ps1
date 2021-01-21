<#
.SYNOPSIS

  Converts an IPv4 address object into a decimal representation of an IPv4 Address.

.DESCRIPTION

  Converts an IPv4 address object into a decimal representation of an IPv4 Address.

.PARAMETER IPAddressObject

  IPv4 Address as System.Net.IPAddress object type.

.EXAMPLE

  ConvertTo-DecimalIP -IPAddressObject [System.Net.IPAddress]::Parse("192.168.1.1")

  3232235777

.LINK

  http://www.github.com/roberttoups/IPv4Toolbox

#>
function ConvertTo-DecimalIP {
  [CmdletBinding()]
  [OutputType([UInt32])]
  param (
    [Parameter(
      Mandatory = $true
    )]
    [System.Net.IPAddress]
    $IPAddressObject
  )

  begin {}

  process {
    $Position = 3
    $DecimalIp = 0
    $IPAddressObject.GetAddressBytes() |
      ForEach-Object { $DecimalIp += $_ * [System.Math]::Pow(256, $Position); $Position-- }
    [UInt32]$DecimalIp
  }

  end {}
}
