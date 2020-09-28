
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
    $PhilipsHueBridgeConfig = load-PHBConfig
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
