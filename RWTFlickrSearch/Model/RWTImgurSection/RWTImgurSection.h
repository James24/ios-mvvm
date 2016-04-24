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

@property (strong, nonatomic) NSString *prettyName;
@property (nonatomic) RWTImgurApiRequestSectionType sectionType;

+ (NSArray*)getArrayOfAllSectionTypes;

- (instancetype)initWithSectionType:(RWTImgurApiRequestSectionType)sectionType;


@end
