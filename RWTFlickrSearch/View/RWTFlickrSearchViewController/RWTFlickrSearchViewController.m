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

 static NSString *cellIdentifier = @"cvCell";

@interface RWTFlickrSearchViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) RWTFlickrSearchViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) RWTFlickrFilterViewModel *filterViewModel;

@end

@implementation RWTFlickrSearchViewController

- (instancetype)initWithViewModel:(RWTFlickrSearchViewModel *)viewModel{
    
    self = [super init];
    
    if (self) {
        self.viewModel = viewModel;
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

#pragma mark - Private methods

- (void)setupViewController{
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(openFilterModal)] animated:YES];
 
    [self.collectionView registerNib:[UINib nibWithNibName:@"RWTCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
}

- (void)bindViewModel{
    self.title = self.viewModel.title;
    
    RAC([UIApplication sharedApplication], networkActivityIndicatorVisible) = self.viewModel.executeSearch.executing;
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
    }
    
    return _filterViewModel;
}


#pragma mark - UICollectionView
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RWTCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    RWTImgurImageItem *item = self.viewModel.results.data[indexPath.row];
    
    [cell.imageView setImageWithURL:[[NSURL alloc] initWithString:item.imageUrl]];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.viewModel.results.data count];
}

@end
