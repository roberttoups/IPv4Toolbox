$ModuleName = 'IPv4Toolbox'
$script:FunctionName = 'Get-MyPublicIP'
$ParentPath = Split-Path -Path $PSScriptRoot -Parent
$ModulePath = Join-Path -Path $ParentPath -ChildPath "$($ModuleName).psm1"
Get-Module  -Name $ModuleName |
  Remove-Module -Force
Import-Module $ModulePath -Force

InModuleScope $ModuleName {
  Describe "Basic function unit tests for $FunctionName" -Tags @('Build', 'Unit') {
    $TestCollection = @()
    $Uri = 'https://ipv4.icanhazip.com'
    $TestCollection += [PSCustomObject]@{
      Name   = $Uri
      Result = ((Invoke-WebRequest -Uri $Uri).Content).Trim()
    }
    $Uri = 'https://v4.ident.me'
    $TestCollection += [PSCustomObject]@{
      Name   = $Uri
      Result = ((Invoke-WebRequest -Uri $Uri).Content).Trim()
    }
    $Uri = 'https://ifconfig.me/ip'
    $TestCollection += [PSCustomObject]@{
      Name   = $Uri
      Result = ((Invoke-WebRequest -Uri $Uri).Content).Trim()
    }
    $Uri = 'https://ipinfo.io/ip'
    $TestCollection += [PSCustomObject]@{
      Name   = $Uri
      Result = ((Invoke-WebRequest -Uri $Uri).Content).Trim()
    }
    Context "Testing return by $FunctionName" {
      foreach($Test in $TestCollection) {
        $Result = Get-MyPublicIp -Uri $Test.Name
        $TestCase = @{
          Result     = $Result
          TestResult = $Test.Result
        }
        It "Return should be '$($Test.Result)' for $($Test.Name)" -TestCases $TestCase {
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
