<#
.SYNOPSIS

  Determines if an IPv4 Address is in a private address space.

.DESCRIPTION

  Determines if an IPv4 Address is in a private address space.

.PARAMETER IPv4Address

  The IPv4 Address

.EXAMPLE

  Test-PrivateIPv4Address -IPv4Address 192.168.1.1

  True

.EXAMPLE

  Test-PrivateIPv4Address -IPv4Address 8.8.8.8

  False

.NOTES

  The function supports RFC 1918 & RFC 6598 address space.

.LINK

  http://www.github.com/roberttoups/IPv4Toolbox

#>
function Test-PrivateIPv4Address {
  [CmdletBinding()]
  param (
    [Parameter(
      Mandatory = $true,
      ValueFromPipeline = $true
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
    $PrivateAddressCollection = @()
    $PrivateAddressCollection += [PSCustomObject]@{
      Subnet = '10.0.0.0'
      Prefix = 8
    }
    $PrivateAddressCollection += [PSCustomObject]@{
      Subnet = '172.16.0.0'
      Prefix = 12
    }
    $PrivateAddressCollection += [PSCustomObject]@{
      Subnet = '192.168.0.0'
      Prefix = 16
    }
    $PrivateAddressCollection += [PSCustomObject]@{
      Subnet = '100.64.0.0'
      Prefix = 10
    }
    $Found = $false
    foreach($PrivateAddress in $PrivateAddressCollection) {
      $ArgumentCollection = @{
        IPv4Address = $PrivateAddress.Subnet
        Prefix      = $PrivateAddress.Prefix
      }
      $SubnetInformation = Get-SubnetInformation @ArgumentCollection
      $ArgumentCollection = @{
        FirstIPv4Address = $SubnetInformation.FirstIPv4Address
        LastIPv4Address  = $SubnetInformation.LastIPv4Address
        TestIPv4Address  = $IPv4Address
      }
      $Result = Test-IPv4AddressWithinRange @ArgumentCollection
      if($Result) {
        $Found = $true
        break
      }
    }
    $Found
  }

  end {}
}
