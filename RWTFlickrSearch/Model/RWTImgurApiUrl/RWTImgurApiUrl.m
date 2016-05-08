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
@property (nonatomic) RWTImgurWindowType window;
@property (nonatomic) RWTImgurSortType sort;
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
    
    NSString *fullUrl = [NSString stringWithFormat:@"%@%@%@%@.json%@", IMGUR_BASEURL, [self getSectionPath], [self getSortParameter], [self getWindowParameter], [self getShowViralParameter]];
    
    NSLog(@"FULL URL: %@", fullUrl);
    
    return fullUrl;
}

- (void)setSection:(RWTImgurApiRequestSectionType)section {
    _section = section;
}

- (void)setShowViral:(BOOL)showViral {
    _showViral = showViral;
}

- (void)setWindow:(RWTImgurWindowType)window{
    _window = window;
}

- (void)setSort:(RWTImgurSortType)sort{
    _sort = sort;
}

#pragma mark - Private methods
- (NSString *)getSortParameter{
    switch (self.sort) {
        case RWTImgurSortTypeViral:
            return @"/viral";
            break;
        case RWTImgurSortTypeTop:
            return @"/top";
            break;
        case RWTImgurSortTypeTime:
            return @"/time";
            break;
        case RWTImgurSortTypeRising:
            return @"/rising";
        default:
            return @"";
            break;
    }
}

- (NSString *)getWindowParameter{
    switch (self.window) {
        case RWTImgurWindowTypeDay:
            return @"/day";
            break;
            
        case RWTImgurWindowTypeWeek:
            return @"/week";
            break;
            
        case RWTImgurWindowTypeMonth:
            return @"/month";
            break;
            
        case RWTImgurWindowTypeYear:
            return @"/year";
            break;
            
        case RWTImgurWindowTypeAll:
            return @"/all";
            break;
            
        default:
            return @"";
            break;
    }
}


- (NSString *)getShowViralParameter{
    
    if (self.section != RWTImgurApiRequestSectionTypeUser) {
        return @"";
    }
    
    if (self.showViral) {
        return @"?showViral=true";
    } else {
        return @"?showViral=false";
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
