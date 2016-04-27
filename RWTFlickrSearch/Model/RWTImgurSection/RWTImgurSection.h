//
//  RWTImgurSection.h
//  RWTFlickrSearch
//
//  Created by Indigo on 4/24/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTImgurApiUrl.h"

@interface RWTImgurSection : NSObject


+ (NSArray*)getArrayOfAllSectionTypes;

- (instancetype)initWithSectionType:(RWTImgurApiRequestSectionType)sectionType;
- (NSString *)prettyName;
- (RWTImgurApiRequestSectionType)sectionType;

@end
