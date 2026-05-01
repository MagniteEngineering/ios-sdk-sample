//
//  ViewController.m
//  iosexampleapp
//
//  Created by Magnite.
//  Copyright (c) 2025 Magnite. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton* btnFixedBannerSize;

@end


@implementation ViewController

/*
 Initialize Magnite SDK with your appId
 */
- (void)initMagniteSDK {
    // initialize the SDK with your appID and devID
    MGNISDK* sdk = [MGNISDK sharedInstance];
    
    if (sdk.appID != nil) {
        // The sdk has already been initialized
        return;
    }
    
    sdk.testAdsEnabled = YES;
    sdk.preferences = [MGNISDKPreferences prefrencesWithAge:22 andGender:MGNIGender_Male];
    
    __weak typeof(self)weakSelf = self;
#warning This is a demo ProductId, in your own app please make sure to use your own ProductId
    [sdk initializeWithAppID:@"yourAppId" completion:^(NSError *error) { // your app id, you must copy it from your account on Magnite portal
        __strong typeof(weakSelf)strongSelf = weakSelf;
        if (error == nil) {
            [strongSelf createAds];
        }
        else {
            NSLog(@"Failed to initialize Magnite SDK with error: %@", error.localizedDescription);
        }
    }];
}

- (void)createAds {
    /*
     Init of the Magnite interstitials
     */
    magniteAd_autoload = [[MGNIAd alloc] init];
    magniteAd_loadShow = [[MGNIAd alloc] init];
    magniteAd_rewardedVideo = [[MGNIAd alloc] init];
    
    // loading the Magnite Ad
    [magniteAd_autoload loadAdWithDelegate:self];
    
    /*
     load the Magnite auto position banner, banner size will be assigned automatically by  Magnite
     */
    if (magniteBanner_bottom == nil) {
        magniteBanner_bottom = [[MGNIBannerView alloc] initWithSize:MGNIBannerSizeAuto
                                                         autoOrigin:MGNIBannerAutoOriginBottom
                                                       withDelegate:nil];
        
        [self.view addSubview:magniteBanner_bottom];
    }
    
    /*
     load the Magnite fixed position banner
     */
    if (magniteBanner_fixed == nil) {
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            MGNIBannerSize bannerSize = MGNIBannerSizePortrait768x90;
            CGFloat halfX = (self.view.bounds.size.width - bannerSize.size.width) / 2.0f;
            magniteBanner_fixed = [[MGNIBannerView alloc] initWithSize:bannerSize
                                                                origin:CGPointMake(halfX, 350)
                                                          withDelegate:nil];
        } else {
            MGNIBannerSize bannerSize = MGNIBannerSizePortrait320x50;
            CGFloat halfX = (self.view.bounds.size.width - bannerSize.size.width) / 2.0f;
            magniteBanner_fixed = [[MGNIBannerView alloc] initWithSize:bannerSize
                                                                origin:CGPointMake(halfX, 180)
                                                          withDelegate:nil];
        }
        
        [self.view addSubview:magniteBanner_fixed];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMagniteSDK];
    
    [self.btnFixedBannerSize setTitle:UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad ? @"768x90" : @"320x50" forState:UIControlStateNormal];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

#pragma mark ShowAd button click
- (IBAction)btnShowAdClick:(id)sender {
    /*
     displaying Magnite ad.
     NOTE:  Since the loadAd method is async,
            it is possible that when calling the showAd method the
            ad hasn't been loaded yet.
            You can verify that by using the isReady method.
    */
    [magniteAd_autoload showAd];
}

#pragma mark Load and Show button click
- (IBAction)btnLoadShowClick:(id)sender {
    // load Magnite ad with Automatic AdType and self view controller
    // as a delegation for callbacks
    [magniteAd_loadShow loadAdWithDelegate:self];
}

#pragma mark Banner Size methods
- (IBAction)btnAutoBannerSizeClick:(id)sender {
    [magniteBanner_bottom setMGNIBannerSize:MGNIBannerSizeAuto];
}

- (IBAction)btn320x50BannerSizeClick:(id)sender {
    if (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        [magniteBanner_bottom setMGNIBannerSize:MGNIBannerSizePortrait768x90];
    } else {
        [magniteBanner_bottom setMGNIBannerSize:MGNIBannerSizePortrait320x50];
    }
}

- (IBAction)btnMRecBannerSizeClick:(id)sender {
    [magniteBanner_bottom setMGNIBannerSize:MGNIBannerSizeMRec300x250];
}
- (IBAction)btnCoverBannerSizeClick:(id)sender {
    [magniteBanner_bottom setMGNIBannerSize:MGNIBannerSizeCover300х157];
}

#pragma mark Rewarded video

- (IBAction)btnRewardedVideoAdClick:(id)sender {
    // loading rewarded video ad
    [magniteAd_rewardedVideo loadRewardedVideoAdWithDelegate:self];
}


#pragma mark MGNIDelegateProtocol methods
/*
 Implementation of the MGNIDelegateProtocol.
 All methods here are optional and you can
 implement only the ones you need.
*/

// Magnite Ad loaded successfully
- (void)didLoadAd:(MGNIAbstractAd*)ad {
    NSLog(@"Magnite Ad had been loaded successfully");
    
    // Show the Ad
    if (magniteAd_loadShow == ad) {
        [magniteAd_loadShow showAd];
    }
    else if (magniteAd_rewardedVideo == ad) {
        [magniteAd_rewardedVideo showAd];
    }
}

// Magnite Ad failed to load
- (void)failedLoadAd:(MGNIAbstractAd*)ad withError:(NSError*)error {
    NSLog(@"Magnite Ad had failed to load");
}

// Magnite Ad is being displayed
- (void)didShowAd:(MGNIAbstractAd*)ad {
    NSLog(@"Magnite Ad is being displayed");
}

// Magnite Ad failed to display
- (void)failedShowAd:(MGNIAbstractAd*)ad withError:(NSError*)error {
    NSLog(@"Magnite Ad is failed to display");
    if (magniteAd_autoload == ad) {
        UIAlertController* alert = [UIAlertController
                                    alertControllerWithTitle:@"Can't show ad"
                                    message:@"Ad is not loaded yet, please try again"
                                    preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)didCloseAd:(MGNIAbstractAd*)ad {
    if (magniteAd_autoload == ad) {
        [magniteAd_autoload loadAdWithDelegate:self];
    }
}

@end
