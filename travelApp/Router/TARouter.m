//
//  TARouter.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 13/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TARouter.h"
#import "MapViewController.h"
#import "TripsViewController.h"
#import "ProfileViewController.h"
#import "TACustomAnnotation.h"

@interface TARouter()

@property (nonatomic, strong) UITabBarController *tabBarController;
@property (nonatomic, strong) MapViewController *mapVC;
@property (nonatomic, strong) TripsViewController *createTripVC;
@property (nonatomic, strong) ProfileViewController *profileViewVC;

@end

@implementation TARouter

-(UITabBarController *)configureTravelApp {
    
    self.tabBarController = [UITabBarController new];
    
    self.mapVC = [MapViewController new];
    self.mapVC.annotation = [TACustomAnnotation new];
    UINavigationController *mapSearchNC = [[UINavigationController alloc] initWithRootViewController:self.mapVC];
    mapSearchNC.tabBarItem.title = @"Map";
    mapSearchNC.tabBarItem.image = [UIImage imageNamed:@"map"];
    
    self.createTripVC = [TripsViewController new];
//        createTripVC.router = [TARouter new];
//    createTripVC.annotation = [TACustomAnnotation new];
    //еще в Router надо передавать MainTabBarController???
    UINavigationController *createTripNC = [[UINavigationController alloc] initWithRootViewController:self.createTripVC]; // VC не UINAV
    createTripNC.tabBarItem.title = @"New trip";
    createTripNC.tabBarItem.image = [UIImage imageNamed:@"trip"];
    
    self.profileViewVC = [ProfileViewController new];
    UINavigationController *profileNC = [[UINavigationController alloc] initWithRootViewController:self.profileViewVC];
    profileNC.tabBarItem.title = @"Profile";
    profileNC.tabBarItem.image = [UIImage imageNamed:@"profile"];
    
    
    NSArray *array = @[mapSearchNC, createTripNC, profileNC];
    
    self.tabBarController.tabBar.translucent = YES;
    self.tabBarController.tabBar.tintColor = [UIColor blackColor];
    self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
    
    self.tabBarController.viewControllers = array;
    self.tabBarController.selectedIndex = 1;
    
    return self.tabBarController;
}

-(void)showMuseumOnMap {
    
}



@end
