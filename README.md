# PhilipsHueAPI Module
The PhilipsHueAPI Module for PowerShell allows you to communicate between your PhilipsHue Smart Home Devices and any Device that runs PowerShell 5.1.18362.752 - 6.2.1. You can detect a Philips Hue Bridge in your Network `get-PHBridge`, store the config `get-PHBridge -StoreConfig`, read local config `get-PHBConfig`, create new api user `new-PHAPIUser` and get all lights that are installed in your Smart Home `get-PHLights`. It's based on the [API Developer Guide Version 1.0](https://developers.meethue.com/)

[Download the Zip](https://github.com/andiecodes/PhilipsHuePSModule/archive/master.zip), extract it, copy the Folder **PhilipsHueAPI** to **C:\Windows\System32\WindowsPowerShell\v1.0\Modules**

If the Module was added to your Modules Folder, you can run `Import-Module PhilipsHueAPI` to use the PHAPI-cmdlets.

[PhilipsHue API ChangeLOG](https://developers.meethue.com/develop/hue-api/api-documentation-changelog/)

##### Further cmdlets  `get-PHGroups`, `get-PHScenes`, `get-PHSchedul`, `get-PHSensors`

## [PHBridge cmdlets](https://github.com/andiecodes/PhilipsHuePSModule/tree/master/PHBridge_config_cmdlets)

The first thing you need to do is, detect your Philips Hue Bridge with the `get-PHBridge` cmdlet.
```pwsh
 IP              : 192.168.1.15
 Port            : 80
 PresentationURL : http://192.168.1.15/index.html
 UUID            : uuid:2f502e80-df50-33e1-9b23-004788af86ab
 ModelName       : Philips hue bridge 2015
 ModelNumber     : BSB002
 SerialNumber    : 001288af70fb
 deviceType      : urn:schemas-upnp-org:device:Basic:1
 DescriptionXML  : http://192.168.1.15/description.xml
```
I'm using the supported UPnPDeviceFinder to detect the Bridge after this step i store the Information from http://YourPhilipsHueBridgeIP/description.xml
in a PS-Object. This cmdlet has several switches like `-IP` or `-SerialNumber`, see [Examples](https://github.com/andiecodes/PhilipsHuePSModule/blob/master/PHBridge_config_cmdlets/get-PHBridge.ps1)

It also includes an Error handler if no Device with the ModelName '*Philips hue bridge*' was found.
It's recommended to store the Information about your Hue Bridge, because the detection took a while.
The Module offers an easy way to store Bridge Information. Use `get-PHBridge -StoreConfig` to store it in the User Profil of the current user $($env:USERPROFILE + '\PhilipsHueBridge.xml').
You can access the stored Bridge Information via `get-PHBConfig` for further use.

## [PHAPI cmdlets](https://github.com/andiecodes/PhilipsHuePSModule/tree/master/PHAPI_config_cmdlets)

If you have successfully established a connection to your Philips Hue Bridge it's necessary to create a new API Application User with the `new-PHAPIUser -Application 'YourApplicationName'`cmdlet. To be able to do so you need to **press the link button** on your Philips Hue Bridge, now you have 30 secondes time to create a new API Application User. If you didn't press the Button you will get the Following Error Message: 

```pwsh
new-PHAPIUser -Application 'YourApplicationName'
[{"error":{"type":101,"address":"/","description":"link button not pressed"}}]
```

The `-Application` Parameter is mandatory, the `-Storecreds` parameter is optional. 

## [PHAPI lights cmdlets](https://github.com/andiecodes/PhilipsHuePSModule/tree/master/PHAPI_lights_cmdlets)







