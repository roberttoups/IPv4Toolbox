$ModuleName = 'IPv4Toolbox'
$script:FunctionName = 'Invoke-IPv4ListSort'
$ParentPath = Split-Path -Path $PSScriptRoot -Parent
$ModulePath = Join-Path -Path $ParentPath -ChildPath "$($ModuleName).psm1"
Get-Module  -Name $ModuleName |
  Remove-Module -Force
Import-Module $ModulePath -Force

InModuleScope $ModuleName {
  Describe "Basic function unit tests for $FunctionName" -Tags @('Build', 'Unit') {
    $TestList = @(
      '192.168.1.0'
      '10.0.0.0/29'
      '182.123.123.1'
    )
    $ExpectedResult = @(
      '10.0.0.1'
      '10.0.0.2'
      '10.0.0.3'
      '10.0.0.4'
      '10.0.0.5'
      '10.0.0.6'
      '182.123.123.1'
      '192.168.1.0'
    )

    Context "Testing return by $FunctionName using $($TestList -join ',')" {
      $TestReferenceObject = Invoke-IPv4ListSort -IPv4Address $TestList
      $TestCase = @{
        ReferenceObject  = $ExpectedResult -join ','
        DifferenceObject = $TestReferenceObject -join ','
      }
      It "Return should be True for $($TestList -join ',')" -TestCases $TestCase {
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
