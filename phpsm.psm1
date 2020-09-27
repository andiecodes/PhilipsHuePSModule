<#
Author: PS_Nerd
Purpose: Module to Connect to Philips Hue Lights via Powershell
#>
#cls

#region IMPORT cmdlets
$AllPSFiles = get-childitem -filter *.ps1 | Select-Object FullName
foreach($File in $AllPSFiles){Import-Module -Name $File.FullName}
#endregion IMPORT cmdlets

#region Main


#$PhilipsHueBridge = get-PHBridge -StoreConfig

#$PhilipsHueBridgeConfig = load-PHBConfig

#get-PHapiInformation

#new-PHapiUser -Application 'User123' -StoreCreds

#get-PHapiUser

#get-PHLights


#endregion Main 




