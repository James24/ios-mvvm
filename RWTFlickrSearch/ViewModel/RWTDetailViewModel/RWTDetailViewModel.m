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
        _title = imageItem.title;
        
    }
    
    return self;
}

- (NSString *)desc{
    return _imageItem.desc;
}

- (NSString *)imageUrl{
    return _imageItem.imageUrl;
}

- (NSString *)scores{
    return [NSString stringWithFormat:@"Ups: %@ | Downs: %@ | Score: %@",[_imageItem.ups stringValue], [_imageItem.downs stringValue], [_imageItem.points stringValue]];
}

@end
