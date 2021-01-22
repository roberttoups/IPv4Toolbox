<#
.SYNOPSIS

  Converts sixty-four bit integer into an IPv4 address

.DESCRIPTION

  Converts sixty-four bit integer into an IPv4 address

.PARAMETER Integer

  Sixty-four bit integer representation of an IPv4 Address

.EXAMPLE

  ConvertTo-IPv4 -Integer 3232235777

  192.168.1.1

.LINK

  http://www.github.com/roberttoups/IPv4Toolbox

#>
function ConvertTo-IPv4 {
  [CmdletBinding()]
  [OutputType([String])]
  param (
    [Parameter(
      Mandatory = $true
    )]
    [Int64]
    $Integer
  )
  begin {}

  process {
    [Int32]$FirstOctet = ([System.Math]::Truncate($Integer / 16777216))
    [Int32]$SecondOctet = ([System.Math]::Truncate(($Integer % 16777216) / 65536))
    [Int32]$ThirdOctet = ([System.Math]::Truncate(($Integer % 65536) / 256))
    [Int32]$FourthOctet = ([System.Math]::Truncate($Integer % 256))
    "$($FirstOctet).$($SecondOctet).$($ThirdOctet).$($FourthOctet)"
  }

  end {}
}
