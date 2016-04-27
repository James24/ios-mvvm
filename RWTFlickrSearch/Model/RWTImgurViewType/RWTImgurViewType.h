//
//  RWTImgurViewType.h
//  RWTFlickrSearch
//
//  Created by Indigo on 4/26/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWTImgurViewType : NSObject

typedef NS_ENUM(NSInteger, RWTImgurCollectionViewLayoutType) {
    RWTImgurCollectionViewLayoutTypeGrid,
    RWTImgurCollectionViewLayoutTypeList,
    RWTImgurCollectionViewLayoutTypeStaggeredGrid
};



- (instancetype)initWithCollectionViewLayoutType:(RWTImgurCollectionViewLayoutType)viewType;
- (RWTImgurCollectionViewLayoutType)viewType;
- (NSString*)prettyName;

+ (NSArray*)getArrayOfAllSectionTypes;


@end
