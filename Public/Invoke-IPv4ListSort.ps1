<#
.SYNOPSIS

  Sorts an array of IPv4 Addresses.

.DESCRIPTION

  Sorts an array of IPv4 Addresses.

.PARAMETER IPv4AddressList

  The list of IPv4 Addresses

.PARAMETER Descending

  This switch will sort the IPv4 Addresses in reverse order


.EXAMPLE

  Invoke-IPv4ListSort -IPv4AddressList @('192.168.0.1','10.12.2.2','1.1.1.1','8.8.8.8')

  1.1.1.1
  8.8.8.8
  10.12.2.2
  192.168.0.1

.EXAMPLE

  Invoke-IPv4ListSort -IPv4AddressList @('192.168.0.1','10.12.2.2','1.1.1.1','8.8.8.8') -Descending

  192.168.0.1
  10.12.2.2
  8.8.8.8
  1.1.1.1

.EXAMPLE

  Invoke-IPv4ListSort -IPv4AddressList @('192.168.1.0/28','10.12.13.14/32','8.8.8.8','4.2.2.1','192.168.23.2/29','1.1.1.1')

  1.1.1.1
  4.2.2.1
  8.8.8.8
  10.12.13.14
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
  192.168.23.1
  192.168.23.2
  192.168.23.3
  192.168.23.4
  192.168.23.5
  192.168.23.6


.NOTES

.LINK

  http://www.github.com/roberttoups/IPv4Toolbox

#>
function Invoke-IPv4ListSort {
  [CmdletBinding()]
  param(
    # The thing you want the single string for.
    [Parameter(
      Position = 0,
      Mandatory = $false,
      HelpMessage = 'An Array of IPv4 Addresses to sort.'
    )]
    [String[]]
    $IPv4AddressList,

    [Switch]
    $Descending
  )

  begin {

  }

  process {
    $SingleIpRegEx = '^(?:(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\.){3}(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])$'
    $SubnetRangeRegEx = '^(?:(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\.){3}(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])/([8-9]|[1-2][0-9]|3[0])$'
    $ValidatedIPv4AddressList = foreach($IPv4Address in $IPv4AddressList) {
      if($IPv4Address -match '/32$') {
        Write-Verbose -Message "$IPv4Address is /32"
        $IPv4Address = $IPv4Address -replace ('/32$', '')
      }
      if($IPv4Address -match $SingleIpRegEx) {
        Write-Verbose -Message "$IPv4Address is a single IPv4 Address"
        $IPv4Address
      } elseif($IPv4Address -match $SubnetRangeRegEx) {
        Write-Verbose -Message "Subnet: $IPv4Address"
        $IPAddress = $IPv4Address.Split('/')[0]
        $Prefix = $IPv4Address.Split('/')[1]
        Out-SubnetRange -Subnet $IPAddress -Prefix $Prefix
      } else {
        Write-Verbose -Message "$IPv4Address is not a valid IPv4 Address"
      }
    }
    if($Descending) {
      Write-Verbose -Message "Sorting IPv4 Addresses in Descending order"
      [System.Array]$SortedIPv4AddressList = $ValidatedIPv4AddressList |
        Sort-Object -Property @{Expression = { $_ -as [System.Version] } } -Descending -Unique
    } else {
      Write-Verbose -Message "Sorting IPv4 Addresses in Ascending order"
      [System.Array]$SortedIPv4AddressList = $ValidatedIPv4AddressList |
        Sort-Object -Property @{Expression = { $_ -as [System.Version] } } -Unique
    }
    $SortedIPv4AddressList
  }

  end {

  }
}
