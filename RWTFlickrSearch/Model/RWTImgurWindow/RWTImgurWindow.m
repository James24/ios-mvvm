//
//  RWTImgurWindow.m
//  RWTFlickrSearch
//
//  Created by Indigo on 5/1/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import "RWTImgurWindow.h"

@interface RWTImgurWindow()

@property (nonatomic) RWTImgurWindowType windowType;
@property (strong, nonatomic) NSString *prettyName;

@end

@implementation RWTImgurWindow

- (instancetype)initWithWindowType:(RWTImgurWindowType)windowType{
    
    if (self) {
        self.windowType = windowType;
        
        [self populatePrettyName:windowType];
    }
    
    return self;
}


- (void)populatePrettyName:(RWTImgurWindowType)windowType{
    self.windowType = windowType;
    
    if (windowType == RWTImgurWindowTypeDay) {
        
        _prettyName = @"Day";
        
    } else if (windowType == RWTImgurWindowTypeMonth) {
        
        _prettyName = @"Month";
        
    } else if (windowType == RWTImgurWindowTypeWeek) {
        
        _prettyName = @"Week";
        
    } else if (windowType == RWTImgurWindowTypeYear) {
        
        _prettyName = @"Year";
        
    } else if (windowType == RWTImgurWindowTypeAll) {
        
        _prettyName = @"All";
    }
    
}

- (BOOL)isEqual:(id)object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[RWTImgurWindow class]]) {
        return NO;
    }
    
    return [self isEqualToSection:(RWTImgurWindow *)object];
}

- (BOOL)isEqualToSection:(RWTImgurWindow *)type {
    
    if (!type) {
        return NO;
    }
    
    if ([type windowType] == [self windowType]) {
        return YES;
    } else {
        return NO;
    }
    
}

#pragma mark - Public methods
- (RWTImgurWindowType)windowType{
    return _windowType;
}

- (NSString *)prettyName{
    return _prettyName;
}

+ (NSArray*)getArrayOfAllWindowTypes{
    
    RWTImgurWindow *day = [[RWTImgurWindow alloc] initWithWindowType:RWTImgurWindowTypeDay];
    RWTImgurWindow *week = [[RWTImgurWindow alloc] initWithWindowType:RWTImgurWindowTypeWeek];
    RWTImgurWindow *month = [[RWTImgurWindow alloc] initWithWindowType:RWTImgurWindowTypeMonth];
    RWTImgurWindow *year = [[RWTImgurWindow alloc] initWithWindowType:RWTImgurWindowTypeYear];
    RWTImgurWindow *all = [[RWTImgurWindow alloc] initWithWindowType:RWTImgurWindowTypeAll];
    
    return @[day, week, month, year, all];
    
}


@end
