//
//  MainTabBarController.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 23/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "MainTabBarController.h"
#import "MapViewController.h"
#import "CreateTripViewController.h"
#import "ProfileViewController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureInitialViewControllers];
}

- (void)configureInitialViewControllers {
    UINavigationController *searchVC = [[UINavigationController alloc] initWithRootViewController:[MapViewController new]];
    searchVC.tabBarItem.title = @"Map";
    searchVC.tabBarItem.image = [UIImage imageNamed:@"map"];
    
    UINavigationController *createTripVC = [[UINavigationController alloc] initWithRootViewController:[CreateTripViewController new]];
    createTripVC.tabBarItem.title = @"New trip";
    createTripVC.tabBarItem.image = [UIImage imageNamed:@"trip"];
    
    UINavigationController *profileVC = [[UINavigationController alloc] initWithRootViewController:[ProfileViewController new]];
    profileVC.tabBarItem.title = @"Profile";
    profileVC.tabBarItem.image = [UIImage imageNamed:@"profile"];
    
    NSArray *arrayVC = @[searchVC, createTripVC, profileVC];
    
    self.tabBar.translucent = YES;
    self.tabBar.tintColor = [UIColor blackColor];
    self.tabBar.barTintColor = [UIColor whiteColor];
    
    self.viewControllers = arrayVC;
    self.selectedIndex = 1;
}


@end
