# PhilipsHue-PSModule
This Module allows you to detect a Philips Hue Bridge in your Network, currently you can connect, create new user and get all lights that are installed in your environment.

It's based on the https://developers.meethue.com/ API Developer Guide Version 1.0

The first thing you need to do is, detect your Philips Hue Bridge with the get-PHBridge cmdlet.

I'm using the supported UPnPDeviceFinder to detect the Bridge
After this step i store the Information from http://YourPhilipsHueBridgeIP/description.xml
in a PS-Object. This cmdlet has several switches like -IP or -SerialNumber, see Examples...

It also includes an Error handler if no Device with the ModelName '*Philips hue bridge*' was found.
It's recommended to store the Information about your Hue Bridge, because the detection took a while.
The Module offers an easy way to store Bridge Information. Use 'get-PHBridge -StoreConfig' to store it in the User Profil of the current user $($env:USERPROFILE + '\PhilipsHueBridge.xml').
You can access the stored Bridge Information via 'get-PHBConfig' for further use.

If you have successfully established a connection to your Philips Hue Bridge it's necessary to create a new API Application User with the 'new-PHAPIUser -Application 'YourApplicationName' '. To be able to do so you need to press the link button on your Philips Hue Bridge, now you have 30 secondes time to create a new API Application User. The -Application Parameter is mandatory, the -Storecreds parameter is optional. 




