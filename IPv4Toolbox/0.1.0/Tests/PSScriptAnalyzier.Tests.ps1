$PublicPath = Join-Path -Path "$(Split-Path $PSScriptRoot -Parent)" -ChildPath 'Public'
$PrivatePath = Join-Path -Path "$(Split-Path $PSScriptRoot -Parent)" -ChildPath 'Private'
$ScriptCollection = Get-ChildItem -Path $PrivatePath -Filter '*.ps1' -Recurse
$ScriptCollection += Get-ChildItem -Path $PublicPath -Filter '*.ps1' -Recurse

if($ScriptCollection.Count -gt 0) {
  Describe 'PSScriptAnalyzer analysis' {
    It "<Path> Should not violate: <IncludeRule>" -TestCases @(
      foreach($Script in $ScriptCollection) {
        foreach($Rule in (Get-ScriptAnalyzerRule)) {
          @{
            IncludeRule = $Rule.RuleName
            Path        = $Script.FullName
          }
        }
      }
    ) {
      param(
        $IncludeRule,
        $Path
      )
      Invoke-ScriptAnalyzer -Path $Path -IncludeRule $IncludeRule |
        Should -BeNullOrEmpty
    }
  }
}
