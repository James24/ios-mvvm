//
//  RWTImgurApiUrl.m
//  RWTFlickrSearch
//
//  Created by Indigo on 4/23/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import "RWTImgurApiUrl.h"

NSString * const IMGUR_BASEURL = @"https://api.imgur.com/3/gallery/";

@interface RWTImgurApiUrl()

@property (nonatomic) RWTImgurApiRequestSectionType section;

@end

@implementation RWTImgurApiUrl

+ (instancetype)urlWithBlock:(void(^)(id<RWTImgurApiUrlBuilder>builder))block {
    NSParameterAssert(block);
    
    RWTImgurApiUrl *apiUrl = [RWTImgurApiUrl new];
    
    block(apiUrl);

    return apiUrl;
}

- (NSString *)getFullUrl {
    
    NSString *fullUrl = [NSString stringWithFormat:@"%@%@.json", IMGUR_BASEURL, [self getSectionPath]];
    
    return fullUrl;
}

- (void)setSection:(RWTImgurApiRequestSectionType)section {
    self.section = section;
}

#pragma mark - Private methods

- (NSString*)getSectionPath{
    
    switch (self.section) {
        case RWTImgurApiRequestSectionTypeTop:
            return @"top";
            break;
            
        case RWTImgurApiRequestSectionTypeUser:
            return @"user";
            break;
            
        default:
            return @"hot";
            break;
    }
    
}


@end
