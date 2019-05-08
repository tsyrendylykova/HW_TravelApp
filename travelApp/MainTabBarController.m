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
    MapViewController *mapVC = [MapViewController new];
    //mapVC.annotation = [TACustomAnnotation new];
    UINavigationController *mapSearchNC = [[UINavigationController alloc] initWithRootViewController:mapVC];
    mapSearchNC.tabBarItem.title = @"Map";
    mapSearchNC.tabBarItem.image = [UIImage imageNamed:@"map"];
    
    CreateTripViewController *createTripVC = [CreateTripViewController new];
    //createTripVC.router = [Router new];
    //createTripVC.annotation = [TACustomAnnotation new];
    //еще в Router надо передавать MainTabBarController
    UINavigationController *createTripNC = [[UINavigationController alloc] initWithRootViewController:createTripVC]; // VC не UINAV
    createTripNC.tabBarItem.title = @"New trip";
    createTripNC.tabBarItem.image = [UIImage imageNamed:@"trip"];
    
    ProfileViewController *profileViewVC = [ProfileViewController new];
    UINavigationController *profileNC = [[UINavigationController alloc] initWithRootViewController:profileViewVC];
    profileNC.tabBarItem.title = @"Profile";
    profileNC.tabBarItem.image = [UIImage imageNamed:@"profile"];
    
    
    NSArray *array = @[mapSearchNC, createTripNC, profileNC];
    
    self.tabBar.translucent = YES;
    self.tabBar.tintColor = [UIColor blackColor];
    self.tabBar.barTintColor = [UIColor whiteColor];
    
    self.viewControllers = array;
    self.selectedIndex = 1;
}


@end
