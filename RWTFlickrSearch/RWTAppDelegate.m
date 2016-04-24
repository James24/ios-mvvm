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
#import "RWTAboutViewController.h"

@interface RWTAppDelegate () <UITabBarControllerDelegate>

@property (strong, nonatomic) RWTFlickrSearchViewModel *viewModel;
@property (strong, nonatomic) RWTViewModelServicesImpl *viewModelServices;
@property (strong, nonatomic) UITabBarController *tabBarController;

@end

@implementation RWTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UINavigationController *searchNavigationController = [self getSearchNavigationController];
    RWTAboutViewController *aboutViewController = [self getAboutViewController];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[searchNavigationController, aboutViewController];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (UIViewController *)createInitialViewController {

    self.viewModelServices = [RWTViewModelServicesImpl new];
    self.viewModel = [[RWTFlickrSearchViewModel alloc] initWithServices:self.viewModelServices];

    return [[RWTFlickrSearchViewController alloc] initWithViewModel:self.viewModel];
}

- (UINavigationController *)getSearchNavigationController{
    
    UIViewController *viewController = [self createInitialViewController];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    return navigationController;
}

- (RWTAboutViewController*)getAboutViewController{
    
    return [RWTAboutViewController new];
    
}

@end
