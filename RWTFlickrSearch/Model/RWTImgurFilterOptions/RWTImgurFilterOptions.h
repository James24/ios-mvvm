//
//  RWTImgurFilterOptions.h
//  RWTFlickrSearch
//
//  Created by Indigo on 5/7/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTImgurSection.h"
#import "RWTImgurViewType.h"
#import "RWTImgurWindow.h"

@interface RWTImgurFilterOptions : NSObject

@property (strong, nonatomic) RWTImgurSection *selectedSection;
@property (strong, nonatomic) RWTImgurWindow *selectedWindow;
@property (nonatomic) BOOL showViral;

@end
