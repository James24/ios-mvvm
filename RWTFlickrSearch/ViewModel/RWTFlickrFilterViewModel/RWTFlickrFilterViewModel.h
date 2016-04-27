//
//  RWTFlickrFilterViewModel.h
//  RWTFlickrSearch
//
//  Created by Indigo on 4/24/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTImgurApiUrl.h"
#import "RWTImgurSection.h"
#import "RWTImgurViewType.h"

@interface RWTFlickrFilterViewModel : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) RWTImgurSection *selectedSection;
@property (strong, nonatomic) RWTImgurViewType *selectedViewType;
@property (nonatomic) NSInteger lastSectionIndexSelected;
@property (nonatomic) NSInteger lastViewTypeIndexSelected;
@property (nonatomic) BOOL showViral;
@property (nonatomic) RWTImgurCollectionViewLayoutType collectionViewLayoutType;

- (NSArray*)getArrayOfAllSectionTypes;
- (NSArray*)getArrayOfAllViewTypes;

@end
