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