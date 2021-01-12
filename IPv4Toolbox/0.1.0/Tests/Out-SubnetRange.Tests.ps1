$ModuleName = 'IPv4Toolbox'
$script:FunctionName = 'Out-SubnetRange'
$ParentPath = Split-Path -Path $PSScriptRoot -Parent
$ModulePath = Join-Path -Path $ParentPath -ChildPath "$($ModuleName).psm1"
Get-Module  -Name $ModuleName |
  Remove-Module -Force
Import-Module $ModulePath -Force

InModuleScope $ModuleName {
  Describe "Basic function unit tests for $FunctionName" -Tags @('Build', 'Unit') {
    $SourceSubnet = '192.168.1.0'
    $SourcePrefix = 28
    $TargetList = @(
      '192.168.1.1'
      '192.168.1.2'
      '192.168.1.3'
      '192.168.1.4'
      '192.168.1.5'
      '192.168.1.6'
      '192.168.1.7'
      '192.168.1.8'
      '192.168.1.9'
      '192.168.1.10'
      '192.168.1.11'
      '192.168.1.12'
      '192.168.1.13'
      '192.168.1.14'
    )

    Context "Testing return by $FunctionName using $SourceSubnet/$SourcePrefix" {
      $Result = Out-SubnetRange -Subnet $SourceSubnet -Prefix $SourcePrefix
      $TestCase = @{
        Count = [int32]$Result.Count
      }
      It "Return should be 14 for number of IPv4 Addresses returned" -TestCases $TestCase {
        param (
          [int32]$Count
        )
        $Count -eq 14 |
          Should -Be $true
      }

      $TestCase = @{
        ReferenceObject  = $TargetList
        DifferenceObject = $Result
      }
      It "Return should be True for $SourceSubnet/$SourcePrefix" -TestCases $TestCase {
        param(
          $ReferenceObject,
          $DifferenceObject
        )
        Compare-Object -ReferenceObject $ReferenceObject -DifferenceObject $DifferenceObject |
          Should -Be $null
      }

      $Result = Out-SubnetRange -Subnet $SourceSubnet -Prefix ($SourcePrefix - 1)
      $TestCase = @{
        ReferenceObject  = $TargetList
        DifferenceObject = $Result
      }
      It "Return should be False for $SourceSubnet/$($SourcePrefix-1)" -TestCases $TestCase {
        param(
          $ReferenceObject,
          $DifferenceObject
        )
        Compare-Object -ReferenceObject $ReferenceObject -DifferenceObject $DifferenceObject |
          Should -Not -Be $null
      }
    }

  }
}
