
#region load-PHBConfig

<#
.Synopsis
   Load Config and validated that Philips Hue Bridge is reachable 
.DESCRIPTION
   Long description
.EXAMPLE
   load-PHBConfig
#>
function load-PHBConfig
{
    if(Test-Path $($env:USERPROFILE + '\PhilipsHueBridge.xml'))
    {
      $PHBConfig = import-Clixml $($env:USERPROFILE + '\PhilipsHueBridge.xml') 
    }
    else
    {
      Write-Error "No Config File found. Please store one with the get-PHBridge -storeconfig switch!" 
    }
    if(!$(Test-Connection $PHBConfig.IP -Quiet))
    {
      Write-Error "Bridge with IP $($PHBConfig.IP) is not reachable. Try the get-PHBridge cmdlet to get the Information about the Philips Hue Bridge thats connected to your Network."
    }
    else
    {
      $PHBConfig
    }
}

#endregion load-PHBConfig
