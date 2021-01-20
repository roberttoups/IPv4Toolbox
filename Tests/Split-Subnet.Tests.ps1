$ModuleName = 'IPv4Toolbox'
$script:FunctionName = 'Split-Subnet'
$ParentPath = Split-Path -Path $PSScriptRoot -Parent
$ModulePath = Join-Path -Path $ParentPath -ChildPath "$($ModuleName).psm1"
Get-Module  -Name $ModuleName |
  Remove-Module -Force
Import-Module $ModulePath -Force

InModuleScope $ModuleName {
  Describe "Basic function unit tests for $FunctionName" -Tags @('Build', 'Unit') {

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

    [System.Array]$ReferenceObject = [PSCustomObject]@{
      'SubnetId'            = '192.168.0.0'
      'BroadcastAddress'    = '192.168.0.255'
      'SubnetMask'          = '255.255.255.0'
      'Prefix'              = '24'
      'Subnet'              = '192.168.0.0/24'
      'FirstIPv4Address'    = '192.168.0.1'
      'LastIPv4Address'     = '192.168.0.254'
      'TotalHosts'          = '254'
      'AWSFirstIPv4Address' = '192.168.0.4'
      'AWSTotalHosts'       = '251'
    }

    $ReferenceObject += [PSCustomObject]@{
      'SubnetId'            = '192.168.1.0'
      'BroadcastAddress'    = '192.168.1.255'
      'SubnetMask'          = '255.255.255.0'
      'Prefix'              = '24'
      'Subnet'              = '192.168.1.0/24'
      'FirstIPv4Address'    = '192.168.1.1'
      'LastIPv4Address'     = '192.168.1.254'
      'TotalHosts'          = '254'
      'AWSFirstIPv4Address' = '192.168.1.4'
      'AWSTotalHosts'       = '251'
    }

    $ReferenceObject += [PSCustomObject]@{
      'SubnetId'            = '192.168.2.0'
      'BroadcastAddress'    = '192.168.2.255'
      'SubnetMask'          = '255.255.255.0'
      'Prefix'              = '24'
      'Subnet'              = '192.168.2.0/24'
      'FirstIPv4Address'    = '192.168.2.1'
      'LastIPv4Address'     = '192.168.2.254'
      'TotalHosts'          = '254'
      'AWSFirstIPv4Address' = '192.168.2.4'
      'AWSTotalHosts'       = '251'
    }

    $ReferenceObject += [PSCustomObject]@{
      'SubnetId'            = '192.168.3.0'
      'BroadcastAddress'    = '192.168.3.255'
      'SubnetMask'          = '255.255.255.0'
      'Prefix'              = '24'
      'Subnet'              = '192.168.3.0/24'
      'FirstIPv4Address'    = '192.168.3.1'
      'LastIPv4Address'     = '192.168.3.254'
      'TotalHosts'          = '254'
      'AWSFirstIPv4Address' = '192.168.3.4'
      'AWSTotalHosts'       = '251'
    }
    $IPv4Address = $ReferenceObject[0].SubnetId
    $TargetPrefix = $ReferenceObject[0].Prefix
    $OriginalPrefix = 22

    Context "Object returned by $FunctionName has the correct properties" {
      $TestObject = Split-Subnet -IPv4Address $IPv4Address -Prefix $OriginalPrefix -TargetPrefix $TargetPrefix
      $TestCase = @(
        $TestObject.PSObject.Properties |
          Where-Object -Property 'Name' -EQ 'SyncRoot' |
          Select-Object -ExpandProperty 'Value' |
          Get-Member -MemberType 'NoteProperty' |
          Select-Object -ExpandProperty 'Name' |
          Sort-Object -Unique
      )
      foreach ($Property in $PropertyList) {
        It "Return should have a property of $Property" -TestCases $TestCase {
          param(
            $Properties
          )
          [bool]($Properties -contains $Property) |
            Should -Be $true
        }
      }
    }

    Context 'Success /22' {
      $TestObject = Split-Subnet -IPv4Address $IPv4Address -Prefix $OriginalPrefix -TargetPrefix $TargetPrefix
      foreach($Property in $PropertyList) {
        $TestCase = @{
          ReferenceObject  = $ReferenceObject.$Property
          DifferenceObject = $TestObject.$Property
          PropertyList     = $PropertyList
        }
        It "Return the proper $Property value for $($ReferenceObject.SubnetId)" -TestCases $TestCase {
          param(
            $ReferenceObject,
            $DifferenceObject
          )

          Compare-Object -ReferenceObject $ReferenceObject -DifferenceObject $DifferenceObject |
            Should -Be $null
        }
      }
    }

    Context 'Success /23' {
      $TestObject = Split-Subnet -IPv4Address $IPv4Address -Prefix 23 -TargetPrefix $TargetPrefix
      $TestReferenceObject = $ReferenceObject[0..1]
      foreach($Property in $PropertyList) {
        $TestCase = @{
          ReferenceObject  = $TestObject.$Property
          DifferenceObject = $TestReferenceObject.$Property
        }
        It "Return the proper $Property value for $($TestObject.SubnetId)" -TestCases $TestCase {
          param(
            $ReferenceObject,
            $DifferenceObject
          )

          Compare-Object -ReferenceObject $ReferenceObject -DifferenceObject $DifferenceObject |
            Should -Be $null
        }
      }
    }

    Context 'Failure' {
      $TestObject = Split-Subnet -IPv4Address $IPv4Address -Prefix '21' -TargetPrefix $TargetPrefix
      foreach($Property in $PropertyList) {
        $TestCase = @{
          ReferenceObject  = $ReferenceObject.$Property
          DifferenceObject = $TestObject.$Property
        }
        It "Return the improper $Property value" -TestCases $TestCase {
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
}
