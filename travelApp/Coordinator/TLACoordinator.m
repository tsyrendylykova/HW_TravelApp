//
//  TLACoordinator.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 13/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "TLACoordinator.h"
#import "TLAMapViewController.h"
#import "TLATripsViewController.h"
#import "TLAProfileViewController.h"
#import "TLACoreDataProvider.h"
#import "TLAAddMuseumViewController.h"
#import "TLAAddTripService.h"


@implementation TLACoordinator

+(TLACoordinator *)sharedRouter {
    TLACoordinator *router = [TLACoordinator new];
    
    router.tabBarController = [UITabBarController new];
    
    TLAMapViewController *mapVC = [TLAMapViewController new];
    mapVC.annotation = [TLACustomAnnotation new];
    mapVC.tabBarItem.title = @"Map";
    mapVC.tabBarItem.image = [UIImage imageNamed:@"map"];
    
    TLACoreDataProvider *coreDataProvider = [TLACoreDataProvider new];
    
    TLATripsViewController *createTripVC = [TLATripsViewController new];
    TLAAddTripViewController *addTripVC = [TLAAddTripViewController new];
    TLAMuseumsForDayViewController *museumForDayVC = [TLAMuseumsForDayViewController new];
    TLAChooseMuseumViewController *chooseMuseumVC = [TLAChooseMuseumViewController new];
    TLAAddMuseumViewController *addMuseumVC = [TLAAddMuseumViewController new];
    
    createTripVC.tripsService = [[TLATripsService alloc] initWithCoreDataProvider:coreDataProvider];
    addTripVC.addTripService = [[TLAAddTripService alloc] initWithCoreDataProvider:coreDataProvider];
    museumForDayVC.museumsForDayService = [[TLAMuseumsForDayService alloc] initWithCoreDataProvider:coreDataProvider];
    addMuseumVC.addMuseumService = [[TLAAddMuseumService alloc] initWithCoreDataProvider:coreDataProvider];
    
    createTripVC.addTripVC = addTripVC;
    chooseMuseumVC.addMuseumVC = addMuseumVC;
    museumForDayVC.chooseMuseumVC = chooseMuseumVC;
    createTripVC.museumForDayVC = museumForDayVC;
    
    TLAAddTripViewController *addVC = [TLAAddTripViewController new];
    addVC.addTripService = [[TLAAddTripService alloc] initWithCoreDataProvider:coreDataProvider];
    createTripVC.addTripVC = addVC;
    
    UINavigationController *createTripNC = [[UINavigationController alloc] initWithRootViewController:createTripVC];
    createTripNC.tabBarItem.title = @"New trip";
    createTripNC.tabBarItem.image = [UIImage imageNamed:@"trip"];
    
    TLAProfileViewController *profileViewVC = [TLAProfileViewController new];
    profileViewVC.tabBarItem.title = @"Profile";
    profileViewVC.tabBarItem.image = [UIImage imageNamed:@"profile"];
    
    
    NSArray *array = @[mapVC, createTripNC, profileViewVC];
    
    router.tabBarController.tabBar.translucent = @YES;
    router.tabBarController.tabBar.tintColor = [UIColor blackColor];
    router.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
    
    router.tabBarController.viewControllers = array;
    
    return router;
}

- (void)showMuseumOnMapWithAnnotation:(TLACustomAnnotation *)annotation {
    
    UITabBarController *tabBarC = (UITabBarController *)[[[UIApplication sharedApplication] delegate] window].rootViewController;
    TLAMapViewController *mapViewController = tabBarC.viewControllers[0];
    mapViewController.annotation = annotation;
    [tabBarC setSelectedIndex:0];
    [tabBarC setSelectedViewController:tabBarC.viewControllers[0]];
}

@end
