//
//  RWTImgurSearchImpl.m
//  RWTFlickrSearch
//
//  Created by Indigo on 4/21/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import "RWTImgurSearchImpl.h"
#import "RWTImgurApiRequest.h"

@implementation RWTImgurSearchImpl

-(RACSignal *)imgurSearchSignal:(RWTImgurApiRequestSectionType)sectionType
                      showViral:(BOOL)showViral
                     windowType:(RWTImgurWindowType)windowType
{
    
    RWTImgurApiUrl *url = [RWTImgurApiUrl urlWithBlock:^(id<RWTImgurApiUrlBuilder> builder) {
        [builder setSection:sectionType];
        [builder setShowViral:showViral];
        [builder setWindow:windowType];
    }];
    
    RACSignal *requestSinal = [[[RWTImgurApiRequest alloc] init] signalForGetWithUrl:url];
    
    return requestSinal;
}

@end
