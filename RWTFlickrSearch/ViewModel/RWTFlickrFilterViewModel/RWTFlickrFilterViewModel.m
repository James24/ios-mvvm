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
        
        self.title = @"Gallery Options";
        self.selectedViewType = [[RWTImgurViewType alloc] initWithCollectionViewLayoutType:RWTImgurCollectionViewLayoutTypeGrid];
    
        self.selectedFilterOptions = [[RWTImgurFilterOptions alloc] init];
        
    }
    
    return self;
}

- (NSArray *)getArrayOfAllSectionTypes {
    return [RWTImgurSection getArrayOfAllSectionTypes];
}

- (NSArray *)getArrayOfAllViewTypes{
    return [RWTImgurViewType getArrayOfAllSectionTypes];
}

- (NSArray *)getArrayOfAllWindowTypes{
    return [RWTImgurWindow getArrayOfAllWindowTypes];
}

#pragma mark - Private methods



@end
