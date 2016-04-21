//
//  RWTImgurSearchImpl.m
//  RWTFlickrSearch
//
//  Created by Indigo on 4/21/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import "RWTImgurSearchImpl.h"

@implementation RWTImgurSearchImpl

-(RACSignal *)imgurSearchSignal:(NSString *)searchString{
        
    return [[[[RACSignal empty]
              logAll]
             delay:2.0]
            logAll];
}

@end
