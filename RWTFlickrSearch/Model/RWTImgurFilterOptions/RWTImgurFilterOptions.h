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
#import "RWTImgurSort.h"

@interface RWTImgurFilterOptions : NSObject

@property (strong, nonatomic) RWTImgurSection *selectedSection;
@property (strong, nonatomic) RWTImgurWindow *selectedWindow;
@property (strong, nonatomic) RWTImgurSort *selectedSort;
@property (nonatomic) BOOL showViral;

@end
