$ModuleName = 'IPv4Toolbox'
$script:FunctionName = 'ConvertTo-DecimalIP'
$ParentPath = Split-Path -Path $PSScriptRoot -Parent
$ModulePath = Join-Path -Path $ParentPath -ChildPath "$($ModuleName).psm1"
Get-Module -Name $ModuleName |
  Remove-Module -Force
Import-Module $ModulePath -Force

InModuleScope $ModuleName {
  Describe 'ConvertTo-DecimalIP Tests' {
    Context "Basic function unit tests for $FunctionName" -Tags @('Build', 'Unit') {
      It "converts [System.Net.IPAddress]::Parse('192.168.1.1') to the correct decimal representation" {
        $IPv4Address = [System.Net.IPAddress]::Parse('192.168.1.1')
        $Result = ConvertTo-DecimalIP -IPAddressObject $IPv4Address
        $ExpectedResult = 3232235777
        $Result | Should -Be $ExpectedResult
      }

      It "converts [System.Net.IPAddress]::Parse('127.0.0.1') to the correct decimal representation" {
        $IPv4Address = [System.Net.IPAddress]::Parse('127.0.0.1')
        $Result = ConvertTo-DecimalIP -IPAddressObject $IPv4Address
        $ExpectedResult = 2130706433
        $Result | Should -Be $ExpectedResult
      }

      It "converts [System.Net.IPAddress]::Parse('255.255.255.255') to the correct decimal representation" {
        $IPv4Address = [System.Net.IPAddress]::Parse('255.255.255.255')
        $Result = ConvertTo-DecimalIP -IPAddressObject $IPv4Address
        $ExpectedResult = 4294967295
        $Result | Should -Be $ExpectedResult
      }

      It 'throws an error for invalid input type' {
        { ConvertTo-DecimalIP -IPAddressObject 'NotAnIPAddressObject' } | Should -Throw -ExpectedMessage '*Cannot convert value*to type "System.Net.IPAddress". Error: "An invalid IP address was specified."*'
      }

    }
  }
}
