$ModuleName = 'IPv4Toolbox'
$script:FunctionName = 'ConvertTo-InverseAddress'
$ParentPath = Split-Path -Path $PSScriptRoot -Parent
$ModulePath = Join-Path -Path $ParentPath -ChildPath "$($ModuleName).psm1"
Get-Module  -Name $ModuleName |
  Remove-Module -Force
Import-Module $ModulePath -Force

InModuleScope $ModuleName {
  Describe "Basic function unit tests for $FunctionName" -Tags @('Build', 'Unit') {
    $TestIPv4Address = '192.168.1.1'
    $FailureIPv4Address = '10.11.12.13'
    $TestIPv4Result = '1.1.168.192.in-addr.arpa'
    $TestSubnet = '10.2.2.0'
    $TestPrefix = 22
    $TestSubnetResult = @(
      '0.2.10.in-addr.arpa'
      '1.2.10.in-addr.arpa'
      '2.2.10.in-addr.arpa'
      '3.2.10.in-addr.arpa'
    )

    Context "Testing return by $FunctionName" {
      $Result = ConvertTo-InverseAddress -IPv4Address $TestIPv4Address
      $TestCase = @{
        Result         = $Result
        TestIPv4Result = $TestIPv4Result
      }
      It "Return should be '1.1.168.192.in-addr.arpa' for $TestIPv4Address" -TestCases $TestCase {
        param (
          $Result,
          $TestIPv4Result
        )
        $Result -eq $TestIPv4Result |
          Should -Be $true
      }

      $Result = ConvertTo-InverseAddress -IPv4Address $FailureIPv4Address
      $TestCase = @{
        Result         = $Result
        TestIPv4Result = $TestIPv4Result
      }
      It "Return should not be '1.1.168.192.in-addr.arpa' for $FailureIPv4Address" -TestCases $TestCase {
        param (
          $Result,
          $TestIPv4Result
        )
        $Result -eq $TestIPv4Result |
          Should -Be $false
      }

      $Result = ConvertTo-InverseAddress -Subnet $TestSubnet -Prefix $TestPrefix
      $TestCase = @{
        ReferenceObject  = $Result
        DifferenceObject = $TestSubnetResult
      }
      It "Return should be $($TestSubnetResult -join ',') for $TestSubnet" -TestCases $TestCase {
        param (
          $ReferenceObject,
          $DifferenceObject
        )
        Compare-Object -ReferenceObject $ReferenceObject -DifferenceObject $DifferenceObject |
          Should -Be $null
      }
    }
  }
}
