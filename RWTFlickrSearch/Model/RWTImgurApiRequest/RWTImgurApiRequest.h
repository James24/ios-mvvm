//
//  RWTImgurApiRequest.h
//  RWTFlickrSearch
//
//  Created by Indigo on 4/21/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTImgurApiUrl.h"


@interface RWTImgurApiRequest : NSObject

- (void) getWithUrl:(RWTImgurApiUrl *)url
            success:(void (^)(id))success
            failure:(void (^)(NSError *))failure;
@end
