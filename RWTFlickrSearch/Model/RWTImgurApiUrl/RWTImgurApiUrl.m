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
@property (nonatomic) BOOL showViral;


@end

@implementation RWTImgurApiUrl

+ (instancetype)urlWithBlock:(void(^)(id<RWTImgurApiUrlBuilder>builder))block {
    NSParameterAssert(block);
    
    RWTImgurApiUrl *apiUrl = [RWTImgurApiUrl new];
    
    block(apiUrl);

    return apiUrl;
}

- (NSString *)getFullUrl {
    
    NSString *fullUrl = [NSString stringWithFormat:@"%@%@.json?showViral=%@", IMGUR_BASEURL, [self getSectionPath], [self getShowViralParameter]];
    
    NSLog(@"FULL URL: %@", fullUrl);
    
    return fullUrl;
}

- (void)setSection:(RWTImgurApiRequestSectionType)section {
    _section = section;
}

- (void)setShowViral:(BOOL)showViral {
    _showViral = showViral;
}

#pragma mark - Private methods

- (NSString *)getShowViralParameter{
    if (self.showViral) {
        return @"true";
    } else {
        return @"false";
    }
}

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
