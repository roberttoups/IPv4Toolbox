<#
.SYNOPSIS

Tests a string to determine if it is a valid IPv4 Address.

.DESCRIPTION

Tests a string to determine if it is a valid IPv4 Address (0.0.0.0 to 255.255.255.255).

.PARAMETER IPv4Address

The string to test if it is a valid IPv4 Address.

.EXAMPLE

  Test-IPv4Address -IPv4Address 192.168.0.1

  True

.EXAMPLE

  Test-IPv4Address -IPv4Address 192.apple.0.1

  False

.EXAMPLE

  Test-IPv4Address -IPv4Address 192.256.0.1

  False

.NOTES

  http://www.github.com/roberttoups/IPv4Toolbox

.LINK

#>
function Test-IPv4Address {
  [CmdletBinding()]
  param (
    # The IPv4 Address string to test.
    [Parameter(
      HelpMessage = 'The IPv4 Address string to test.',
      ValueFromPipeline = $true,
      Mandatory = $true
    )]
    [String]
    $IPv4Address
  )

  begin { }

  process {
    $RegularExpression = '^(?:(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\.){3}(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])$'
    if($IPv4Address -match $RegularExpression) {
      try {
        $TestIPv4Address = [System.Net.IPAddress]$IPv4Address
        if($TestIPv4Address) {
          $true
        } else {
          $false
        }
      } catch {
        $false
      }
    } else {
      $false
    }
  }
  end {  }
}
