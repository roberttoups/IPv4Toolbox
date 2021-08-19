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
  [OutputType([Boolean])]
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
    $FirstOctet = $IPv4Address.Split('.')[0]
    if($FirstOctet -ne '192' -and
      $FirstOctet -ne '172' -and
      $FirstOctet -ne '100' -and
      $FirstOctet -ne '10'
    ) {
      Write-Verbose -Message 'IPv4 Address is not in a private address space'
      $false
    } else {
      $PrivateAddressCollection = DATA {
        # RFC 1918
        @{
          # 10.0.0.0/8
          FirstIPv4Address = '10.0.0.0'
          LastIPv4Address  = '10.255.255.255'
        }
        @{
          # 172.16.0.0/12
          FirstIPv4Address = '172.16.0.0'
          LastIPv4Address  = '172.31.255.255'
        }
        @{
          # 192.168.0.0/16
          FirstIPv4Address = '192.168.0.0'
          LastIPv4Address  = '192.168.255.255'
        }
        # RFC 6598
        @{
          # 100.64.0.0/10
          FirstIPv4Address = '100.64.0.0'
          LastIPv4Address  = '100.127.255.255'
        }
      }
      $Found = $false
      foreach($PrivateAddress in $PrivateAddressCollection) {
        Write-Verbose -Message "Checking if $IPv4Address is between $($PrivateAddress.FirstIPv4Address) and $($PrivateAddress.LastIPv4Address)"
        if($PrivateAddress.FirstIPv4Address.Split('.')[0] -ne $FirstOctet) {
          continue
        }
        $ArgumentCollection = @{
          FirstIPv4Address = $PrivateAddress.FirstIPv4Address
          LastIPv4Address  = $PrivateAddress.LastIPv4Address
          TestIPv4Address  = $IPv4Address
        }
        $Result = Test-IPv4AddressWithinRange @ArgumentCollection
        if($Result) {
          Write-Verbose -Message 'IPv4 Address is in a private address space'
          $Found = $true
          break
        }
      }
      $Found
    }
  }

  end {}
}
