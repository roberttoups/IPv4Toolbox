<#
.SYNOPSIS

  Returns all valid IPv4 Address in a string.

.DESCRIPTION

  Find-IPv4Address will search a block of text for IPv4 Addresses and returns only the IPv4 Addresses found.

.PARAMETER Text

  The block of text to discover IPv4 Addresses

.EXAMPLE

  Find-IPv4Address -Text 'Mary had little lamb 192.168.1.1 who fleece was white as snow, 127.0.0.1.'

  192.168.1.1
  127.0.0.1

.NOTES

  The body of text provided to the Text parameter can be multi-line. The function will only return valid IPv4 Addresses from 0.0.0.0 to 255.255.255.255.

.LINK

  http://www.github.com/roberttoups/IPv4Toolbox

#>
function Find-IPv4Address {
  [CmdletBinding()]
  [OutputType([String[]])]
  param (
    # The block of text to find IPv4Addresses in.
    [Parameter(
      Position = 0,
      Mandatory = $true,
      ValueFromPipeline = $true,
      HelpMessage = 'The block of text to find IPv4Addresses in.'
    )]
    [String[]]
    $Text
  )

  begin {}

  process {
    $RegularExpression = '^(?:(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\.){3}(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])$'
    $Text = $Text -replace '\n', ' '
    $Data = $Text.Split(' ')
    foreach($Word in $Data) {
      if($Word -match '\W$') {
        $Word = $Word.Substring(0, ($Word.Length - 1))
      }
      if($Word -match $RegularExpression) {
        $Matches[0]
      }
    }
  }

  end {}
}
