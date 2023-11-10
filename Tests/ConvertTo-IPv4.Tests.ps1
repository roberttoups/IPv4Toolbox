$ModuleName = 'IPv4Toolbox'
$script:FunctionName = 'ConvertTo-IPv4'
$ParentPath = Split-Path -Path $PSScriptRoot -Parent
$ModulePath = Join-Path -Path $ParentPath -ChildPath "$($ModuleName).psm1"
Get-Module -Name $ModuleName |
  Remove-Module -Force
Import-Module $ModulePath -Force

InModuleScope $ModuleName {
  Describe 'ConvertTo-IPv4 Tests' {
    Context "Basic function unit tests for $FunctionName" -Tags @('Build', 'Unit') {
      It 'Converts 3232235777 to the correct IPv4 representation' {
        $Integer = 3232235777
        $Result = ConvertTo-IPv4 -Integer $Integer
        $ExpectedResult = '192.168.1.1'
        $Result | Should -Be $ExpectedResult
      }

      It 'Converts 2130706433 to the correct IPv4 representation' {
        $Integer = 2130706433
        $Result = ConvertTo-IPv4 -Integer $Integer
        $ExpectedResult = '127.0.0.1'
        $Result | Should -Be $ExpectedResult
      }

      It 'Converts 4294967295 to the correct IPv4 representation' {
        $Integer = 4294967295
        $Result = ConvertTo-IPv4 -Integer $Integer
        $ExpectedResult = '255.255.255.255'
        $Result | Should -Be $ExpectedResult
      }

      It 'throws an error for invalid input type' {
        { ConvertTo-IPv4 -Integer 'NotAnInteger' } | Should -Throw -ExpectedMessage '*Cannot process argument transformation on parameter ''Integer''. Cannot convert value "NotAnInteger" to type "System.Int64". Error: "The input string ''NotAnInteger'' was not in a correct format."*'
      }
    }
  }
}
