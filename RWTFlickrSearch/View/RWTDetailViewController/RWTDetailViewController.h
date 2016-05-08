//
//  RWTDetailViewController.h
//  RWTFlickrSearch
//
//  Created by Indigo on 5/8/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWTDetailViewModel.h"

@interface RWTDetailViewController : UIViewController

- (instancetype)initWithViewModel:(RWTDetailViewModel *)viewModel;

@end
