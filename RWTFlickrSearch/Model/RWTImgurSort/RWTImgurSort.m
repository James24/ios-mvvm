//
//  RWTImgurSort.m
//  RWTFlickrSearch
//
//  Created by Indigo on 5/7/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import "RWTImgurSort.h"

@interface RWTImgurSort()

@property(nonatomic) RWTImgurSortType sortType;
@property(strong, nonatomic) NSString *prettyName;

@end

@implementation RWTImgurSort

- (instancetype)initWithSortType:(RWTImgurSortType)sort{
    
    self = [super init];
    
    if (self) {
        
        self.sortType = sort;
        
        [self populatePrettyName:sort];
    }
    
    return self;
}

- (void)populatePrettyName:(RWTImgurSortType)sort{
    
    
    if (sort == RWTImgurSortTypeViral) {
        
        _prettyName = @"Viral";
        
    } else if (sort == RWTImgurSortTypeTop) {
        
        _prettyName = @"Top";
        
    } else if (sort == RWTImgurSortTypeTime) {
        
        _prettyName = @"Time";
        
    } else if (sort == RWTImgurSortTypeRising) {
        
        _prettyName = @"Rising";
        
    }
}

- (BOOL)isEqual:(id)object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[RWTImgurSort class]]) {
        return NO;
    }
    
    return [self isEqualToSection:(RWTImgurSort *)object];
}

- (BOOL)isEqualToSection:(RWTImgurSort *)type {
    
    if (!type) {
        return NO;
    }
    
    if ([type sortType] == [self sortType]) {
        return YES;
    } else {
        return NO;
    }
    
}

#pragma mark - Public methods
- (NSString *)prettyName{
    return _prettyName;
}

- (RWTImgurSortType)sortType{
    return _sortType;
}

+ (NSArray*)getArrayOfAllSortTypes:(BOOL)shouldReturnRising{
    
    RWTImgurSort *viral = [[RWTImgurSort alloc] initWithSortType:RWTImgurSortTypeViral];
    RWTImgurSort *top = [[RWTImgurSort alloc] initWithSortType:RWTImgurSortTypeTop];
    RWTImgurSort *time = [[RWTImgurSort alloc] initWithSortType:RWTImgurSortTypeTime];
    
    if (shouldReturnRising) {
        RWTImgurSort *rising = [[RWTImgurSort alloc] initWithSortType:RWTImgurSortTypeRising];
    
        return @[viral, top, time, rising];
        
    } else {
        
        return @[viral, top, time];
        
    }

}


@end
