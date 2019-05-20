//
//  TACoordinator.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 13/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TACoordinator.h"
#import "MapViewController.h"
#import "TripsViewController.h"
#import "ProfileViewController.h"

@implementation TACoordinator

+(TACoordinator *)sharedRouter {
    TACoordinator *router = [TACoordinator new];
    
    router.tabBarController = [UITabBarController new];
    
    MapViewController *mapVC = [MapViewController new];
    mapVC.annotation = [TACustomAnnotation new];
    mapVC.tabBarItem.title = @"Map";
    mapVC.tabBarItem.image = [UIImage imageNamed:@"map"];
    
    TripsViewController *createTripVC = [TripsViewController new];
    UINavigationController *createTripNC = [[UINavigationController alloc] initWithRootViewController:createTripVC]; // VC не UINAV
    createTripNC.tabBarItem.title = @"New trip";
    createTripNC.tabBarItem.image = [UIImage imageNamed:@"trip"];
    
    ProfileViewController *profileViewVC = [ProfileViewController new];
    profileViewVC.tabBarItem.title = @"Profile";
    profileViewVC.tabBarItem.image = [UIImage imageNamed:@"profile"];
    
    
    NSArray *array = @[mapVC, createTripNC, profileViewVC];
    
    router.tabBarController.tabBar.translucent = YES;
    router.tabBarController.tabBar.tintColor = [UIColor blackColor];
    router.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
    
    router.tabBarController.viewControllers = array;
    
    return router;
}

-(void)showMuseumOnMapWithAnnotation:(TACustomAnnotation *)annotation {
    
    UITabBarController *tabBarC = (UITabBarController *)[[[UIApplication sharedApplication] delegate] window].rootViewController;
    MapViewController *mapViewController = [tabBarC.viewControllers objectAtIndex:0];
    mapViewController.annotation = annotation;
    [tabBarC setSelectedIndex:0];
    [tabBarC setSelectedViewController:[tabBarC.viewControllers objectAtIndex:0]];
}

@end
