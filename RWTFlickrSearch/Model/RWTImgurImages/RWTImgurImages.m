//
//  RWTImgurImage.m
//  RWTFlickrSearch
//
//  Created by Indigo on 4/23/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import "RWTImgurImages.h"

@implementation RWTImgurImages

@end

@implementation RWTImgurImageItem

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err{
    self = [super initWithDictionary:dict error:err];
    
    if (self) {
        self.imageUrl = [self getImageUrl];
    }
    
    return self;
}

- (NSString *)getImageUrl{
    if (!self.isAlbum){
        return self.link;
    } else {
        return [NSString stringWithFormat:@"http://i.imgur.com/%@.jpg", self.cover];
    }
}

+(JSONKeyMapper*)keyMapper
{
    
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"description": @"desc",
                                                       @"is_album": @"isAlbum"
                                                       }];
}
@end
