//
//  RWTDetailViewModel.m
//  RWTFlickrSearch
//
//  Created by Indigo on 5/8/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import "RWTDetailViewModel.h"

@interface RWTDetailViewModel()

@property(strong, nonatomic) RWTImgurImageItem *imageItem;

@end

@implementation RWTDetailViewModel

- (instancetype)initWithImageItem:(RWTImgurImageItem*)imageItem{
    
    self = [super init];
    
    if (self){
        
        _imageItem = imageItem;
        _title = @"Image Details";
        
    }
    
    return self;
}

@end
