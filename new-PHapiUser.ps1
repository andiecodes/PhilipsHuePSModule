#region new-PHapiUser

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
function new-PHapiUser
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
      [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)][string]$Application,
      [switch]$StoreCreds
    )

    Begin
    {
      $body = "{`"devicetype`": `"$Application`"}"
      $PhilipsHueBridgeConfig = load-PHBConfig
      $PHUser = $(Invoke-WebRequest "http://$($PhilipsHueBridgeConfig.IP)/api/" -Method Post -Body $body).content
      $PHUser 
    }
    Process
    {
      if($StoreCreds)
      {
        $PHUser | Export-Clixml $($env:USERPROFILE + "\PhilipsHueBridgeUserData_$Application.xml")
      }
    }
    End
    {

    }
}


#endregion new-PHapiUser
