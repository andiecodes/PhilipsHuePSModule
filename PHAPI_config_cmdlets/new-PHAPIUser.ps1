#region new-PHAPIUser

<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   new-PHAPIUser -Application
.EXAMPLE 1
   new-PHAPIUser -Application -StoreCreds
#>
function new-PHAPIUser
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
      $PHUser 
    }
}


#endregion new-PHAPIUser
