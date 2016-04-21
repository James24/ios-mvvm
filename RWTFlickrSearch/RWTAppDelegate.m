//
//  RWTAppDelegate.m
//  RWTFlickrSearch
//
//  Created by Colin Eberhardt on 20/05/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTAppDelegate.h"
#import "RWTFlickrSearchViewController.h"
#import "RWTFlickrSearchViewModel.h"
#import "RWTViewModelServicesImpl.h"

@interface RWTAppDelegate ()

@property (nonatomic, retain) UINavigationController *navigationController;
@property (nonatomic, strong) RWTFlickrSearchViewModel *viewModel;
@property (strong, nonatomic) RWTViewModelServicesImpl *viewModelServices;

@end

@implementation RWTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.navigationController = [UINavigationController new];
  self.navigationController.navigationBar.barTintColor = [UIColor darkGrayColor];
  [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
  
  UIViewController *viewController = [self createInitialViewController];
  [self.navigationController pushViewController:viewController animated:NO];

  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.window.rootViewController = self.navigationController;
  [self.window makeKeyAndVisible];
  return YES;
}

- (UIViewController *)createInitialViewController {

    self.viewModelServices = [RWTViewModelServicesImpl new];
    self.viewModel = [[RWTFlickrSearchViewModel alloc] initWithServices:self.viewModelServices];
    
    return [[RWTFlickrSearchViewController alloc] initWithViewModel:self.viewModel];
}

@end