<#
Author: PS_Nerd
Purpose: Module to Connect to Philips Hue Lights via Powershell
#>

#region cmdlets

#region get-PHBridge

<#
.Synopsis
   Returns Information about existing Philips Hue Bridges
.DESCRIPTION
   I'm using the supported UPnPDeviceFinder to detect the Bridge
   After this step i store the Information from http://YourPhilipsHueBridgeIP/description.xml
   in a PS-Object. This cmldet has several switches like -IP or -SerialNumber, see Examples...
   It also includes an Error handler if no Device with the ModelName '*Philips hue bridge*' was found.
   It's recommended to store the Information about your Hue Bridge, because the detection took a while. 
.EXAMPLE
   get-PHBridge
.EXAMPLE 1
   get-PHBridge -IP
.EXAMPLE 2
   get-PHBridge -PresentationURL
.EXAMPLE 3
   get-PHBridge -UUID
.EXAMPLE 4
   get-PHBridge -ModelNumber
.EXAMPLE 5
   get-PHBridge -SerialNumber
#>
function get-PHBridge
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        [switch]$IP,
        [switch]$PresentationURL,
        [switch]$UUID,
        [switch]$ModelNumber,
        [switch]$SerialNumber,
        [switch]$StoreConfig
    )

    Begin
    {
      $ssdpFinder = New-Object -ComObject 'UPnP.UPnPDeviceFinder'
      $HueBridgeInfo = $ssdpFinder.FindByType('upnp:rootdevice', 0) | Where-Object ModelName -Like '*Philips hue bridge*'
      if($HueBridgeInfo)
      {
       [xml]$PHBXML = $(Invoke-WebRequest $($HueBridgeInfo.PresentationURL).Replace('index.html','description.xml')).content
      }
      else
      {
        Write-Error "No Philips Hue Bridge detected in this Network."
      }
      $PHBObject = New-Object PSObject
      $PHBObject | add-member Noteproperty IP $($($PHBXML.root.URLBase).Split(':')[1]).replace('/','')
      $PHBObject | add-member Noteproperty Port $($($PHBXML.root.URLBase).Split(':')[2]).replace('/','')
      $PHBObject | add-member Noteproperty PresentationURL $HueBridgeInfo.PresentationURL
      $PHBObject | add-member Noteproperty UUID $PHBXML.root.device.udn
      $PHBObject | add-member Noteproperty ModelName $PHBXML.root.device.modelName
      $PHBObject | add-member Noteproperty ModelNumber $PHBXML.root.device.modelNumber
      $PHBObject | add-member Noteproperty SerialNumber $PHBXML.root.device.serialNumber
      $PHBObject | add-member Noteproperty deviceType $PHBXML.root.device.deviceType
      $PHBObject | add-member Noteproperty DescriptionXML $($HueBridgeInfo.PresentationURL).Replace('index.html','description.xml')
    }
    Process
    {
      if($IP)
        {
          $PHBObject.IP
        }
      if($PresentationURL)
        {
          $PHBObject.PresentationURL
        }
      if($UUID)
        {
          $PHBObject.UUID
        }
      if($ModelNumber)
        {
          $PHBObject.ModelNumber
        }
      if($SerialNumber)
        {
          $PHBObject.SerialNumber
        }
      if($StoreConfig)
        {
          $PHBObject | Export-Clixml $($env:USERPROFILE + '\PhilipsHueBridge.xml') 
        }
      if(!$IP -and !$PresentationURL -and !$UUID -and !$ModelNumber -and !$SerialNumber)
        {
          $PHBObject
        }
    }
    End
    {

    }
}

#endregion get-PHBridge

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

#region get-PHapiUser

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
function get-PHapiUser
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
        $USRArray | ft
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


#endregion get-PHapiUser

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


#endregion cmdlets

#$PhilipsHueBridge = get-PHBridge -StoreConfig
#cls
#$PhilipsHueBridgeConfig = load-PHBConfig

#get-PHapiInformation

#new-PHapiUser -Application 'User123' -StoreCreds

#get-PHapiUser

get-PHLights


