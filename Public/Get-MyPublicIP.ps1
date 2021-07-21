<#
.SYNOPSIS

  Returns the Public IPv4 Address of the client returned by a web API.

.DESCRIPTION

  Returns the Public IPv4 Address of the client returned by a web API.

.PARAMETER Uri

  This is the URI used to query the Public IPv4 Address. Valid URIs are http://icanhazip.com, http://ident.me, http://ifconfig.me/ip, & http://ipinfo.io/ip.

.EXAMPLE

  Get-MyPublicIP

  8.8.8.8

.EXAMPLE

  Get-MyPublicIP -Uri 'http://icanhazip.com'

  8.8.8.8


.NOTES

  This function depends on the traffic reaching the web based API not flowing through a proxy for most accurate results.

.LINK

  http://www.github.com/roberttoups/IPv4Toolbox

#>
function Get-MyPublicIP {
  [CmdletBinding()]
  [OutputType([String])]
  param (
    # The URI of the API Service.
    [Parameter(
      Position = 0,
      Mandatory = $false,
      HelpMessage = 'The URI of the API Service.'
    )]
    [ValidateSet(
      'https://ipv4.icanhazip.com',
      'https://v4.ident.me',
      'https://ifconfig.me/ip',
      'https://ipinfo.io/ip'
    )]
    [String]
    $Uri = 'https://ipinfo.io/ip'
  )
  begin {}

  process {
    Write-Verbose -Message "Querying $Uri"
    ((Invoke-WebRequest -Uri $Uri).Content).Trim()
  }

  end {}
}
