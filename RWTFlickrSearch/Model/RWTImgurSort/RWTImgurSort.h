//
//  RWTImgurSort.h
//  RWTFlickrSearch
//
//  Created by Indigo on 5/7/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RWTImgurSortType) {
    RWTImgurSortTypeViral,
    RWTImgurSortTypeTop,
    RWTImgurSortTypeTime,
    RWTImgurSortTypeRising
};

@interface RWTImgurSort : NSObject


- (instancetype)initWithSortType:(RWTImgurSortType)sort;
- (RWTImgurSortType)sortType;
- (NSString *)prettyName;
+ (NSArray*)getArrayOfAllSortTypes:(BOOL)shouldReturnRising;

@end
