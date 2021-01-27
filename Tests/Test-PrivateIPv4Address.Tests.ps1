$ModuleName = 'IPv4Toolbox'
$script:FunctionName = 'Test-PrivateIPv4Address'
$ParentPath = Split-Path -Path $PSScriptRoot -Parent
$ModulePath = Join-Path -Path $ParentPath -ChildPath "$($ModuleName).psm1"
Get-Module  -Name $ModuleName |
  Remove-Module -Force
Import-Module $ModulePath -Force

InModuleScope $ModuleName {
  Describe "Basic function unit tests for $FunctionName" -Tags @('Build', 'Unit') {
    $SuccessIPv4AddressList = @(Out-SubnetRange -IPv4Address 192.168.0.64 -Prefix 26)
    $SuccessIPv4AddressList += @(Out-SubnetRange -IPv4Address 172.16.10.0 -Prefix 26)
    $SuccessIPv4AddressList += @(Out-SubnetRange -IPv4Address 10.11.12.128 -Prefix 26)
    $SuccessIPv4AddressList += @(Out-SubnetRange -IPv4Address 100.64.20.192 -Prefix 26)
    $FailureIPv4AddressList = @(Out-SubnetRange -IPv4Address 192.169.2.1 -Prefix 26)
    $FailureIPv4AddressList += @(Out-SubnetRange -IPv4Address 8.8.8.8 -Prefix 26)
    $FailureIPv4AddressList += @(Out-SubnetRange -IPv4Address 100.63.1.1 -Prefix 26)
    Context "Testing return by $FunctionName" {
      foreach($SuccessIPv4Address in $SuccessIPv4AddressList) {
        $TestCase = @{
          TestIPv4Address = $SuccessIPv4Address
        }
        It "Return should be True for $SuccessIPv4Address" -TestCases $TestCase {
          param(
            $TestIPv4Address
          )
          $ArgumentCollection = @{
            IPv4Address = $TestIPv4Address
          }
          Test-PrivateIPv4Address @ArgumentCollection |
            Should -Be $true
        }
      }
      foreach($FailureIPv4Address in $FailureIPv4AddressList) {
        $TestCase = @{
          TestIPv4Address = $FailureIPv4Address
        }
        It "Return should be False for $FailureIPv4Address" -TestCases $TestCase {
          param(
            $TestIPv4Address
          )
          $ArgumentCollection = @{
            IPv4Address = $TestIPv4Address
          }
          Test-PrivateIPv4Address @ArgumentCollection |
            Should -Be $false
        }
      }
    }
  }
}
