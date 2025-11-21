//
//  NativeViewController.h
//  iosexampleapp
//
//  Created by Magnite.
//  Copyright (c) 2025 Magnite. All rights reserved.
//

@import UIKit;
@import MagniteSDK;

@interface NativeViewController : UIViewController <MGNIDelegateProtocol> {
    
    /* Declaration of MGNINativeAd which will load and store all the ads we intend to display */
    MGNINativeAd* magniteNativeAd;
}

@end
