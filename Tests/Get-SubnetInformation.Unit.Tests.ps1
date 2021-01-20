$ModuleName = 'IPv4Toolbox'
$ParentPath = Split-Path -Path $PSScriptRoot -Parent
$ModulePath = Join-Path -Path $ParentPath -ChildPath "$($ModuleName).psm1"
Get-Module  -Name $ModuleName |
  Remove-Module -Force
Import-Module $ModulePath -Force
InModuleScope $ModuleName {
  Describe 'Basic function unit tests for Get-SubnetInformation' -Tags @('Build', 'Unit') {

    $PropertyList = @(
      'AWSFirstIPv4Address'
      'AWSTotalHosts'
      'BroadcastAddress'
      'FirstIPv4Address'
      'LastIPv4Address'
      'Prefix'
      'Subnet'
      'SubnetId'
      'SubnetMask'
      'TotalHosts'
    )

    $ReferenceObject = [PSCustomObject]@{
      SubnetId            = '192.168.0.0'
      BroadcastAddress    = '192.168.0.255'
      SubnetMask          = '255.255.255.0'
      Prefix              = 24
      Subnet              = '192.168.0.0/24'
      FirstIPv4Address    = '192.168.0.1'
      LastIPv4Address     = '192.168.0.254'
      TotalHosts          = 254
      AWSFirstIPv4Address = '192.168.0.4'
      AWSTotalHosts       = 251
    }

    $IPv4Address = $ReferenceObject.SubnetId
    $Prefix = $ReferenceObject.Prefix
    $SubnetMask = $ReferenceObject.SubnetMask

    Context 'Object returned by Get-SubnetInformation has the correct properties' {
      $TestObject = Get-SubnetInformation -IPv4Address $IPv4Address -Prefix $Prefix
      foreach ($Property in $PropertyList) {
        $TestCase = @{
          Properties = @(
            $TestObject |
              Get-Member -MemberType 'NoteProperty' |
              Select-Object -ExpandProperty 'Name' |
              Sort-Object -Unique
          )
          Property   = $Property
        }

        It "Return should have a property of $Property" -TestCases $TestCase {
          param(
            $Properties,
            $Property
          )
          $Properties -contains $Property |
            Should -Be $true
        }
      }
    }

    Context 'Simple Output with Prefix' {
      $TestObject = Get-SubnetInformation -IPv4Address $IPv4Address -Prefix $Prefix
      foreach($Property in $PropertyList) {
        $TestCase = @{
          ReferenceObject  = $ReferenceObject.$Property
          DifferenceObject = $TestObject.$Property
        }
        It "Return the proper $Property value for $($ReferenceObject.SubnetId)" -TestCases $TestCase {
          param(
            $ReferenceObject,
            $DifferenceObject
          )
          $DifferenceObject |
            Should -Be $ReferenceObject
        }
      }
    }

    Context 'Simple Output with SubnetMask' {
      $TestObject = Get-SubnetInformation -IPv4Address $IPv4Address -Mask $SubnetMask
      foreach($Property in $PropertyList) {
        $TestCase = @{
          ReferenceObject  = $ReferenceObject.$Property
          DifferenceObject = $TestObject.$Property
        }
        It "Return the proper $Property value for $($ReferenceObject.SubnetId)" -TestCases $TestCase {
          param(
            $ReferenceObject,
            $DifferenceObject
          )
          $DifferenceObject |
            Should -Be $ReferenceObject
        }
      }
    }
  }
}
