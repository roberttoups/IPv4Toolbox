<#
.SYNOPSIS

  Returns the information regarding a subnet that an IPv4 Address exists

.DESCRIPTION

  Returns the information regarding a subnet that an IPv4 Address exists and returns information regarding Subnet ID, Broadcast Address, Subnet Mask, Network Prefix, First IP Address, Last IP Address, Total Hosts, and AWS related information.

.PARAMETER IPv4Address

  The IPv4 Address

.PARAMETER SubnetMask

  The subnet mask of the network

.PARAMETER Prefix

  The network prefix

.PARAMETER NoPrivateAddressSpace

  This switch omits the reporting of Private Address Space for the subnet and any associated AWS information

.EXAMPLE

  Get-SubnetInformation -IPv4Address 192.168.1.120 -SubnetMask 255.255.254.0

  SubnetId            : 192.168.0.0
  BroadcastAddress    : 192.168.1.255
  SubnetMask          : 255.255.254.0
  Prefix              : 23
  Subnet              : 192.168.0.0/23
  FirstIPv4Address    : 192.168.0.1
  LastIPv4Address     : 192.168.1.254
  TotalHosts          : 510
  AWSFirstIPv4Address : 192.168.0.4
  AWSTotalHosts       : 507
  PrivateAddressSpace : True

.EXAMPLE

  Get-SubnetInformation -IPv4Address 8.8.0.0 -Prefix 21

  SubnetId            : 8.8.0.0
  BroadcastAddress    : 8.8.7.255
  SubnetMask          : 255.255.248.0
  Prefix              : 21
  Subnet              : 8.8.0.0/21
  FirstIPv4Address    : 8.8.0.1
  LastIPv4Address     : 8.8.7.254
  TotalHosts          : 2046
  AWSFirstIPv4Address :
  AWSTotalHosts       :
  PrivateAddressSpace : False

.EXAMPLE

  Get-SubnetInformation -IPv4Address 10.0.0.0 -Prefix 12

  SubnetId            : 10.0.0.0
  BroadcastAddress    : 10.15.255.255
  SubnetMask          : 255.240.0.0
  Prefix              : 12
  Subnet              : 10.0.0.0/12
  FirstIPv4Address    : 10.0.0.1
  LastIPv4Address     : 10.15.255.254
  TotalHosts          : 1048574
  AWSFirstIPv4Address :
  AWSTotalHosts       :
  PrivateAddressSpace : True

.EXAMPLE

  Get-SubnetInformation -IPv4Address 10.0.0.0 -Prefix 28 -NoPrivateAddressSpace

  SubnetId            : 10.0.0.0
  BroadcastAddress    : 10.0.0.15
  SubnetMask          : 255.255.255.240
  Prefix              : 28
  Subnet              : 10.0.0.0/28
  FirstIPv4Address    : 10.0.0.1
  LastIPv4Address     : 10.0.0.14
  TotalHosts          : 14
  AWSFirstIPv4Address :
  AWSTotalHosts       :
  PrivateAddressSpace :

.NOTES

  This function will only return results for AWS if the subnet has a prefix greater or equal to 16 and less than or
  equal 28 and resides in the Private Address Space.

.LINK

  http://www.github.com/roberttoups/IPv4Toolbox

#>
function Get-SubnetInformation {
  [CmdletBinding(
    DefaultParameterSetName = 'Prefix'
  )]
  [OutputType([PSCustomObject])]
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
    $Prefix = 24,

    [Parameter(
      Mandatory = $false,
      ParameterSetName = 'Prefix'
    )]
    [Switch]
    $NoPrivateAddressSpace
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
      $Hosts = ((ConvertTo-DecimalIP -IPAddressObject $BroadcastAddressObject) - (ConvertTo-DecimalIP -IPAddressObject $SubnetAddressObject) - 1)
      $PrivateAddressSpace = if($NoPrivateAddressSpace) {
        Write-Verbose -Message 'Private Address Space: False'
        $null
      } else {
        Write-Verbose -Message 'Private Address Space: True'
        Test-PrivateIPv4Address -IPv4Address $FirstAddress
      }
      if($PrivateAddressSpace -and ($Prefix -ge 16 -and $Prefix -le 28)) {
        Write-Verbose -Message 'AWS Subnet: True'
        $AWSFirstIPv4Address = ConvertTo-IPv4 -Integer ($StartingAddress + 4)
        $AWSTotalHosts = ($Hosts - ((ConvertTo-Int64 -IPv4Address $AWSFirstIPv4Address) - (ConvertTo-Int64 -IPv4Address $FirstAddress)))
      } else {
        Write-Verbose -Message 'AWS Subnet: False'
        $AWSFirstIPv4Address = $null
        $AWSTotalHosts = $null
      }
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
        'AWSTotalHosts'       = $AWSTotalHosts
        'PrivateAddressSpace' = $PrivateAddressSpace
      }
    } else {
      Write-Error '-IPv4Address is NULL!'
      $null
    }
  }

  end {}
}
