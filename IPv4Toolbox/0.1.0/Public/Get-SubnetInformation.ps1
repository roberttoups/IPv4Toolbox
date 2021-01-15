<#
.SYNOPSIS

  Returns the information regarding a subnet that an IPv4 Address exists

.DESCRIPTION

  Returns the information regarding a subnet that an IPv4 Address exists and returns information regarding Subnet ID, Broadcast Address, Subnet Mask, Network Prefix, First IP Address, Last IP Address, Total Hosts, and Total Class C addresses.

.PARAMETER IPv4Address

  The IPv4 Address

.PARAMETER Mask

  The subnet mask of the network

.PARAMETER Prefix

  The network prefix

.EXAMPLE

  Get-SubnetInformation -IPv4Address 192.168.1.120 -Mask 255.255.254.0

  SubnetId              : 192.168.0.0
  BroadcastAddress      : 192.168.1.255
  SubnetMask            : 255.255.254.0
  Prefix                : 23
  FirstIPv4Address      : 192.168.0.1
  LastIPv4Address       : 192.168.1.254
  TotalHosts            : 510
  TotalClassCSubnets    : 2

.EXAMPLE

  Get-SubnetInformation -Ipv4Address 192.168.1.120 -Prefix 16

  SubnetId              : 192.168.0.0
  BroadcastAddress      : 192.168.255.255
  SubnetMask            : 255.255.0.0
  Prefix                : 16
  FirstIPv4Address      : 192.168.0.1
  LastIPv4Address       : 192.168.255.254
  TotalHosts            : 65534
  TotalClassCSubnets    : 256

.LINK

  http://www.github.com/roberttoups/IPv4Toolbox

#>
function Get-SubnetInformation {
  [CmdletBinding(
    DefaultParameterSetName = 'Prefix'
  )]
  [OutputType([PSCustomObject])]
  Param (
    [Parameter(
      Mandatory = $true,
      ValueFromPipeline = $true
    )]
    [Alias('IPAddress')]
    [ValidatePattern(
      '^(?:(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\.){3}(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])$'
    )]
    [String]
    $IPv4Address,

    [Parameter(
      Mandatory = $true,
      ParameterSetName = 'SubnetMask'
    )]
    [Alias('Mask')]
    [ValidateSet(
      '255.0.0.0',
      '255.128.0.0',
      '255.192.0.0',
      '255.224.0.0',
      '255.240.0.0',
      '255.248.0.0',
      '255.252.0.0',
      '255.254.0.0',
      '255.255.0.0',
      '255.255.128.0',
      '255.255.192.0',
      '255.255.224.0',
      '255.255.240.0',
      '255.255.248.0',
      '255.255.252.0',
      '255.255.254.0',
      '255.255.255.0',
      '255.255.255.128',
      '255.255.255.192',
      '255.255.255.224',
      '255.255.255.240',
      '255.255.255.248',
      '255.255.255.252',
      '255.255.255.254',
      '255.255.255.255'
    )]
    [String]
    $SubnetMask,

    [Parameter(
      Mandatory = $false,
      ParameterSetName = 'Prefix'
    )]
    [ValidateRange(8 , 30)]
    [Int32]
    $Prefix = 24
  )

  begin {}

  process {
    Write-Verbose -Message "IPv4Address: $IPv4Address"
    Write-Verbose -Message "Parameter Set: $($PSCmdlet.ParameterSetName)"
    if($IPv4Address) {
      $IPv4AddressObject = [System.Net.IPAddress]::Parse($IPv4Address)
      if($PSCmdlet.ParameterSetName -eq 'Prefix') {
        $SubnetMaskObject = [System.Net.IPAddress]::Parse((ConvertTo-IPv4 -Integer ([System.Convert]::ToInt64(("1" * $Prefix + "0" * (32 - $Prefix)), 2))))
      } elseif($PSCmdlet.ParameterSetName -eq 'SubnetMask') {
        $SubnetMaskObject = [System.Net.IPAddress]::Parse($SubnetMask)
        $TempTable = Get-PrefixTable
        $Prefix = $TempTable.Item($($SubnetMaskObject.IPAddressToString))
        Write-Verbose -Message "Converted $SubnetMask to /$Prefix"
      }
      if($IPv4Address) {
        $SubnetAddressObject = New-Object System.Net.IPAddress($SubnetMaskObject.Address -band $IPv4AddressObject.Address)
        $BroadcastAddressObject = New-Object System.Net.IPAddress(
          [System.Net.IpAddress]::Parse('255.255.255.255').Address -bxor $SubnetMaskObject.Address -bor $SubnetAddressObject.Address
        )
      }

      $StartingAddress = ConvertTo-Int64 -IPv4Address $SubnetAddressObject.IPAddressToString
      $EndingAddress = ConvertTo-Int64 -IPv4Address $BroadcastAddressObject.IPAddressToString
      $LastAddress = ConvertTo-IPv4 -Integer ($EndingAddress - 1)
      $FirstAddress = ConvertTo-IPv4 -Integer ($StartingAddress + 1)
      $AWSFirstIPv4Address = ConvertTo-IPv4 -Integer ($StartingAddress + 3)
      $Hosts = ((ConvertTo-DecimalIP -IPAddressObject $BroadcastAddressObject) - (ConvertTo-DecimalIP -IPAddressObject $SubnetAddressObject) - 1)

      [PsCustomObject] @{
        'SubnetId'            = $SubnetAddressObject.IPAddressToString
        'BroadcastAddress'    = $BroadcastAddressObject.IPAddressToString
        'SubnetMask'          = $SubnetMaskObject.IPAddressToString
        'Prefix'              = $Prefix
        'Subnet'              = "$($SubnetAddressObject.IPAddressToString)/$Prefix"
        'FirstIPv4Address'    = $FirstAddress
        'LastIPv4Address'     = $LastAddress
        'TotalHosts'          = $Hosts
        'AWSFirstIPv4Address' = $AWSFirstIPv4Address
        'AWSTotalHosts'       = ($Hosts - ((ConvertTo-Int64 -IPv4Address $AWSFirstIPv4Address) - (ConvertTo-Int64 -IPv4Address $FirstAddress)))
      }
    } else {
      Write-Error "-IPv4Address is NULL!"
      $null
    }
  }

  end {}
}
