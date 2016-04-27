//
//  RWTImgurSection.m
//  RWTFlickrSearch
//
//  Created by Indigo on 4/24/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import "RWTImgurSection.h"

@implementation RWTImgurSection

- (instancetype)initWithSectionType:(RWTImgurApiRequestSectionType)sectionType{
    
    self = [super init];
    
    if (self) {
        [self populatePrettyName:sectionType];
    }
    
    return self;
}

- (BOOL)isEqual:(id)object{
    if (self == object) {
        return YES;
    }

    if (![object isKindOfClass:[RWTImgurSection class]]) {
        return NO;
    }
    
    return [self isEqualToSection:(RWTImgurSection *)object];
}

- (BOOL)isEqualToSection:(RWTImgurSection *)section {
    
    if (!section) {
        return NO;
    }
    
    if (section.sectionType == self.sectionType) {
        return YES;
    } else {
        return NO;
    }
    
}


+ (NSArray*)getArrayOfAllSectionTypes{
    
    RWTImgurSection *hot = [[RWTImgurSection alloc] initWithSectionType:RWTImgurApiRequestSectionTypeHot];
    RWTImgurSection *top = [[RWTImgurSection alloc] initWithSectionType:RWTImgurApiRequestSectionTypeTop];
    RWTImgurSection *user = [[RWTImgurSection alloc] initWithSectionType:RWTImgurApiRequestSectionTypeUser];
    
    return @[hot, top, user];
}

#pragma mark - Private Methods

- (void)populatePrettyName:(RWTImgurApiRequestSectionType)sectionType{
    self.sectionType = sectionType;
    
    if (sectionType == RWTImgurApiRequestSectionTypeHot){
        
        self.prettyName = @"Hot";
        
    } else if (sectionType == RWTImgurApiRequestSectionTypeTop){
        
        self.prettyName = @"Top";
        
    } else if (sectionType == RWTImgurApiRequestSectionTypeUser){
        
        self.prettyName = @"User";
        
    }
}

@end
