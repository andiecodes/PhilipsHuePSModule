<#
Author: PS_Nerd
Purpose: cmdlet File of the PhilipsHueAPi Module to communicate between PhilipsHue Smart Home Devices 
         and any device that runs PowerShell 5.1.18362.752 - 6.2.1

         More Information: https://github.com/andiecodes/PhilipsHuePSModule
                      and: https://www.psguru.org
#>

#region get-PHAPIInformation

<#
.Synopsis
   get-PHAPIInformation
.DESCRIPTION
   Long description
.EXAMPLE
   get-PHAPIInformation
.EXAMPLE 1
   get-PHAPIInformation -apiversion 
.EXAMPLE 2
   get-PHAPIInformation -name 
.EXAMPLE 3 
   get-PHAPIInformation -mac
#>
function get-PHAPIInformation
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        [switch]$apiversion,
        [switch]$name,
        [switch]$mac
    )
    Begin
    {
      $PhilipsHueBridge = load-PHBConfig
      $PHBObj = ConvertFrom-Json $(Invoke-WebRequest -Uri http://$($PhilipsHueBridge.IP)/api/config).content
    }
    Process
    {
      if($apiversion)
        {
         $PHBObj.apiversion
        }
      if($name)
        {
         $PHBObj.name
        }
      if($mac)
        {
         $PHBObj.mac
        }
      if(!$apiversion -and !$name -and !$mac )
        {
          $PHBObj
        }
    }
    End
    {
    }
}

#endregion get-PHAPIInformation
