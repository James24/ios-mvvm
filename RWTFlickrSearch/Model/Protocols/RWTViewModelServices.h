//
//  RWTViewModelServices.h
//  RWTFlickrSearch
//
//  Created by Indigo on 4/21/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTImgurSearch.h"

@protocol RWTViewModelServices <NSObject>

- (id<RWTImgurSearch>) getImgurSearchService;

@end
