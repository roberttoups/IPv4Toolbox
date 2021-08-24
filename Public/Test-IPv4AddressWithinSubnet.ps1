<#
.SYNOPSIS

  Evaluates if an IPv4 Address is within an IPv4 Subnet range.

.DESCRIPTION

  Evaluates if an IPv4 Address is within an IPv4 Subnet range.

.PARAMETER TestIPv4Address

  The IPv4 Address to test for within the subnet range.

.PARAMETER IPv4Address

  The IPv4 Address of the Subnet ID or a IPv4 Address within the range of the Subnet.

.PARAMETER Prefix

  The prefix length of the Subnet.

.EXAMPLE

  Test-IPv4AddressWithinSubnet -TestIPv4Address '192.168.1.1' -IPv4Address '192.168.1.0' -Prefix 24
  True

.EXAMPLE

  Test-IPv4AddressWithinSubnet -TestIPv4Address '10.1.1.1' -IPv4Address '192.168.0.0' -Prefix 16
  False

.NOTES

.LINK

  http://www.github.com/roberttoups/IPv4Toolbox
#>
function Test-IPv4AddressWithinSubnet {
  [CmdletBinding()]
  [OutputType([Boolean])]
  param (
    # The IPv4 address to test.
    [Parameter(
      Position = 0,
      Mandatory = $true,
      HelpMessage = 'The IPv4 address to test.'
    )]
    [ValidatePattern(
      '^(?:(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\.){3}(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])$'
    )]
    [String]
    $TestIPv4Address,
    # The Subnet IPv4 address.
    [Parameter(
      Position = 1,
      Mandatory = $true,
      HelpMessage = 'The Subnet IPv4 address.'
    )]
    [Alias('Subnet')]
    [ValidatePattern(
      '^(?:(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\.){3}(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])$'
    )]
    [String]
    $IPv4Address,
    # The Subnet prefix.
    [Parameter(
      Position = 2,
      Mandatory = $true,
      HelpMessage = 'The Subnet prefix.'
    )]
    [ValidateRange(8 , 30)]
    [Int32]
    $Prefix

  )

  begin {

  }

  process {
    $ArgumentCollection = @{
      IPv4Address           = $IPv4Address
      Prefix                = $Prefix
      NoPrivateAddressSpace = $true
    }
    $SubnetInformation = Get-SubnetInformation @ArgumentCollection
    Write-Verbose -Message ($SubnetInformation | Out-String)
    $ArgumentCollection = @{
      FirstIPv4Address = $SubnetInformation.FirstIPv4Address
      LastIPv4Address  = $SubnetInformation.LastIPv4Address
      TestIPv4Address  = $TestIPv4Address
      ErrorAction      = 'Stop'
    }
    try {
      Test-IPv4AddressWithinRange @ArgumentCollection
    } catch {
      $SpecificReason = 'Failed to call Test-IPv4AddressWithinSubnet.'
      $ErrorMessage = $PSItem.Exception.Message
      throw "($ErrorMessage): $SpecificReason Exiting."
    }
  }

  end {

  }
}
