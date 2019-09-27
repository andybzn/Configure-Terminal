#Script Name: #Configure-Terminal
#Creator: Dark-Coffee
#Version: 0.0.4
#Updated: 27th September 2019
#Url: https://github.com/dark-coffee/Configure-Terminal

#Pulls a custom manifest for my ps setup, downloads assoc scripts, imports.
if (Test-Path "$pwd\down"){}else{ New-Item -Path "$PWD\down\" -ItemType Directory }

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