<#
Script Name: Configure-Terminal.ps1
Author: Dark-Coffee
Version: 0.2.0
Updated: 2020-02-10
Url: https://github.com/dark-coffee/Configure-Terminal
#>

<#
.Description
    Configures powershell terminal using custom modules from github.
#>

$ModuleLocation      = "$ENV:UserProfile\Documents\WindowsPowershell\Modules\dark-coffee"
$ManifestURL         =  "https://raw.githubusercontent.com/dark-coffee/Configure-Terminal/master/manifest.txt"
$ManifestDestination = "$ModuleLocation\manifest.txt"

if(!(Test-Path $ModuleLocation)){ New-Item -Path $ModuleLocation -ItemType Directory -Force }

Start-BitsTransfer -Source $ManifestURL -Destination $ManifestDestination

$Manifest = Get-Content $ManifestDestination

foreach($Url in $Manifest){
    $Filename = $Url -replace ".*/*/"
    Start-BitsTransfer -Source $Url -Destination "$ModuleLocation\$Filename"
}

Import-Module dark-coffee
