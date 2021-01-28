$ModuleName = 'IPv4Toolbox'
$script:FunctionName = 'Find-IPv4Address'
$ParentPath = Split-Path -Path $PSScriptRoot -Parent
$ModulePath = Join-Path -Path $ParentPath -ChildPath "$($ModuleName).psm1"
Get-Module  -Name $ModuleName |
  Remove-Module -Force
Import-Module $ModulePath -Force

InModuleScope $ModuleName {
  Describe "Basic function unit tests for $FunctionName" -Tags @('Build', 'Unit') {
    $TestText = @"
2021-01-27 07:39:30,026 fail2ban.filter         [837]: INFO    [dropbear] Found 121.98.80.90
2021-01-27 07:39:34,500 fail2ban.filter         [837]: INFO    [dropbear] Found 132.98.80.91
2021-01-27 07:39:42,066 fail2ban.filter         [837]: INFO    [dropbear] Found 191.98.80.93
2021-01-27 07:39:46,333 fail2ban.filter         [837]: INFO    [dropbear] Found 341.98.80.29
2021-01-27 07:39:49,728 fail2ban.filter         [837]: INFO    [dropbear] Found 641.98.80.89
2021-01-27 07:39:52,972 fail2ban.filter         [837]: INFO    [dropbear] Found 14.98.80.90
2021-01-27 07:39:52,972 fail2ban.filter         [837]: INFO    [dropbear] Found 1.1.1.1
192.168.1.1,10.0.0.1,172.18.0.1,[[ERROR]] 4.2.2.1 8,8,8,8
"@
    $ShouldBe = DATA {
      '121.98.80.90'
      '132.98.80.91'
      '191.98.80.93'
      '14.98.80.90'
      '1.1.1.1'
      '192.168.1.1'
      '10.0.0.1'
      '172.18.0.1'
      '4.2.2.1'
    }
    Context "Testing return by $FunctionName" {
      $TestCase = @{
        TestText = $TestText
        ShouldBe = $ShouldBe
      }
      It "Return should be $($ShouldBe -join ',')" -TestCases $TestCase {
        param(
          $TestText,
          $ShouldBe
        )
        $ArgumentCollection = @{
          Text = $TestText
        }
        Find-IPv4Address @ArgumentCollection |
          Should -Be $ShouldBe
      }
      It "Return should be $($ShouldBe -join ',') from the pipeline" -TestCases $TestCase {
        param(
          $TestText,
          $ShouldBe
        )
        $TestText |
          Find-IPv4Address |
          Should -Be $ShouldBe
      }
    }
  }
}
