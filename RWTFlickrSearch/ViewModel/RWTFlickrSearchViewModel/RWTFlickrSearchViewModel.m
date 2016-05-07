//
//  RWTFlickrSearchViewModel.m
//  RWTFlickrSearch
//
//  Created by Indigo on 4/21/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchViewModel.h"

@interface RWTFlickrSearchViewModel ()

@property (nonatomic, weak) id<RWTViewModelServices> services;

@end

@implementation RWTFlickrSearchViewModel


- (instancetype) initWithServices:(id<RWTViewModelServices>)services {
    self = [super init];
    if (self) {
        self.services = services;
        [self initialize];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.title = @"Imgur Gallery";
    self.showViral = YES;
    self.windowType = RWTImgurWindowTypeNone;
    
    self.executeSearch =
    [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [self executeSearchSignal];
    }];
}

- (void)setSectionType:(RWTImgurApiRequestSectionType)sectionType{
    _sectionType = sectionType;
    
    if (_sectionType != RWTImgurApiRequestSectionTypeTop) {
        _windowType = RWTImgurWindowTypeNone;
    }
}

#pragma mark - Public Methods
- (RACSignal *)signalForSettingSectionType:(RWTImgurApiRequestSectionType)sectionType
                                 showViral:(BOOL)showViral
{
    _showViral = showViral;
    
    if (sectionType != self.sectionType) {
        [self setSectionType:sectionType];
        return [self.executeSearch execute:nil];
    }

    return nil;
    
}

- (RACSignal *)signalForSettingShowViral:(BOOL)showViral {
    if (showViral != self.showViral) {
        _showViral = showViral;
        return [self.executeSearch execute:nil];
    }
    
    return nil;
}

- (RACSignal *)signalForSettingWindowType:(RWTImgurWindowType)windowType{
    
    if (_windowType != windowType) {
    
        _windowType = windowType;
        return [self.executeSearch execute:nil];
    }
    
    return nil;
}


- (RACSignal *)executeSearchSignal {
    return [[[self.services getImgurSearchService]
             imgurSearchSignal:self.sectionType
             showViral:self.showViral
             windowType:self.windowType]
            
            doNext:^(id results) {
        
        self.results = results;
        
    }];
}

@end
