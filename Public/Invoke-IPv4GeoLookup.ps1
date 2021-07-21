<#
.SYNOPSIS

  Returns GeoIP Information from ip-api.com.

.DESCRIPTION

  Returns GeoIP Information from ip-api.com.

.PARAMETER IPv4Address

  The non-RFC 1918 IPv4 Address to obtain the GeoIP information.

.EXAMPLE

  Invoke-IPv4GeoLookup -IPv4Address 1.1.1.1

  status       : success
  country      : Australia
  countryCode  : AU
  region       : QLD
  regionName   : Queensland
  city         : South Brisbane
  zip          : 4101
  lat          : -27.4766
  lon          : 153.0166
  timezone     : Australia/Brisbane
  isp          : Cloudflare, Inc
  org          : APNIC and Cloudflare DNS Resolver project
  as           : AS13335 Cloudflare, Inc.
  query        : 1.1.1.1
  mapReference : https://www.google.com/maps?q=-27.4766,153.0166

.NOTES

  Do not use this function multiple times a second or you will be rate limited.

.LINK

  http://www.github.com/roberttoups/IPv4Toolbox

#>
function Invoke-IPv4GeoLookup {
  [CmdletBinding()]
  param (
    # The non-RFC 1918 IPv4 Address to obtain the GeoIP information.
    [Parameter(
      HelpMessage = 'The non-RFC 1918 IPv4 Address to obtain the GeoIP information.',
      ValueFromPipeline = $true,
      Mandatory = $true
    )]
    [Alias('IPAddress')]
    [ValidatePattern(
      '^(?:(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\.){3}(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])$'
    )]
    [String]
    $IPv4Address
  )

  begin {

  }

  process {
    $Uri = "http://ip-api.com/json/$IPv4Address"
    Write-Verbose -Message "Invoking $Uri"
    $Output = Invoke-WebRequest -Uri $Uri |
      Select-Object -ExpandProperty 'Content' |
      ConvertFrom-Json
    if($Output.lat -and $Output.lon) {
      Write-Verbose -Message "Found GeoIP Information"
      $Link = "https://www.google.com/maps?q=$($Output.lat),$($Output.lon)"
      Add-Member -InputObject $Output -MemberType 'NoteProperty' -Name 'mapReference' -Value $Link
    }
    $Output
  }

  end {

  }
}
