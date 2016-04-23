//
//  RWTImgurApiRequest.h
//  RWTFlickrSearch
//
//  Created by Indigo on 4/21/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RWTImgurApiUrl.h"
#import "RWTImgurImages.h"


@interface RWTImgurApiRequest : NSObject

- (RACSignal *)signalForGetWithUrl:(RWTImgurApiUrl *)url;

- (void) getWithUrl:(RWTImgurApiUrl *)url
            success:(void (^)(RWTImgurImages *))success
            failure:(void (^)(NSError *))failure;
@end
