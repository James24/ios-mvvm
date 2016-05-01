//
//  Created by Colin Eberhardt on 13/04/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RWTImgurApiRequest.h"
#import "RWTCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "RWTFlickrFilterViewModel.h"
#import "RWTFlickrFilterViewController.h"
#import "RWTImgurCollectionFlowLayoutBuilder.h"
#import "CHTCollectionViewWaterfallLayout.h"

 static NSString *cellIdentifier = @"cvCell";

@interface RWTFlickrSearchViewController () <UICollectionViewDataSource, UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout>

@property (weak, nonatomic) RWTFlickrSearchViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property(strong, nonatomic) void(^filterTriggeredBlock)(id);

@property (strong, nonatomic) RWTFlickrFilterViewModel *filterViewModel;

@property (strong, nonatomic) NSCache *imageSizesCache;

@end

@implementation RWTFlickrSearchViewController

- (instancetype)initWithViewModel:(RWTFlickrSearchViewModel *)viewModel{
    
    self = [super init];
    
    if (self) {
        self.viewModel = viewModel;
        self.imageSizesCache = [[NSCache alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self setupViewController];
    
    [self bindViewModel];
    
    [[self.viewModel.executeSearch execute:nil] subscribeCompleted:^{
        [self.collectionView reloadData];
    }];
    
}

- (UITabBarItem *)tabBarItem {
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:0];
    return tabBarItem;
}

#pragma mark - Private methods

- (void)setupViewController{
        
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(openFilterModal)] animated:YES];
 
    [self.collectionView registerNib:[UINib nibWithNibName:@"RWTCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
}

- (void)bindViewModel{
    self.title = self.viewModel.title;
    
    RAC([UIApplication sharedApplication], networkActivityIndicatorVisible) = self.viewModel.executeSearch.executing;
    
    [RACObserve(self, filterViewModel.selectedViewType) subscribeNext:^(RWTImgurViewType* collectionViewLayoutType) {
        
        RWTImgurCollectionFlowLayoutBuilder *builder = [[RWTImgurCollectionFlowLayoutBuilder alloc] initWithViewType:collectionViewLayoutType.viewType];
        
        [self.collectionView setCollectionViewLayout:[builder build] animated:YES completion:^(BOOL finished) {
        }];
        
    }];
}

- (void)openFilterModal{
    
    RWTFlickrFilterViewController *filterController = [[RWTFlickrFilterViewController alloc] initWIthViewModel:self.filterViewModel];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:filterController];
    
    [self presentViewController:navController animated:YES completion:nil];
    
}

#pragma mark - Lazy instantiation
- (RWTFlickrFilterViewModel *)filterViewModel{
    if (!_filterViewModel) {
        _filterViewModel = [RWTFlickrFilterViewModel new];
        
        [RACObserve(self, filterViewModel.selectedSection) subscribeNext:^(RWTImgurSection *newSection) {
            
            [[self.viewModel signalForSettingSectionType:newSection.sectionType] subscribeNext:self.filterTriggeredBlock];
            
        }];
        
        [RACObserve(self, filterViewModel.showViral) subscribeNext:^(id showViral) {
            
            [[self.viewModel signalForSettingShowViral:self.filterViewModel.showViral] subscribeNext:self.filterTriggeredBlock];
            
        }];
        
    }
    
    return _filterViewModel;
}

- (void (^)(id))filterTriggeredBlock{
    
    void(^block)(id) = ^(id x){
    
        [self.collectionView reloadData];
        
    };
    
    return block;
}


#pragma mark - UICollectionView
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RWTCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    RWTImgurImageItem *item = self.viewModel.results.data[indexPath.row];
    
    
    [cell.imageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:item.imageUrl]]
                          placeholderImage:nil
                                   success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                                       
                                       [cell.imageView setImage:image];
                                       
                                       NSValue *sizeObj = [NSValue valueWithCGSize:image.size];
                                       [self.imageSizesCache setObject:sizeObj forKey:@(indexPath.row)];
        
                                   }
                                   failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        
                                   }];
    
    [cell.imageDescriptionLabel setText:item.title];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.viewModel.results.data count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.filterViewModel.selectedViewType.viewType == RWTImgurCollectionViewLayoutTypeGrid){
    
        return CGSizeMake(100, 100);
        
    } else if (self.filterViewModel.selectedViewType.viewType == RWTImgurCollectionViewLayoutTypeList){
        
        CGRect frame = [[UIScreen mainScreen] bounds];
        
        return CGSizeMake(frame.size.width, frame.size.width);

    }
    
    
    if ( ![self.imageSizesCache objectForKey:@(indexPath.row)]) {
        
        return CGSizeMake(100, 100);

    } else {
        
        NSValue *value = [self.imageSizesCache objectForKey:@(indexPath.row)];
        
        return [value CGSizeValue];
        
    }



    
}

@end
