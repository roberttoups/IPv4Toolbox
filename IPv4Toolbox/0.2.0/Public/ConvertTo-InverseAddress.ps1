<#
.SYNOPSIS

  Converts an IPv4 Address or Subnet into Windows PTR Zone compatible domain name.

.DESCRIPTION

  Converts an IPv4 Address or Subnet into Windows PTR Zone compatible domain name.

.PARAMETER IPv4Address

  IPv4 Address to convert to an inverse address

.PARAMETER Subnet

  The subnet id to convert to an inverse address

.PARAMETER Prefix

  The subnet prefix for the subnet to convert to an inverse address

.EXAMPLE

  ConvertTo-InverseAddress -IPv4Address '192.168.1.1'

  1.1.168.192.in-addr.arpa

.EXAMPLE

ConvertTo-InverseAddress -Subnet '10.2.2.0' -Prefix 22

0.2.10.in-addr.arpa
1.2.10.in-addr.arpa
2.2.10.in-addr.arpa
3.2.10.in-addr.arpa

.NOTES

.LINK

  http://www.github.com/roberttoups/IPv4Toolbox

#>
function ConvertTo-InverseAddress {
  [CmdletBinding(
    DefaultParameterSetName = 'IPv4Address'
  )]
  [OutputType([String[]])]
  param (
    # The IPv4Address to produce the Inverse Address.
    [Parameter(
      Position = 0,
      Mandatory = $false,
      # ValueFromPipelineByPropertyName = $true, # FUTURE WORK
      ValueFromPipeline = $true,
      HelpMessage = 'The IPv4Address to produce the Inverse Address.',
      ParameterSetName = 'IPv4Address'
    )]
    [ValidatePattern('^(?:(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\.){3}(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])$')]
    [String[]]
    $IPv4Address = '127.0.0.1',

    # The Subnet to produce the Inverse Address.
    [Parameter(
      Position = 0,
      Mandatory = $true,
      HelpMessage = 'The Subnet to produce the Inverse Address.',
      ParameterSetName = 'Subnet'
    )]
    [ValidatePattern('^(?:(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\.){3}(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])$')]
    [String]
    $Subnet,

    # The Prefix of the Subnet to produce the Inverse Address.
    [Parameter(
      Position = 1,
      Mandatory = $true,
      HelpMessage = 'The Prefix of the Subnet to produce the Inverse Address.',
      ParameterSetName = 'Subnet'
    )]
    [ValidateRange(8 , 30)]
    [Int32]
    $Prefix
  )

  begin {

  }

  process {
    Write-Verbose -Message "IPv4Address: $IPv4Address"
    Write-Verbose -Message "Parameter Set: $($PSCmdlet.ParameterSetName)"
    if($PSCmdlet.ParameterSetName -eq 'IPv4Address') {
      [System.Collections.ArrayList]$IPv4ElementList = $IPv4Address.Split('.')
      $IPv4ElementList.Reverse() | Out-Null
      $Output = "$($IPv4ElementList -join '.').in-addr.arpa"
    } elseif($PSCmdlet.ParameterSetName -eq 'Subnet') {
      $ArgumentCollection = @{
        IPv4Address = $Subnet
        Prefix      = $Prefix
      }
      $SubnetInformation = Get-SubnetInformation @ArgumentCollection
      [System.Collections.ArrayList]$IPv4ElementList = $SubnetInformation.SubnetId.Split('.')
      $IPv4ElementList.Reverse()
      Write-Verbose -Message "Prefix: $Prefix"
      if($Prefix -ge 24) {
        Write-Verbose -Message 'Prefix is 24 or greater'
        $Output = "$($IPv4ElementList[1]).$($IPv4ElementList[2]).$($IPv4ElementList[3]).in-addr.arpa"
      } elseif($Prefix -gt 16) {
        Write-Verbose -Message 'Prefix greater than 16'
        $NewSubnetCollection = Split-Subnet -IPv4Address $Subnet -Prefix $Prefix -TargetPrefix 24
        $Output = foreach($NewSubnet in $NewSubnetCollection) {
          [System.Collections.ArrayList]$SubnetId = $NewSubnet.SubnetId.Split('.')
          $SubnetId.Reverse()
          "$($SubnetId[1]).$($SubnetId[2]).$($SubnetId[3]).in-addr.arpa"
        }
      } elseif($Prefix -eq 16) {
        Write-Verbose -Message 'Prefix greater is 16'
        $Output = "$($IPv4ElementList[2]).$($IPv4ElementList[3]).in-addr.arpa"
      } elseif($Prefix -gt 8) {
        Write-Verbose -Message 'Prefix greater than 8'
        $NewSubnetCollection = Split-Subnet -IPv4Address $Subnet -Prefix $Prefix -TargetPrefix 16
        $Output = foreach($NewSubnet in $NewSubnetCollection) {
          [System.Collections.ArrayList]$SubnetId = $NewSubnet.SubnetId.Split('.')
          $SubnetId.Reverse()
          "$($SubnetId[2]).$($SubnetId[3]).in-addr.arpa"
        }
      } elseif($Prefix -eq 8) {
        Write-Verbose -Message 'Prefix is 8'
        $Output = "$($IPv4ElementList[3]).in-addr.arpa"
      }
    }
    Write-Verbose -Message "Output: $($Output.GetType() | Out-String)"
    return $Output
  }

  end {
  }
}
