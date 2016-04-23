//
//  RWTImgurImage.h
//  RWTFlickrSearch
//
//  Created by Indigo on 4/23/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface RWTImgurImageItem : JSONModel

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *link;
@property (strong, nonatomic) NSString<Optional> *cover;
@property (strong, nonatomic) NSString<Optional> *desc;
@property (nonatomic) BOOL isAlbum;
@property (strong, nonatomic) NSNumber *points;
@property (strong, nonatomic) NSNumber *ups;
@property (strong, nonatomic) NSNumber *downs;
@property (strong, nonatomic) NSString<Ignore> *imageUrl;

@end

@protocol RWTImgurImageItem
@end

@interface RWTImgurImages : JSONModel

@property (strong, nonatomic) NSArray<RWTImgurImageItem> *data;

@end
