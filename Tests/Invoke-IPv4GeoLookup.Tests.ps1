$ModuleName = 'IPv4Toolbox'
$script:FunctionName = 'Invoke-IPv4GeoLookup'
$ParentPath = Split-Path -Path $PSScriptRoot -Parent
$ModulePath = Join-Path -Path $ParentPath -ChildPath "$($ModuleName).psm1"
Get-Module  -Name $ModuleName |
  Remove-Module -Force
Import-Module $ModulePath -Force

InModuleScope $ModuleName {
  Describe "Basic function unit tests for $FunctionName" -Tags @('Build', 'Unit') {
    $SuccessIPv4Address = '1.1.1.1'
    $FailureIPv4Address = '4.2.2.1'
    $SuccessReferenceObject = [PSCustomObject]@{
      'status'       = 'success'
      'region'       = 'QLD'
      'regionName'   = 'Queensland'
      'city'         = 'South Brisbane'
      'zip'          = '4101'
      'lat'          = '-27.4766'
      'lon'          = '153.0166'
      'timezone'     = 'Australia/Brisbane'
      'isp'          = 'Cloudflare, Inc'
      'org'          = 'APNIC and Cloudflare DNS Resolver project'
      'as'           = 'AS13335 Cloudflare, Inc.'
      'query'        = '1.1.1.1'
      'mapReference' = 'https://www.google.com/maps?q=-27.4766,153.0166'
    }

    $PropertyList = @(
      'as'
      'city'
      'isp'
      'lat'
      'lon'
      'mapReference'
      'org'
      'query'
      'region'
      'regionName'
      'status'
      'timezone'
      'zip'
    )

    Context "Testing return by $FunctionName using $SuccessIPv4Address" {
      $TestReferenceObject = Invoke-IPv4GeoLookup -IPv4Address $SuccessIPv4Address
      $TestCase = @{
        ReferenceObject  = $SuccessReferenceObject
        DifferenceObject = $TestReferenceObject
        PropertyList     = $PropertyList
      }
      It "Return should be True for $SuccessIPv4Address" -TestCases $TestCase {
        param (
          $ReferenceObject,
          $DifferenceObject,
          $PropertyList
        )
        Compare-Object -ReferenceObject $ReferenceObject -DifferenceObject $DifferenceObject -Property $PropertyList |
          Should -Be $null
      }

      $TestReferenceObject = Invoke-IPv4GeoLookup -IPv4Address $FailureIPv4Address
      $TestCase = @{
        ReferenceObject  = $SuccessReferenceObject
        DifferenceObject = $TestReferenceObject
        PropertyList     = $PropertyList
      }
      It "Return should be False for $FailureIPv4Address" -TestCases $TestCase {
        param (
          $ReferenceObject,
          $DifferenceObject,
          $PropertyList
        )
        Compare-Object -ReferenceObject $ReferenceObject -DifferenceObject $DifferenceObject -Property $PropertyList |
          Should -Not -Be $null
      }
    }

  }
}
