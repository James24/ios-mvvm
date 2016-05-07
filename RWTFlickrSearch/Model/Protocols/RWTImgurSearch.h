//
//  RWTImgurSearch.h
//  RWTFlickrSearch
//
//  Created by Indigo on 4/21/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RWTImgurApiUrl.h"
#import "RWTImgurWindow.h"
#import "RWTImgurSort.h"

@import Foundation;

@protocol RWTImgurSearch <NSObject>

-(RACSignal *)imgurSearchSignal:(RWTImgurApiRequestSectionType)sectionType
                      showViral:(BOOL)showViral
                     windowType:(RWTImgurWindowType)windowType
                       sortType:(RWTImgurSortType)sortType;

@end