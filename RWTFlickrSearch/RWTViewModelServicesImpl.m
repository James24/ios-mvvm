//
//  RWTViewModelServicesImpl.m
//  RWTFlickrSearch
//
//  Created by Indigo on 4/21/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import "RWTViewModelServicesImpl.h"
#import "RWTImgurSearchImpl.h"

@interface RWTViewModelServicesImpl ()

@property (strong, nonatomic) RWTImgurSearchImpl *searchService;
@end

@implementation RWTViewModelServicesImpl


- (instancetype)init {
    if (self = [super init]) {
        self.searchService = [RWTImgurSearchImpl new];
    }
    return self;
}

- (id<RWTImgurSearch>)getImgurSearchService {
    return self.searchService;
}

@end
