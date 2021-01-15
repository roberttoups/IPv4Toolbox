<#
.SYNOPSIS

  Outputs a list of IPv4 Addresses from a CIDR address range.

.DESCRIPTION

  Outputs a list of IPv4 Addresses from a CIDR address range.

.PARAMETER Subnet

  The subnet id of the IPv4 Address range

.PARAMETER SubnetMask

  The Subnet Mask of the IPv4 Address range

.PARAMETER Prefix

  The Prefix of the IPv4 Address range

.EXAMPLE

  Out-SubnetRange -Subnet 192.168.1.0 -Prefix 28

  192.168.1.1
  192.168.1.2
  192.168.1.3
  192.168.1.4
  192.168.1.5
  192.168.1.6
  192.168.1.7
  192.168.1.8
  192.168.1.9
  192.168.1.10
  192.168.1.11
  192.168.1.12
  192.168.1.13
  192.168.1.14

.NOTES

 This function will output usable IP space.

.LINK

 http://www.github.com/roberttoups/IPv4Toolbox

#>
function Out-SubnetRange {
  [CmdletBinding(
    DefaultParameterSetName = 'Prefix'
  )]
  param (
    # The Subnet to generate the individual IPv4 addresses.
    [Parameter(
      Position = 0,
      Mandatory = $true,
      # ValueFromPipelineByPropertyName = $true, # FUTURE WORK
      ValueFromPipeline = $true,
      HelpMessage = 'The Subnet to generate the individual IPv4 addresses.'
    )]
    [Alias('IPv4Address')]
    [ValidatePattern('^(?:(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\.){3}(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])$')]
    [String]
    $Subnet,

    # The Subnet Mask of the Subnet.
    [Parameter(
      Mandatory = $true,
      HelpMessage = 'The Subnet Mask of the Subnet.',
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
      # '255.0.0.0', '255.128.0.0', '255.192.0.0', '255.224.0.0', '255.240.0.0', '255.248.0.0', '255.252.0.0', '255.254.0.0', '255.255.0.0', '255.255.128.0', '255.255.192.0', '255.255.224.0', '255.255.240.0', '255.255.248.0', '255.255.252.0', '255.255.254.0', '255.255.255.0', '255.255.255.128', '255.255.255.192', '255.255.255.224', '255.255.255.240', '255.255.255.248', '255.255.255.252', '255.255.255.254', '255.255.255.255'
    )]
    [String]
    $SubnetMask,

    # The Prefix of the Subnet.
    [Parameter(
      Mandatory = $false,
      HelpMessage = 'The Prefix of the Subnet.',
      ParameterSetName = 'Prefix'
    )]
    [ValidateRange(8 , 30)]
    [Int32]
    $Prefix = 24
  )

  begin {

  }
  process {
    Write-Verbose -Message "IPv4Address: $Subnet"
    Write-Verbose -Message "Parameter Set: $($PSCmdlet.ParameterSetName)"
    if($PSCmdlet.ParameterSetName -eq 'Prefix') {
      $SubnetInformation = Get-SubnetInformation -IPv4Address $Subnet -Prefix $Prefix
    } elseif($PSCmdlet.ParameterSetName -eq 'SubnetMask') {
      $SubnetInformation = Get-SubnetInformation -IPv4Address $Subnet -SubnetMask $SubnetMask
    }
    [Int64]$FirstIPv4Int64 = ConvertTo-Int64 -IPv4Address $SubnetInformation.FirstIPv4Address
    [Int64]$LastIPv4Int64 = ConvertTo-Int64 -IPv4Address $SubnetInformation.LastIPv4Address
    for ($i = $FirstIPv4Int64; $i -le $LastIPv4Int64; $i++) {
      ConvertTo-IPv4 -Integer $i
    }
  }
  end {}
}
