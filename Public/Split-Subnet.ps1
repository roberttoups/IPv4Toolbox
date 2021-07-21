<#
.SYNOPSIS

  Breaks up a larger CIDR into small CIDRs.

.DESCRIPTION

  Breaks up a larger CIDR into small CIDRs.

.PARAMETER Subnet

  The Subnet Id to split

.PARAMETER Prefix

  The network prefix of the source CIDR

.PARAMETER TargetPrefix

  The network prefix to split the subnet into

.EXAMPLE

  Split-Subnet -Subnet 10.2.2.0 -Prefix 24 -TargetPrefix 25

  SubnetId            : 10.2.2.0
  BroadcastAddress    : 10.2.2.127
  SubnetMask          : 255.255.255.128
  Prefix              : 25
  Subnet              : 10.2.2.0/25
  FirstIPv4Address    : 10.2.2.1
  LastIPv4Address     : 10.2.2.126
  TotalHosts          : 126
  AWSFirstIPv4Address : 10.2.2.4
  AWSTotalHosts       : 123

  SubnetId            : 10.2.2.128
  BroadcastAddress    : 10.2.2.255
  SubnetMask          : 255.255.255.128
  Prefix              : 25
  Subnet              : 10.2.2.128/25
  FirstIPv4Address    : 10.2.2.129
  LastIPv4Address     : 10.2.2.254
  TotalHosts          : 126
  AWSFirstIPv4Address : 10.2.2.132
  AWSTotalHosts       : 123

.LINK

  http://www.github.com/roberttoups/IPv4Toolbox

#>
function Split-Subnet {
  [CmdletBinding()]
  param (
    [Parameter(
      Mandatory = $true
    )]
    [Alias('IPAddress', 'IPv4Address')]
    [ValidatePattern(
      '^(?:(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\.){3}(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])$'
    )]
    [String]
    $Subnet,

    [Parameter(
      Mandatory = $true
    )]
    [ValidateRange(8 , 30)]
    [Int32]
    $Prefix,

    [Parameter(
      Mandatory = $true
    )]
    [ValidateRange(8 , 30)]
    [Int32]
    $TargetPrefix
  )

  begin {

  }

  process {
    if($TargetPrefix -lt $Prefix) {
      Write-Error -Message "The source -Prefix ($Prefix) must be larger than the -TargetPrefix ($TargetPrefix)"
      $Output = $null
    } else {
      $SubnetInformation = Get-SubnetInformation -IPv4Address $Subnet -Prefix $Prefix
      $TargetSubnetInformation = Get-SubnetInformation -IPv4Address $Subnet -Prefix $TargetPrefix
      $SubnetCount = ($SubnetInformation.TotalHosts + 2) / ($TargetSubnetInformation.TotalHosts + 2)
      Write-Verbose -Message "Subnet Count: $SubnetCount"
      $Start = (ConvertTo-Int64 -IPv4Address $SubnetInformation.'SubnetId')
      $Output = for ($i = 0; $i -lt $SubnetCount; $i++) {
        $NewSubnet = ConvertTo-IPv4 -Integer ($Start + (($TargetSubnetInformation.TotalHosts + 2) * $i))
        Write-Verbose -Message "New Subnet: $NewSubnet/$TargetPrefix"
        Get-SubnetInformation -IPv4Address $NewSubnet -Prefix $TargetPrefix
      }
    }
  }

  end {
    return $Output
  }
}
