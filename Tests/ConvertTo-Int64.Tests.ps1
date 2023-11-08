$ModuleName = 'IPv4Toolbox'
$script:FunctionName = 'ConvertTo-Int64'
$ParentPath = Split-Path -Path $PSScriptRoot -Parent
$ModulePath = Join-Path -Path $ParentPath -ChildPath "$($ModuleName).psm1"
Get-Module -Name $ModuleName |
  Remove-Module -Force
Import-Module $ModulePath -Force

InModuleScope $ModuleName {
  Describe 'ConvertTo-Int64 Tests' {
    Context "Basic function unit tests for $FunctionName" -Tags @('Build', 'Unit') {
      It "Converts '192.168.1.1' to the correct Int64" {
        $Result = ConvertTo-Int64 -IPv4Address '192.168.1.1'
        $Result | Should -BeExactly 3232235777
      }

      It "Converts '127.0.0.1' to the correct Int64" {
        $Result = ConvertTo-Int64 -IPv4Address '127.0.0.1'
        $Result | Should -BeExactly 2130706433
      }

      It "Converts '255.255.255.255' to the correct Int64" {
        $Result = ConvertTo-Int64 -IPv4Address '255.255.255.255'
        $Result | Should -BeExactly 4294967295
      }
      It "Throws an error for invalid IPv4 address '999.999.999.999'" {
        { ConvertTo-Int64 -IPv4Address '999.999.999.999' } | Should -Throw -ExpectedMessage '*Cannot validate argument on parameter ''IPv4Address''*'
      }
    }
  }
}
