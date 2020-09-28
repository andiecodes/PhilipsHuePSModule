<#
Author: PS_Nerd
Purpose: cmdlet File of the PhilipsHueAPi Module to communicate between PhilipsHue Smart Home Devices 
         and any device that runs PowerShell 6.2.1

         More Information: https://github.com/andiecodes/PhilipsHuePSModule
                      and: https://www.psguru.org
#>

#region get-PHAPIUser

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
function get-PHAPIUser
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
    )
    Begin
    {
      if($(Get-ChildItem $env:USERPROFILE -Filter *.xml | Where-Object Name -Like 'PhilipsHueBridgeUserData_*').count -gt 1)
       {
        Write-Host "More than one User found in your Application Folder."
        $Users = Get-ChildItem $env:USERPROFILE -Filter *.xml | Where-Object Name -Like 'PhilipsHueBridgeUserData_*'
        $USRArray = @()
        $i = 1
        foreach($User in $Users)
        {
          $PHBUserObject = New-Object PSObject
          $PHBUserObject | add-member Noteproperty User $User.Name 
          $PHBUserObject | add-member Noteproperty Number $i
          $USRArray += $PHBUserObject
          $i++
        }
        $USRArray | Format-Table
        $File = Read-Host "Please choose the User Number you want to use to login " 
        $FileName = $USRArray | Where-Object Number -EQ $File
        $UserRaw = $(Import-Clixml $($env:USERPROFILE + "\$($FileName.User)") | convertfrom-json).success.username
       }
      else
        {
          $User = Get-ChildItem $env:USERPROFILE -Filter *.xml | Where-Object Name -Like 'PhilipsHueBridgeUserData_*'
          $UserRaw =  $(Import-Clixml $($env:USERPROFILE + "\$($User.Name)") | convertfrom-json).success.username
        }
      $UserRaw
    }
    Process
    {
    }
    End
    {
    }
}


#endregion get-PHAPIUser
