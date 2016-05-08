//
//  RWTImgurFilterOptions.m
//  RWTFlickrSearch
//
//  Created by Indigo on 5/7/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import "RWTImgurFilterOptions.h"

@implementation RWTImgurFilterOptions

- (instancetype)init{
    
    self = [super init];
    
    if (self) {
        self.selectedSection = [[RWTImgurSection alloc] initWithSectionType:RWTImgurApiRequestSectionTypeHot];
        self.selectedWindow = [[RWTImgurWindow alloc] initWithWindowType:RWTImgurWindowTypeNone];
        self.selectedSort = [[RWTImgurSort alloc] initWithSortType:RWTImgurSortTypeViral];
        self.showViral = NO;
    }
    
    return self;
}

@end
