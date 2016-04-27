//
//  RWTImgurSection.m
//  RWTFlickrSearch
//
//  Created by Indigo on 4/24/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import "RWTImgurSection.h"

@interface RWTImgurSection()

@property(strong, nonatomic) NSString *prettyName;
@property (nonatomic) RWTImgurApiRequestSectionType sectionType;

@end

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

- (NSString *)prettyName {
    return _prettyName;
}

- (RWTImgurApiRequestSectionType)sectionType{
    return _sectionType;
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
        
        _prettyName = @"Hot";
        
    } else if (sectionType == RWTImgurApiRequestSectionTypeTop){
        
        _prettyName = @"Top";
        
    } else if (sectionType == RWTImgurApiRequestSectionTypeUser){
        
        _prettyName = @"User";
        
    }
}

@end
