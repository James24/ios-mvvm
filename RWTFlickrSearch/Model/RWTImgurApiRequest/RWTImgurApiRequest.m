//
//  RWTImgurApiRequest.m
//  RWTFlickrSearch
//
//  Created by Indigo on 4/21/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import "RWTImgurApiRequest.h"
#import "AFNetworking.h"

@implementation RWTImgurApiRequest

NSString * const IMGUR_URL = @"https://api.imgur.com/3/gallery/hot/viral/0.json";
NSString * const IMGUR_TOKEN = @"Client-ID de3be4116cb490b";


- (void) getWithParams:(NSDictionary *)params
               success:(void (^)(id))success
               failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *manager = [self getManager];
    
    [manager GET:IMGUR_URL
      parameters:params
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             NSLog(@"%@", responseObject);
             
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
