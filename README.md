[Magnite][] iOS InApp SDK Example Project
======================================

This iOS application project provides an example of the [Magnite][] InApp SDK integration.

The example application contains the following ads:
* Interstitial ad which is pre-loaded in viewDidAppear for later use.  
This ad is displayed when clicking the 'Show Ad' button.  
Note that loading an ad takes a while, so it is possible that no ad will be displayed when clicking the 'Show Ad' button.
* Interstitial ad which is loaded and displayed when clicking the 'Load & Show' button.
Note that loading an ad takes a while, so there is a delay between clicking the button and the actual appearance of the ad.  
This ad is loaded upon clicking the 'Load & Show' button, and displayed when the ad was successfully loaded, from within the didLoadAd method of the MGNIDelegateProtocol.
* Banner with an automatic positioning at the bottom of the screen.
* Banner with a fixed position and size.
* Native ad example.

When integrating the SDK with your application, please make sure to use the latest SDK version.  
Please also follow the integration manual.  

Don't forget to use your application id when initializing the SDK.  

For any questions or assistance, please contact us at support@magnite.com.

[Magnite]: https://www.magnite.com

Magnite and the Magnite logo are trademarks of Magnite, Inc. Use of these marks is subject to Magnite’s trademark policy. The usage of the product is governed under Magnite Source‑Available License (Polyform‑style, Licensed Users Only) detailed in LICENSE.md.txt

To note, this is a sample app provided solely for the purpose of demonstrating an integration of the MagniteSDK into a publisher app. The code here should NOT be used for any other purpose.
