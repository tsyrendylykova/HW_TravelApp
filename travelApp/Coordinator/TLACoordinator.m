//
//  TLACoordinator.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 13/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "TLACoordinator.h"
#import "TLACustomAnnotation.h"
#import "TLAMapViewController.h"
#import "TLATripsViewController.h"
#import "TLAProfileViewController.h"
#import "TLACoreDataProvider.h"
#import "TLATripsService.h"


@implementation TLACoordinator

+ (TLACoordinator *)sharedCoordinator {
    TLACoordinator *coordinator = [TLACoordinator new];
    
    coordinator.tabBarController = [UITabBarController new];
    
    TLAMapViewController *mapVC = [TLAMapViewController new];
    mapVC.annotation = [TLACustomAnnotation new];
    mapVC.tabBarItem.title = @"Map";
    mapVC.tabBarItem.image = [UIImage imageNamed:@"map"];
    
    TLACoreDataProvider *coreDataProvider = [TLACoreDataProvider new];
    
    TLATripsViewController *createTripVC = [TLATripsViewController new];
    createTripVC.tripsService = [[TLATripsService alloc] initWithCoreDataProvider:coreDataProvider];
    
    UINavigationController *createTripNC = [[UINavigationController alloc] initWithRootViewController:createTripVC];
    createTripNC.tabBarItem.title = @"New trip";
    createTripNC.tabBarItem.image = [UIImage imageNamed:@"trip"];
    
    TLAProfileViewController *profileViewVC = [TLAProfileViewController new];
    profileViewVC.tabBarItem.title = @"Profile";
    profileViewVC.tabBarItem.image = [UIImage imageNamed:@"profile"];
    
    NSArray *array = @[mapVC, createTripNC, profileViewVC];
    
    coordinator.tabBarController.tabBar.translucent = @YES;
    coordinator.tabBarController.tabBar.tintColor = [UIColor blackColor];
    coordinator.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
    coordinator.tabBarController.viewControllers = array;
    
    return coordinator;
}

- (void)showMuseumOnMapWithAnnotation:(TLACustomAnnotation *)annotation {
    UITabBarController *tabBarC = (UITabBarController *)[[[UIApplication sharedApplication] delegate] window].rootViewController;
    TLAMapViewController *mapViewController = tabBarC.viewControllers[0];
    mapViewController.annotation = annotation;
    [tabBarC setSelectedIndex:0];
    [tabBarC setSelectedViewController:tabBarC.viewControllers[0]];
}

@end
