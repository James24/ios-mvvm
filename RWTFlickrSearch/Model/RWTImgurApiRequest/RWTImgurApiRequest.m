//
//  RWTImgurApiRequest.m
//  RWTFlickrSearch
//
//  Created by Indigo on 4/21/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import "RWTImgurApiRequest.h"
#import "AFNetworking.h"
#import "RWTImgurImages.h"

@implementation RWTImgurApiRequest

NSString * const IMGUR_TOKEN = @"Client-ID de3be4116cb490b";

- (void) getWithUrl:(RWTImgurApiUrl *)url
            success:(void (^)(id))success
            failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *manager = [self getManager];
    
    [manager GET:[url getFullUrl]
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             RWTImgurImages *images = [[RWTImgurImages alloc] initWithDictionary:responseObject error:nil];
             
             NSLog(@"%@", images.data[0]);
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             NSString* ErrorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
             NSLog(@"%@",ErrorResponse);
             
             if (failure) {
                 failure(error);
             }
             
         }];
}

- (AFHTTPSessionManager*)getManager{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:IMGUR_TOKEN forHTTPHeaderField:@"Authorization"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    return manager;
}

@end
