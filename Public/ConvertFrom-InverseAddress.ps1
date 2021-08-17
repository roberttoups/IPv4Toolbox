<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER

.EXAMPLE

  ConvertFrom-InverseAddress

.NOTES

.LINK

#>
function ConvertFrom-InverseAddress {
  [CmdletBinding()]
  param (
    # The Inverse Address to produce the IPv4Address.
    [Parameter(
      Position = 0,
      Mandatory = $true,
      ValueFromPipeline = $true,
      HelpMessage = 'The Inverse Address to produce the IPv4Address.',
      ParameterSetName = 'InverseAddress'
    )]
    [ValidateScript(
      {
        if($_ -match '^(.*?)\.(.*?)\.(.*?)\.(.*?)\.in-addr\.arpa') {
          $true
        } elseif($_ -match '^(.*?)\.(.*?)\.(.*?)\.in-addr\.arpa') {
          $true
        } elseif($_ -match '^(.*?)\.(.*?)\.in-addr\.arpa') {
          $true
        } elseif($_ -match '^(.*?)\.in-addr\.arpa') {
          $true
        } else {
          $false
        }
      }
    )
    ]
    [String]
    $InverseAddress
  )

  begin {

  }

  process {
    Write-Verbose -Message "Converting Inverse Address: $InverseAddress"
    if($InverseAddress -match '^(.*?)\.(.*?)\.(.*?)\.(.*?)\.in-addr\.arpa') {
      Write-Verbose -Message "Inverse Address is in IPv4 format"
      $IPv4Address = $InverseAddress.Replace('.in-addr.arpa', '')
      [System.Collections.ArrayList]$IPv4ElementList = $IPv4Address.Split('.')
      $IPv4ElementList.Reverse() | Out-Null
      $Output = $($IPv4ElementList -join '.')
    } elseif($InverseAddress -match '^(.*?)\.(.*?)\.(.*?)\.in-addr\.arpa') {
      Write-Verbose -Message "Inverse Address is a /24 Subnet"
      $IPv4Address = $InverseAddress.Replace('.in-addr.arpa', '')
      [System.Collections.ArrayList]$IPv4ElementList = $IPv4Address.Split('.')
      $IPv4ElementList.Reverse() | Out-Null
      $Output = "$($IPv4ElementList -join '.').0/24"
    } elseif($InverseAddress -match '^(.*?)\.(.*?)\.in-addr\.arpa') {
      Write-Verbose -Message "Inverse Address is a /16 Subnet"
      $IPv4Address = $InverseAddress.Replace('.in-addr.arpa', '')
      [System.Collections.ArrayList]$IPv4ElementList = $IPv4Address.Split('.')
      $IPv4ElementList.Reverse() | Out-Null
      $Output = "$($IPv4ElementList -join '.').0.0/16"
    } elseif($InverseAddress -match '^(.*?)\.in-addr\.arpa') {
      Write-Verbose -Message "Inverse Address is a /8 Subnet"
      $IPv4Address = $InverseAddress.Replace('.in-addr.arpa', '')
      [System.Collections.ArrayList]$IPv4ElementList = $IPv4Address.Split('.')
      $IPv4ElementList.Reverse() | Out-Null
      $Output = "$($IPv4ElementList -join '.').0.0.0/8"
    } else {
      Write-Verbose -Message "Inverse Address is not in proper format. Who did we get here?"
      $Output = $null
    }
    $Output
  }

  end {

  }
}
