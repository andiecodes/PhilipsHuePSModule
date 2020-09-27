#region get-PHapiInformation

<#
.Synopsis
   get-PHapiInformation
.DESCRIPTION
   Long description
.EXAMPLE
   get-PHapiInformation
.EXAMPLE 1
   get-PHapiInformation -apiversion 
.EXAMPLE 2
   get-PHapiInformation -name 
.EXAMPLE 3 
   get-PHapiInformation -mac
#>
function get-PHapiInformation
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

#endregion get-PHapiInformation
