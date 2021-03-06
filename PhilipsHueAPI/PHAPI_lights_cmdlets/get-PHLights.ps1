<#
Author: PS_Nerd
Purpose: cmdlet File of the PhilipsHueAPi Module to communicate between PhilipsHue Smart Home Devices 
         and any device that runs PowerShell 5.1.18362.752 - 6.2.1

         More Information: https://github.com/andiecodes/PhilipsHuePSModule
                      and: https://www.psguru.org
#>

#region get-PHLights

<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function get-PHLights
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (

    )

    Begin
    {
    $PhilipsHueBridgeConfig = get-PHBConfig
    $PHUser = get-PHapiUser
    $PHLights = $(Invoke-WebRequest "http://$($PhilipsHueBridgeConfig.IP)/api/$PHUser/lights") | convertfrom-json
    }
    Process
    {
      $PHLights
    }
    End
    {
    }
}



#endregion get-PHLights
