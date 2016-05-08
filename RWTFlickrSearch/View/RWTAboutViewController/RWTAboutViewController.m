//
//  RWTAboutViewController.m
//  RWTFlickrSearch
//
//  Created by Indigo on 4/24/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import "RWTAboutViewController.h"

@interface RWTAboutViewController ()
@property (weak, nonatomic) IBOutlet UILabel *appInfoLabel;

@end

@implementation RWTAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupAppInfo];
}

- (void)setupAppInfo{
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle]infoDictionary];
    NSString *version = infoDictionary[@"CFBundleShortVersionString"];
    NSString *build = infoDictionary[(NSString*)kCFBundleVersionKey];
    
    
    self.appInfoLabel.text = [NSString stringWithFormat:@"Imgur Gallery %@ (%@)", version, build];
}

@end
