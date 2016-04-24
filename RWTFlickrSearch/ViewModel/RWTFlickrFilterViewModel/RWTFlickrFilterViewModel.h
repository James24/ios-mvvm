//
//  RWTFlickrFilterViewModel.h
//  RWTFlickrSearch
//
//  Created by Indigo on 4/24/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTImgurApiUrl.h"

@interface RWTFlickrFilterViewModel : NSObject

@property (strong, nonatomic) NSString *title;

@property (nonatomic) RWTImgurApiRequestSectionType sectionType;

@end
