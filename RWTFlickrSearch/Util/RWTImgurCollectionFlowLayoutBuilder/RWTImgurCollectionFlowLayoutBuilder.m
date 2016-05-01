//
//  RWTImgurCollectionFlowLayoutBuilder.m
//  RWTFlickrSearch
//
//  Created by Indigo on 4/28/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import "RWTImgurCollectionFlowLayoutBuilder.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "CHTCollectionViewWaterfallLayout.h"

@interface RWTImgurCollectionFlowLayoutBuilder()

@property(nonatomic) RWTImgurCollectionViewLayoutType viewType;

@end

@implementation RWTImgurCollectionFlowLayoutBuilder

- (instancetype)initWithViewType:(RWTImgurCollectionViewLayoutType)viewType {
    
    self = [super init];
    
    if (self) {
        self.viewType = viewType;
    }
    return self;
}

- (UICollectionViewLayout*)build {
    
    if (self.viewType == RWTImgurCollectionViewLayoutTypeGrid) {
        
        return [self buildGridLayout];
        
    } else if (self.viewType == RWTImgurCollectionViewLayoutTypeList) {
        
        return [self buildListLayout];
        
    } else if (self.viewType == RWTImgurCollectionViewLayoutTypeStaggeredGrid) {
        
        return [self buildStaggeredGrid];
        
    }
    
    return [self buildGridLayout];
}

- (UICollectionViewFlowLayout*)buildGridLayout{
    
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(100, 100)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];

    return flowLayout;
}

- (UICollectionViewFlowLayout*)buildListLayout{
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(frame.size.width, frame.size.width)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    return flowLayout;
}

- (UICollectionViewLayout*)buildStaggeredGrid{
    
    CHTCollectionViewWaterfallLayout *flowLayout = [[CHTCollectionViewWaterfallLayout alloc] init];
    
    return flowLayout;
    
}

@end
