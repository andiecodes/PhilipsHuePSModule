<#
Author: PS_Nerd
Purpose: Module to Connect to Philips Hue Lights via Powershell
#>
Clear-Host

#region IMPORT cmdlets
$AllPSFiles = get-childitem -Path C:\Windows\System32\WindowsPowerShell\v1.0\Modules\PhilipsHueAPI -filter *.ps1 -Recurse | Select-Object FullName
foreach($File in $AllPSFiles){Import-Module -Name $File.FullName}
#endregion IMPORT cmdlets

#region Main


#$PhilipsHueBridge = get-PHBridge -StoreConfig

#$PhilipsHueBridgeConfig = get-PHBConfig

#get-PHapiInformation

#new-PHapiUser -Application 'WIN10User' -StoreCreds

#get-PHapiUser

#get-PHLights


#endregion Main 




