<#
.SYNOPSIS

  Outputs a hash table of subnet masks and associated prefix

.DESCRIPTION

  Outputs a hash table of subnet masks and associated prefix

.EXAMPLE

  Get-PrefixTable

  Name                           Value
  ----                           -----
  255.255.240.0                  20
  255.255.255.0                  24
  255.0.0.0                      8
  255.254.0.0                    15
  255.255.255.240                28
  255.192.0.0                    10
  255.255.255.252                30
  255.255.255.224                27
  255.255.255.254                31
  255.240.0.0                    12
  255.255.255.192                26
  255.255.255.248                29
  255.224.0.0                    11
  255.255.224.0                  19
  255.255.0.0                    16
  255.248.0.0                    13
  255.255.248.0                  21
  255.255.252.0                  22
  255.255.255.255                32
  255.255.255.128                25
  255.255.192.0                  18
  255.255.128.0                  17
  255.128.0.0                    9
  255.252.0.0                    14
  255.255.254.0                  23

.LINK

  http://www.github.com/roberttoups/IPv4Toolbox

#>
function Get-PrefixTable {
  [CmdletBinding()]
  [OutputType([HashTable])]
  param()
  begin {}
  process {
    $HashTable = @{}
    for($Prefix = 8; $Prefix -le 32; $Prefix++) {
      $HashTable.Add(([System.Net.IPAddress]::Parse((ConvertTo-IPv4 -Integer ([System.Convert]::ToInt64(("1" * $Prefix + "0" * (32 - $Prefix)), 2))))).IPAddressToString, $Prefix)
    }
    $HashTable
  }
  end {}
}
