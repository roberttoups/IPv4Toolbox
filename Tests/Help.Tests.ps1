$script:ModuleName = 'IPv4Toolbox'

$ModuleBasePath = Split-Path -Path $PSScriptRoot -Parent

$ExceptionsPath = Join-Path -Path $PSScriptRoot -ChildPath 'Help.Exceptions.txt'
# Get the list of functions we are not going to run tests against
if((Test-Path -Path $ExceptionsPath) -eq $false) {
  throw "Unable to locate $ExceptionsPath"
}
$FunctionHelpTestExceptions = Get-Content -Path $ExceptionsPath

# Removes all versions of the module from the session before importing
Get-Module -Name $ModuleName |
  Remove-Module

$ModulePath = Join-Path -Path $ModuleBasePath -ChildPath "$ModuleName.psd1"
$Module = Import-Module -Name $ModulePath -PassThru -ErrorAction 'Stop'
$CommandList = Get-Command -Module $Module -CommandType Cmdlet, Function  # Not alias

## When testing help, remember that help is cached at the beginning of each session.
## To test, restart session.
# InModuleScope 'IPv4Toolbox' {
foreach ($Command in $CommandList) {
  $CommandName = $Command.Name

  # Skip all functions that are on the exclusions list
  if ($script:FunctionHelpTestExceptions -contains $CommandName) { continue } ## may not be correct check with a function that needs exceptions

  # The module-qualified command fails on Microsoft.PowerShell.Archive CmdLets
  $script:Help = Get-Help $CommandName -ErrorAction 'SilentlyContinue'

  Describe "Test help for $CommandName" -Tag 'Help' {

    Context "Test documentation elements for $CommandName" {
      # If help is not found, synopsis in auto-generated help is the syntax diagram
      It "Should not be auto-generated" {
        $Help.Synopsis |
          Should -Not -BeLike '*`[`<CommonParameters`>`]*'
      }

      # Should be a description for every function
      It "Gets description for $CommandName" {
        $Help.Description |
          Should -Not -BeNullOrEmpty
      }

      # Should be at least one example
      It "Gets example code from $CommandName" {
        ($Help.Examples.Example |
            Select-Object -First 1).Code |
            Should -Not -BeNullOrEmpty
      }

      # Should be at least one example description
      It "Gets example help from $CommandName" {
        ($Help.Examples.Example.Remarks |
            Select-Object -First 1).Text |
            Should -Not -BeNullOrEmpty
      }
    }

    Context "Test parameter help for $CommandName" {

      $Common = @(
        'Debug'
        'ErrorAction'
        'ErrorVariable'
        'InformationAction'
        'InformationVariable'
        'OutBuffer'
        'OutVariable'
        'PipelineVariable'
        'Verbose'
        'WarningAction'
        'WarningVariable'
      )

      $ParameterCollection = $Command.ParameterSets.Parameters |
        Sort-Object -Property Name -Unique |
        Where-Object -Property Name -NotIn $common
      $ParameterNameList = @($ParameterCollection.Name)
      $HelpParameterNames = @($Help.Parameters.Parameter.Name |
          Sort-Object -Unique
      )
      foreach ($Parameter in $ParameterCollection) {
        $ParameterName = $Parameter.Name
        $script:ParameterHelp = $Help.Parameters.Parameter |
          Where-Object 'Name' -EQ $ParameterName
        # Should be a description for every parameter
        It "Gets help for parameter: $ParameterName : in $CommandName" {
          # Write-Host $ParameterHelp.Description.Text
          $ParameterHelp.Description.Text |
            Should -Not -BeNullOrEmpty
        }

        $script:CodeMandatory = $Parameter.IsMandatory.toString()
        # Required value in Help should match IsMandatory property of parameter
        It "Help for $ParameterName parameter in $CommandName has correct Mandatory value" {
          $ParameterHelp.Required |
            Should -Be $CodeMandatory
        }

        # Parameter type in Help should match code
        $script:CodeType = $Parameter.ParameterType.Name
        It "Help for $CommandName has correct parameter type for $ParameterName" {
          # To avoid calling Trim method on a null object.
          $HelpType = if ($ParameterHelp.ParameterValue) { $ParameterHelp.ParameterValue.Trim() }
          $HelpType |
            Should -Be $CodeType
        }
      }

      foreach ($HelpParameterName in $HelpParameterNames) {
        # Shouldn't find extra parameters in help.
        It "Finds help parameter in code: $HelpParameterName" {
          $HelpParameterName -in $ParameterNameList |
            Should -Be $true
        }
      }
    }
  }
}
