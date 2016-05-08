//
//  RWTDetailViewController.m
//  RWTFlickrSearch
//
//  Created by Indigo on 5/8/16.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

#import "RWTDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import <TLYShyNavBar/TLYShyNavBarManager.h>

@interface RWTDetailViewController ()

@property(strong, nonatomic) RWTDetailViewModel *viewModel;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *scores;
@property (weak, nonatomic) IBOutlet UILabel *imageDescription;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@end

@implementation RWTDetailViewController

- (instancetype)initWithViewModel:(RWTDetailViewModel *)viewModel{
    
    self = [super init];
    
    if (self) {
        
        _viewModel = viewModel;
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.shyNavBarManager.scrollView = self.scrollview;
    
    [self bindViewModel];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    
    self.imageViewHeight.constant = [self calculateImageViewHeightUsingOriginalSize:self.imageView.image.size screenSize:size];
}

- (void)bindViewModel{
    
    self.title = self.viewModel.title;
    self.scores.text = self.viewModel.scores;
    self.imageDescription.text = self.viewModel.desc;
    
    [self.imageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:self.viewModel.imageUrl] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60]
                          placeholderImage:nil
                                   success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                                       
                                       [self.imageView setImage:image];
                                       
                                       self.imageViewHeight.constant = [self calculateImageViewHeightUsingOriginalSize:image.size screenSize:[UIScreen mainScreen].bounds.size];
                                    
                                   }
                                   failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                       
                                   }];
}

- (CGFloat)calculateImageViewHeightUsingOriginalSize:(CGSize)imageSize
                                          screenSize:(CGSize)screenSize{
    
    CGFloat imageRatio = (CGFloat) imageSize.width / imageSize.height;
    
    CGFloat newHeight =  (CGFloat) screenSize.width / imageRatio;
    
    return newHeight;
}


@end
