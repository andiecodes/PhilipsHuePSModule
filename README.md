# PhilipsHueAPI Module
The PhilipsHueAPI PowerShell Module allows you to communicate between your PhilipsHue Smart Home Devices. It detects a Philips Hue Bridge in your Network, connect to it, create new  api user and get all lights that are installed in your environment. It's based on the [API Developer Guide Version 1.0](https://developers.meethue.com/)

Download the Zip, extract it, copy the Folder **PhilipsHueAPI** to **C:\Windows\System32\WindowsPowerShell\v1.0\Modules**

If the Module was added to your Modules Folder, you can run `Import-Module PhilipsHueAPI` to use the PHAPI-cmdlets.

[PhilipsHue API ChangeLOG](https://developers.meethue.com/develop/hue-api/api-documentation-changelog/)

##### Further Options `get-PHGroups`, `get-PHScenes`, `get-PHSchedul`, `get-PHSensors`

## [PHBridge cmdlets](https://github.com/andiecodes/PhilipsHuePSModule/tree/master/PHBridge_config_cmdlets)

The first thing you need to do is, detect your Philips Hue Bridge with the `get-PHBridge` cmdlet.

I'm using the supported UPnPDeviceFinder to detect the Bridge after this step i store the Information from http://YourPhilipsHueBridgeIP/description.xml
in a PS-Object. This cmdlet has several switches like `-IP` or `-SerialNumber`, see [Examples](https://github.com/andiecodes/PhilipsHuePSModule/blob/master/PHBridge_config_cmdlets/get-PHBridge.ps1)

It also includes an Error handler if no Device with the ModelName '*Philips hue bridge*' was found.
It's recommended to store the Information about your Hue Bridge, because the detection took a while.
The Module offers an easy way to store Bridge Information. Use `get-PHBridge -StoreConfig` to store it in the User Profil of the current user $($env:USERPROFILE + '\PhilipsHueBridge.xml').
You can access the stored Bridge Information via `get-PHBConfig` for further use.

## [PHAPI cmdlets](https://github.com/andiecodes/PhilipsHuePSModule/tree/master/PHAPI_config_cmdlets)

If you have successfully established a connection to your Philips Hue Bridge it's necessary to create a new API Application User with the `new-PHAPIUser -Application 'YourApplicationName'`cmdlet. To be able to do so you need to **press the link button** on your Philips Hue Bridge, now you have 30 secondes time to create a new API Application User. The `-Application` Parameter is mandatory, the `-Storecreds` parameter is optional. 

## [PHAPI lights cmdlets](https://github.com/andiecodes/PhilipsHuePSModule/tree/master/PHAPI_lights_cmdlets)





