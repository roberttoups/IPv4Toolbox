$FunctionFolderList = @('Public', 'Private')
foreach($Folder in $FunctionFolderList) {
  $FolderPath = Join-Path -Path $PSScriptRoot -ChildPath $Folder
  if(Test-Path -Path $FolderPath) {
    Write-Verbose -Message "Importing from $Folder"
    $FunctionCollection = Get-ChildItem -Path $FolderPath -Filter '*.ps1'
    foreach ($Function in $FunctionCollection) {
      Write-Verbose -Message "  Importing $($Function.BaseName)"
      . $Function.FullName
    }
  }
}
$PublicFunctionPath = Join-Path -Path $PSScriptRoot -ChildPath 'Public'
$PublicFunctionList = (Get-ChildItem -Path $PublicFunctionPath -Filter '*.ps1').BaseName
Export-ModuleMember -Function $PublicFunctionList
