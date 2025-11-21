//
//  ViewController.h
//  iosexampleapp
//
//  Created by Magnite.
//  Copyright (c) 2025 Magnite. All rights reserved.
//

@import UIKit;

/* Import Magnite SDK framework */
@import MagniteSDK;

/* Definition of the implementation of MGNIDelegateProtocol */
@interface ViewController : UIViewController <MGNIDelegateProtocol> {
    /*
     Declaration of MGNIAd which later on will be used
     for loading within the viewDidApear and displaying when
     clicking a button
    */
    MGNIAd *magniteAd_autoload;
    
    /*
     Declaration of MGNIAd which later on will be used
     for loading when user clicks on a button and showing the
     loaded ad when the ad was loaded with delegation
    */
    MGNIAd* magniteAd_loadShow;
    
    /*
     Declaration of MGNIAd which later on will be used
     for loading rewarded video ad
     */
    MGNIAd* magniteAd_rewardedVideo;
    
    /*
     Declaration of MGNIBannerView with variable size and bottom positioning
     */
    MGNIBannerView* magniteBanner_bottom;
    
    /*
     Declaration of MGNIBannerView view with fixed positioning and size
     */
    MGNIBannerView* magniteBanner_fixed;
}

@end
