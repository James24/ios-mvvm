//
//  RWTDetailViewModel.h
//  RWTFlickrSearch
//
//  Created by Indigo on 5/8/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTImgurImages.h"

@interface RWTDetailViewModel : NSObject

@property(strong, nonatomic) NSString *title;


- (instancetype)initWithImageItem:(RWTImgurImageItem*)imageItem;

@end
