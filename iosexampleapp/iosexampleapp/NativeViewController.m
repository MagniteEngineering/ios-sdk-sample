//
//  NativeViewController.m
//  iosexampleapp
//
//  Created by Magnite.
//  Copyright (c) 2025 Magnite. All rights reserved.
//

#import "NativeViewController.h"

#define kAdCellsInterval    5

@interface NativeViewController ()

@property (nonatomic, retain)  IBOutlet UITableView *myTableView;

@end


@implementation NativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Initialize the ad
    magniteNativeAd = [[MGNINativeAd alloc] init];
}

- (IBAction)loadAd:(id)sender {
    // Loading the ad
    self.myTableView.hidden = YES;
    MGNINativeAdPreferences *pref = [[MGNINativeAdPreferences alloc]init];
    pref.adsNumber = 10; // Request 10
    pref.autoBitmapDownload = YES;
    pref.primaryImageSize = MGNINativeAdBitmapSize150x150;
    pref.secondaryImageSize = MGNINativeAdBitmapSize100x100;
    [magniteNativeAd loadAdWithDelegate:self withNativeAdPreferences:pref];
}

// Delegate method to know when the ad finished loading
- (void)didLoadAd:(MGNIAbstractAd *)ad {
    self.myTableView.hidden = NO;
    //Reload tableView data
    [self.myTableView reloadData];
}

- (void)failedLoadAd:(MGNIAbstractAd *)ad withError:(NSError*)error {
    // Failed loading the ad, do something else.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //Set the number of rows. Every 5th cell is cell with ad
    return magniteNativeAd.adsDetails.count * kAdCellsInterval;
    
}

// Customize the appearance of table view cells.
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    static NSString* regularCellIdentifier = @"RegularCell";
    static NSString* adCellIdentifier = @"AdCell";
    
    BOOL isAdCell = indexPath.row % kAdCellsInterval == 0;
    NSString *cellIdentifier = (isAdCell) ? adCellIdentifier : regularCellIdentifier;
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)  {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (isAdCell) {
        //Set cell's text and image from the native ad adDetails
        NSInteger adIndex = indexPath.row / kAdCellsInterval;
        MGNINativeAdDetails* adDetails = [magniteNativeAd.adsDetails objectAtIndex:adIndex];
        cell.textLabel.text = [adDetails title];
        cell.textLabel.numberOfLines = 2;
        cell.imageView.image = [adDetails imageBitmap];
        
        //Registering cell for automatic impression and click tracking
        [adDetails registerViewForImpressionAndClick:cell];
    }
    else {
        cell.textLabel.text = [NSString stringWithFormat:@"Regular cell at row = %ld", (long)indexPath.row];
    }
    
    return cell;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
