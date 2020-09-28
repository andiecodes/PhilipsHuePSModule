

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
.EXAMPLE 5
   get-PHBridge -StoreConfig
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



#get-PHBridge