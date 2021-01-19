$ModuleName = 'IPv4Toolbox'
$ModuleBasePath = Split-Path -Path $PSScriptRoot -Parent
$Version = Split-Path -Path $ModuleBasePath -Leaf
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
  Copyright   = '(c) Robert M. Toups, Jr.. All rights reserved.'
  Description = 'Module to assist in the manipulation of IPv4 Addresses and Subnets.'
  Version     = $Version
  ProjectUri  = 'https://github.com/roberttoups/IPv4Toolbox'
  IconUri     = 'https://raw.githubusercontent.com/roberttoups/IPv4Toolbox/main/IPv4Toolbox/0.1.0/icons/Color-PSGallery.png'
  LicenseUri  = 'https://github.com/roberttoups/IPv4Toolbox/blob/master/LICENSE'
}
$TestSchema = $TestObject |
  Get-Member -MemberType 'NoteProperty' |
  Select-Object -ExpandProperty 'Name'
$TestTags = @('Network', 'IPv4', 'IP Address', 'Windows', 'Linux', 'macOS', 'ipcalc', 'Subnet Math', 'Split Subnets')
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
  It "The Manifest should have these tags $($TestTags -join ',')" -TestCases $TestCase {
    param(
      $CurrentItem,
      $TestItem
    )
    Compare-Object -ReferenceObject $TestItem -DifferenceObject $CurrentItem |
      Should -Be $null
  }
}
