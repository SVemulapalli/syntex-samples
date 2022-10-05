#!/usr/bin/env pwsh

$ErrorActionPreference = "Stop"
Set-StrictMode -Version 2.0

$foldersToMoveToDocs = "articles","contributing","models","scenario-samples","scripts","site-templates"
foreach($folder in $foldersToMoveToDocs)
{

  New-Item -Path ./main/docs -Name $folder -ItemType "directory"
  copy-item -Force ./main/$folder/* -Destination ./main/docs/$folder -Recurse

}

docfx metadata ./main/docs/docfx.json --warningsAsErrors $args
docfx build ./main/docs/docfx.json --warningsAsErrors $args

# Copy the created site to the pnpcoredocs folder (= clone of the gh-pages branch)
Remove-Item ./gh-pages/articles/* -Recurse -Force
Remove-Item ./gh-pages/contributing/* -Recurse -Force
Remove-Item ./gh-pages/models/* -Recurse -Force
Remove-Item ./gh-pages/scenario-samples/* -Recurse -Force
Remove-Item ./gh-pages/scripts/* -Recurse -Force
Remove-Item ./gh-pages/site-templates/* -Recurse -Force
copy-item -Force -Recurse ./main/docs/_site/* -Destination ./gh-pages
