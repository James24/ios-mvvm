//
//  RWTImgurWindow.h
//  RWTFlickrSearch
//
//  Created by Indigo on 5/1/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWTImgurWindow : NSObject

typedef NS_ENUM(NSInteger, RWTImgurWindowType) {
    RWTImgurWindowTypeDay,
    RWTImgurWindowTypeWeek,
    RWTImgurWindowTypeMonth,
    RWTImgurWindowTypeYear,
    RWTImgurWindowTypeAll
};

- (instancetype)initWithWindowType:(RWTImgurWindowType)windowType;
- (RWTImgurWindowType)windowType;
- (NSString*)prettyName;

+ (NSArray*)getArrayOfAllWindowTypes;

@end
