<#
Author: PS_Nerd
Purpose: cmdlet File of the PhilipsHueAPi Module to communicate between PhilipsHue Smart Home Devices 
         and any device that runs PowerShell 6.2.1

         More Information: https://github.com/andiecodes/PhilipsHuePSModule
                      and: https://www.psguru.org
#>

#region get-PHBConfig

<#
.Synopsis
   Load Config and validated that Philips Hue Bridge is reachable 
.DESCRIPTION
   Long description
.EXAMPLE
   get-PHBConfig
#>
function get-PHBConfig
{
    if(Test-Path $($env:USERPROFILE + '\PhilipsHueBridge.xml'))
    {
      $PHBConfig = import-Clixml $($env:USERPROFILE + '\PhilipsHueBridge.xml') 
    }
    else
    {
      Write-Error "No Config File found. Please store one with the get-PHBridge -storeconfig switch!" 
    }
    # -InformationAction should not be needed if -quiet is used
    if(!$(Test-Connection $PHBConfig.IP -Quiet -InformationAction Ignore -Count 1))
    {
      Write-Error "Bridge with IP $($PHBConfig.IP) is not reachable. Try the get-PHBridge cmdlet to get the Information about the Philips Hue Bridge thats connected to your Network."
    }
    else
    {
      $PHBConfig
    }
}
#endregion get-PHBConfig
