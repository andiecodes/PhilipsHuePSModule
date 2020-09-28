<#
Author: PS_Nerd
Purpose: PhilipsHueAPi Module to communicate between PhilipsHue Smart Home Devices 
         and any device that runs PowerShell 6.2.1

         More Information: https://github.com/andiecodes/PhilipsHuePSModule
                      and: https://www.psguru.org
#>
#region IMPORT cmdlets
$AllPSFiles = get-childitem -Path C:\Windows\System32\WindowsPowerShell\v1.0\Modules\PhilipsHueAPI -filter *.ps1 -Recurse | Select-Object FullName
foreach($File in $AllPSFiles){Import-Module -Name $File.FullName}
#endregion IMPORT cmdlets

#region Main - only for developing purpose

#$PhilipsHueBridge = get-PHBridge -StoreConfig

#$PhilipsHueBridgeConfig = get-PHBConfig

#get-PHapiInformation

#new-PHapiUser -Application 'WIN10User' -StoreCreds

#get-PHapiUser

#get-PHLights

#endregion Main - only for developing purpose 




