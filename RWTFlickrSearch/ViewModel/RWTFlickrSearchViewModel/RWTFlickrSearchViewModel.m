//
//  RWTFlickrSearchViewModel.m
//  RWTFlickrSearch
//
//  Created by Indigo on 4/21/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchViewModel.h"

@implementation RWTFlickrSearchViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.searchText = @"search text";
    self.title = @"Imgur Gallery";
}

@end
