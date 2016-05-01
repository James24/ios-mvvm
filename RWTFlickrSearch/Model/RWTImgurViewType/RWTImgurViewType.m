//
//  RWTImgurViewType.m
//  RWTFlickrSearch
//
//  Created by Indigo on 4/26/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import "RWTImgurViewType.h"

@interface RWTImgurViewType()

@property (nonatomic) RWTImgurCollectionViewLayoutType viewType;
@property (strong, nonatomic) NSString *prettyName;

@end

@implementation RWTImgurViewType

- (instancetype)initWithCollectionViewLayoutType:(RWTImgurCollectionViewLayoutType)viewType{

    self = [super init];
    
    if (self) {
        [self populatePrettyName:viewType];
    }
    
    return self;
}

- (BOOL)isEqual:(id)object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[RWTImgurViewType class]]) {
        return NO;
    }
    
    return [self isEqualToSection:(RWTImgurViewType *)object];
}

- (BOOL)isEqualToSection:(RWTImgurViewType *)type {
    
    if (!type) {
        return NO;
    }
    
    if (type.viewType == self.viewType) {
        return YES;
    } else {
        return NO;
    }
    
}

- (NSString *)prettyName {
    return _prettyName;
}

- (RWTImgurCollectionViewLayoutType)viewType{
    return _viewType;
}

+ (NSArray*)getArrayOfAllSectionTypes{
    
    RWTImgurViewType *grid = [[RWTImgurViewType alloc] initWithCollectionViewLayoutType:RWTImgurCollectionViewLayoutTypeGrid];
    RWTImgurViewType *list = [[RWTImgurViewType alloc] initWithCollectionViewLayoutType:RWTImgurCollectionViewLayoutTypeList];
    RWTImgurViewType *staggered = [[RWTImgurViewType alloc] initWithCollectionViewLayoutType:RWTImgurCollectionViewLayoutTypeStaggeredGrid];
    
    return @[grid, list, staggered];
}

#pragma mark - Private Methods

- (void)populatePrettyName:(RWTImgurCollectionViewLayoutType)viewType{
    self.viewType = viewType;
    
    if (viewType == RWTImgurCollectionViewLayoutTypeGrid){
        
        _prettyName = @"Grid";
        
    } else if (viewType == RWTImgurCollectionViewLayoutTypeList){
        
        _prettyName = @"List";
        
    } else if (viewType == RWTImgurCollectionViewLayoutTypeStaggeredGrid){
        
        _prettyName = @"Staggered Grid";
        
    }
}


@end
