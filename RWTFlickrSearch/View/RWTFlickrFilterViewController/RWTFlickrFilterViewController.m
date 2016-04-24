//
//  RWTFlickrFilterViewController.m
//  RWTFlickrSearch
//
//  Created by Indigo on 4/24/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrFilterViewController.h"

@interface RWTFlickrFilterViewController ()

@property (weak, nonatomic) RWTFlickrFilterViewModel *viewModel;

@end

@implementation RWTFlickrFilterViewController

- (instancetype)initWIthViewModel:(RWTFlickrFilterViewModel *)viewModel {
    self = [super init];
    
    if (self) {
        self.viewModel = viewModel;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


@end
