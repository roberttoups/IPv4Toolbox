$ModuleName = 'IPv4Toolbox'
$script:FunctionName = 'Test-IPv4AddressWithinRange'
$ParentPath = Split-Path -Path $PSScriptRoot -Parent
$ModulePath = Join-Path -Path $ParentPath -ChildPath "$($ModuleName).psm1"
Get-Module  -Name $ModuleName |
  Remove-Module -Force
Import-Module $ModulePath -Force

InModuleScope $ModuleName {
  Describe "Basic function unit tests for $FunctionName" -Tags @('Build', 'Unit') {
    $SourceSubnet = '192.168.0.0'
    $SourcePrefix = 24
    $SuccessIPv4AddressList = @(Out-SubnetRange -IPv4Address 192.168.0.64 -Prefix 26)
    $FailureIPv4AddressList = @(Out-SubnetRange -IPv4Address 192.168.1.128 -Prefix 26)
    Context "Testing return by $FunctionName using $SourceSubnet/$SourcePrefix" {
      $TestObject = Get-SubnetInformation -IPv4Address $SourceSubnet -Prefix $SourcePrefix

      foreach($SuccessIPv4Address in $SuccessIPv4AddressList) {
        $TestCase = @{
          FirstIPv4Address = $TestObject.FirstIPv4Address
          LastIPv4Address  = $TestObject.LastIPv4Address
          TestIPv4Address  = $SuccessIPv4Address
        }
        It "Return should be True for $SuccessIPv4Address" -TestCases $TestCase {
          param(
            $FirstIPv4Address,
            $LastIPv4Address,
            $TestIPv4Address
          )
          $ArgumentCollection = @{
            FirstIPv4Address = $FirstIPv4Address
            LastIPv4Address  = $LastIPv4Address
            TestIPv4Address  = $TestIPv4Address
          }
          Test-IPv4AddressWithinRange @ArgumentCollection |
            Should -Be $true
        }
      }
      foreach($FailureIPv4Address in $FailureIPv4AddressList) {
        $TestCase = @{
          FirstIPv4Address = $TestObject.FirstIPv4Address
          LastIPv4Address  = $TestObject.LastIPv4Address
          TestIPv4Address  = $FailureIPv4Address
        }
        It "Return should be False for $FailureIPv4Address" -TestCases $TestCase {
          param(
            $FirstIPv4Address,
            $LastIPv4Address,
            $TestIPv4Address
          )
          $ArgumentCollection = @{
            FirstIPv4Address = $FirstIPv4Address
            LastIPv4Address  = $LastIPv4Address
            TestIPv4Address  = $TestIPv4Address
          }
          Test-IPv4AddressWithinRange @ArgumentCollection |
            Should -Be $false
        }
      }
    }

  }
}
