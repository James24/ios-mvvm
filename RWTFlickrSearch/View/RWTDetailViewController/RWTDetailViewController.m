//
//  RWTDetailViewController.m
//  RWTFlickrSearch
//
//  Created by Indigo on 5/8/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import "RWTDetailViewController.h"

@interface RWTDetailViewController ()

@property(strong, nonatomic) RWTDetailViewModel *viewModel;

@end

@implementation RWTDetailViewController

- (instancetype)initWithViewModel:(RWTDetailViewModel *)viewModel{
    
    self = [super init];
    
    if (self) {
        
        _viewModel = viewModel;
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


@end
