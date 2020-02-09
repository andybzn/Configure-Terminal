<#
Script Name: Configure-Terminal.ps1
Author: Dark-Coffee
Version: 0.1.0
Updated: 2020-02-09
Url: https://github.com/dark-coffee/Configure-Terminal
#>

<#
.Description
    Configures powershell terminal using custom modules from github.
#>

if (!(Test-Path "$pwd\down")){ New-Item -Path "$PWD\down\" -ItemType Directory }

$ManifestUrl =  "https://raw.githubusercontent.com/dark-coffee/Configure-Terminal/master/manifest.txt"
$ManifestDest = "$PWD\down\manifest.txt"
Invoke-WebRequest -Uri $ManifestUrl -OutFile $ManifestDest

$Manifest = Get-Content $ManifestDest 
foreach($Url in $Manifest){
    $Filename = $Url -replace ".*/*/"
    Invoke-WebRequest -Uri $Url -OutFile "$pwd\down\$Filename"
}

$scripts = Get-ChildItem -path $pwd\down -Filter "*.ps1"
foreach($script in $scripts){
    import-module $script
}
