$ModuleName = 'IPv4Toolbox'
$ModuleBasePath = Split-Path -Path $PSScriptRoot -Parent
$ModulePath = Join-Path -Path $ModuleBasePath -ChildPath "$ModuleName.psd1"
if((Test-Path -Path $ModulePath) -eq $false) {
  throw "Unable to locate $ModulePath"
}
$ManifestTest = Test-ModuleManifest -Path $ModulePath
$TestObject = [PSCustomObject]@{
  Name        = 'IPv4Toolbox'
  Guid        = 'b1a4c4a0-f480-4831-a6e0-141487f746b4'
  Author      = 'Robert M. Toups, Jr.'
  CompanyName = 'Toups Design Bureau'
  Copyright   = '(c) 2021 Robert M. Toups, Jr., All rights reserved.'
  Description = 'Module to assist in the manipulation of IPv4 Addresses and Subnets.'
  Version     = '0.6.0'
  ProjectUri  = 'https://github.com/roberttoups/IPv4Toolbox'
  IconUri     = 'https://raw.githubusercontent.com/roberttoups/IPv4Toolbox/master/icons/Color-PSGallery.png'
  LicenseUri  = 'https://github.com/roberttoups/IPv4Toolbox/blob/master/LICENSE'
}
$TestSchema = $TestObject |
  Get-Member -MemberType 'NoteProperty' |
  Select-Object -ExpandProperty 'Name'
$TestTags = @('Network', 'IPv4', 'IPAddress', 'Windows', 'Linux', 'macOS', 'ipcalc', 'Subnet', 'Subnets', 'PSEdition_Desktop', 'PSEdition_Core')
$CurrentTags = $ManifestTest.Tags |
  Sort-Object -Unique
Describe "Manifest Test for $ModuleName" -Tag 'Manifest' {
  foreach($Item in $TestSchema) {
    $TestCase = @{
      CurrentItem = $ManifestTest.$Item
      TestItem    = $TestObject.$Item
    }
    # $TestItem = $ManifestTest.$Item
    It "The Manifest $Item should be $($TestObject.$Item)" -TestCases $TestCase {
      param(
        $CurrentItem,
        $TestItem
      )
      $CurrentItem |
        Should -Be $TestItem
    }
  }
  $TestCase = @{
    CurrentItem = $CurrentTags
    TestItem    = $TestTags
  }
  It "The Manifest should have these tags $($TestTags -join ', ')" -TestCases $TestCase {
    param(
      $CurrentItem,
      $TestItem
    )
    Compare-Object -ReferenceObject $TestItem -DifferenceObject $CurrentItem |
      Should -Be $null
  }
  $TestCase = @{
    CurrentTags = $CurrentTags
  }
  It "The Manifest tags can only be one word each" -TestCases $TestCase {
    param(
      $CurrentTags
    )
    foreach($CurrentTag in $CurrentTags) {
      @($CurrentTag.Split[' ']).Count |
        Should -Be 1
    }
  }
}
