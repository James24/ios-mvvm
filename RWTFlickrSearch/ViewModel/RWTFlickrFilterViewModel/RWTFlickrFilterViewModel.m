//
//  RWTFlickrFilterViewModel.m
//  RWTFlickrSearch
//
//  Created by Indigo on 4/24/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrFilterViewModel.h"

@implementation RWTFlickrFilterViewModel

- (instancetype)init{
    self = [super init];
    
    if (self) {
        
        self.title = @"Filter Images";
        self.selectedSection = [[RWTImgurSection alloc] initWithSectionType:RWTImgurApiRequestSectionTypeHot];
        self.showViral = YES;
    }
    
    return self;
}

- (NSArray *)getArrayOfAllSectionTypes {
    return [RWTImgurSection getArrayOfAllSectionTypes];
}

#pragma mark - Private methods



@end
