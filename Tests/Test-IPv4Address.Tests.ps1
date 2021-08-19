$ModuleName = 'IPv4Toolbox'
$script:FunctionName = 'Test-IPv4Address'
$ParentPath = Split-Path -Path $PSScriptRoot -Parent
$ModulePath = Join-Path -Path $ParentPath -ChildPath "$($ModuleName).psm1"
Get-Module  -Name $ModuleName |
  Remove-Module -Force
Import-Module $ModulePath -Force

InModuleScope $ModuleName {
  Describe "Basic function unit tests for $FunctionName" -Tags @('Build', 'Unit') {
    $TestCollection = @()
    $TestList = @(Out-SubnetRange -Subnet '10.12.0.0' -Prefix 28)
    foreach($Test in $TestList) {
      $TestCollection += [PSCustomObject]@{
        Question = $Test
        Answer   = $true
      }
    }
    $TestList = @(Out-SubnetRange -Subnet '192.168.100.16' -Prefix 28)
    foreach($Test in $TestList) {
      $TestCollection += [PSCustomObject]@{
        Question = $Test
        Answer   = $true
      }
    }
    $TestList = @(Out-SubnetRange -Subnet '172.16.20.32' -Prefix 28)
    foreach($Test in $TestList) {
      $TestCollection += [PSCustomObject]@{
        Question = $Test
        Answer   = $true
      }
    }
    $TestCollection += [PSCustomObject]@{
      Question = '192.apple.1.1'
      Answer   = $false
    }
    $TestCollection += [PSCustomObject]@{
      Question = '255.255.255.255'
      Answer   = $true
    }
    $TestCollection += [PSCustomObject]@{
      Question = '0.0.0.0'
      Answer   = $true
    }
    $TestCollection += [PSCustomObject]@{
      Question = '172.16.324.2'
      Answer   = $false
    }
    $TestCollection += [PSCustomObject]@{
      Question = '172.16.1.2.0'
      Answer   = $false
    }
    $TestCollection += [PSCustomObject]@{
      Question = '2607:fb90:5c0:786d:cb5d:b590:8254:1b00'
      Answer   = $false
    }
    Context "Testing return by $FunctionName" {
      foreach($Test in $TestCollection) {
        $Result = Test-IPv4Address -IPv4Address $Test.Question
        $TestCase = @{
          Result     = $Result
          TestResult = $Test.Answer
        }
        It "Return should be '$($Test.Answer)' for $($Test.Question)" -TestCases $TestCase {
          param (
            $Result,
            $TestResult
          )
          $Result -eq $TestResult |
            Should -Be $true
        }
      }
    }
  }
}
