<#
.SYNOPSIS

  Evaluates if an IPv4 Address is equal or within an IPv4 Address range.

.DESCRIPTION

  Evaluates if an IPv4 Address is equal or within an IPv4 Address range.

.PARAMETER FirstIPv4Address

  The first IPv4 Address

.PARAMETER LastIPv4Address

  The last IPv4 Address

.PARAMETER TestIPv4Address

  The IPv4 Address to test

.EXAMPLE

  Test-IPv4AddressWithinRange -FirstIPv4Address '192.168.1.1' -LastIPv4Address '192.168.5.21' -TestIPv4Address '192.168.6.1'

  False

 .EXAMPLE

  Test-IPv4AddressWithinRange -FirstIPv4Address '192.168.1.1' -LastIPv4Address '192.168.1.50' -TestIPv4Address '192.168.1.20'

  True

.LINK

  http://www.github.com/roberttoups/IPv4Toolbox

#>
function Test-IPv4AddressWithinRange {
  [CmdletBinding()]
  [OutputType([Boolean])]
  param (
    [Parameter(
      Mandatory = $true
    )]
    [Alias('StartingIpAddress')]
    [ValidatePattern('^(?:(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\.){3}(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])$')]
    [String]
    $FirstIPv4Address,

    [Parameter(
      Mandatory = $true
    )]
    [Alias('EndingIpAddress')]
    [ValidatePattern('^(?:(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\.){3}(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])$')]
    [String]
    $LastIPv4Address,

    [Parameter(
      Mandatory = $true
    )]
    [Alias('TestingIpAddress')]
    [ValidatePattern('^(?:(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\.){3}(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])$')]
    [String]
    $TestIPv4Address
  )
  begin {

  }
  process {
    Write-Verbose -Message "FirstIPv4Address: $FirstIPv4Address"
    $FirstInt64 = ConvertTo-Int64 -IPv4Address $FirstIPv4Address
    Write-Verbose -Message "      FirstInt64: $FirstInt64"
    Write-Verbose -Message " LastIPv4Address: $LastIPv4Address"
    $LastInt64 = ConvertTo-Int64 -IPv4Address $LastIPv4Address
    Write-Verbose -Message "       LastInt64: $LastInt64"
    $TestInt64 = ConvertTo-Int64 -IPv4Address $TestIPv4Address
    Write-Verbose -Message "       TestInt64: $TestInt64"
    if($FirstInt64 -le $TestInt64 -and $LastInt64 -ge $TestInt64) {
      Write-Verbose -Message "TestIPv4Address is within FirstIPv4Address and LastIPv4Address"
      $true
    } else {
      Write-Verbose -Message "TestIPv4Address is not within FirstIPv4Address and LastIPv4Address"
      $false
    }
  }
  end {

  }
}
