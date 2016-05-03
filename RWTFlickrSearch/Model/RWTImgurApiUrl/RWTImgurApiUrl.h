//
//  RWTImgurApiUrl.h
//  RWTFlickrSearch
//
//  Created by Indigo on 4/23/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTImgurWindow.h"

typedef NS_ENUM(NSInteger, RWTImgurApiRequestSectionType) {
    RWTImgurApiRequestSectionTypeHot,
    RWTImgurApiRequestSectionTypeTop,
    RWTImgurApiRequestSectionTypeUser
};


@protocol RWTImgurApiUrlBuilder <NSObject>

@required
- (void)setSection:(RWTImgurApiRequestSectionType)section;
- (void)setShowViral:(BOOL)showViral;
- (void)setWindow:(RWTImgurWindowType)windowType;
@end

@interface RWTImgurApiUrl : NSObject <RWTImgurApiUrlBuilder>

+ (instancetype)urlWithBlock:(void(^)(id<RWTImgurApiUrlBuilder>builder))block;

- (NSString*)getFullUrl;

- (void)setSection:(RWTImgurApiRequestSectionType)section;



@end
