$ModuleName = 'IPv4Toolbox'
$script:FunctionName = 'ConvertFrom-InverseAddress'
$ParentPath = Split-Path -Path $PSScriptRoot -Parent
$ModulePath = Join-Path -Path $ParentPath -ChildPath "$($ModuleName).psm1"
Get-Module  -Name $ModuleName |
  Remove-Module -Force
Import-Module $ModulePath -Force

InModuleScope $ModuleName {
  Describe "Basic function unit tests for $FunctionName" -Tags @('Build', 'Unit') {
    $TestCollection = @()
    $TestCollection += [PSCustomObject]@{
      Answer   = '192.168.1.1'
      Question = '1.1.168.192.in-addr.arpa'
    }
    $TestCollection += [PSCustomObject]@{
      Answer   = '172.16.15.14'
      Question = '14.15.16.172.in-addr.arpa'
    }
    $TestCollection += [PSCustomObject]@{
      Answer   = '10.9.8.7'
      Question = '7.8.9.10.in-addr.arpa'
    }
    $TestCollection += [PSCustomObject]@{
      Answer   = '192.168.1.0/24'
      Question = '1.168.192.in-addr.arpa'
    }
    $TestCollection += [PSCustomObject]@{
      Answer   = '172.16.0.0/16'
      Question = '16.172.in-addr.arpa'
    }
    $TestCollection += [PSCustomObject]@{
      Answer   = '10.0.0.0/8'
      Question = '10.in-addr.arpa'
    }

    Context "Testing return by $FunctionName" {
      foreach($Test in $TestCollection) {
        $Result = ConvertFrom-InverseAddress -InverseAddress $Test.Question
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
