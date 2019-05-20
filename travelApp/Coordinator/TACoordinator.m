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
#import "CoreDataProvider.h"
#import "AddMuseumViewController.h"
#import "TLAAddTripService.h"

@implementation TACoordinator

+(TACoordinator *)sharedRouter {
    TACoordinator *router = [TACoordinator new];
    
    router.tabBarController = [UITabBarController new];
    
    MapViewController *mapVC = [MapViewController new];
    mapVC.annotation = [TACustomAnnotation new];
    mapVC.tabBarItem.title = @"Map";
    mapVC.tabBarItem.image = [UIImage imageNamed:@"map"];
    
    CoreDataProvider *coreDataProvider = [CoreDataProvider new];
    
    TripsViewController *createTripVC = [TripsViewController new];
    AddTripViewController *addTripVC = [AddTripViewController new];
    MuseumsForDayViewController *museumForDayVC = [MuseumsForDayViewController new];
    ChooseMuseumViewController *chooseMuseumVC = [ChooseMuseumViewController new];
    AddMuseumViewController *addMuseumVC = [AddMuseumViewController new];
    
    createTripVC.tripsService = [[TLATripsService alloc] initWithCoreDataProvider:coreDataProvider];
    addTripVC.addTripService = [[TLAAddTripService alloc] initWithCoreDataProvider:coreDataProvider];
    museumForDayVC.museumsForDayService = [[TLAMuseumsForDayService alloc] initWithCoreDataProvider:coreDataProvider];
    addMuseumVC.addMuseumService = [[TLAAddMuseumService alloc] initWithCoreDataProvider:coreDataProvider];
    
    createTripVC.addTripVC = addTripVC;
    chooseMuseumVC.addMuseumVC = addMuseumVC;
    museumForDayVC.chooseMuseumVC = chooseMuseumVC;
    createTripVC.museumForDayVC = museumForDayVC;
    
    AddTripViewController *addVC = [AddTripViewController new];
    addVC.addTripService = [[TLAAddTripService alloc] initWithCoreDataProvider:coreDataProvider];
    createTripVC.addTripVC = addVC;
    
    UINavigationController *createTripNC = [[UINavigationController alloc] initWithRootViewController:createTripVC];
    createTripNC.tabBarItem.title = @"New trip";
    createTripNC.tabBarItem.image = [UIImage imageNamed:@"trip"];
    
    ProfileViewController *profileViewVC = [ProfileViewController new];
    profileViewVC.tabBarItem.title = @"Profile";
    profileViewVC.tabBarItem.image = [UIImage imageNamed:@"profile"];
    
    
    NSArray *array = @[mapVC, createTripNC, profileViewVC];
    
    router.tabBarController.tabBar.translucent = @YES;
    router.tabBarController.tabBar.tintColor = [UIColor blackColor];
    router.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
    
    router.tabBarController.viewControllers = array;
    
    return router;
}

-(void)showMuseumOnMapWithAnnotation:(TACustomAnnotation *)annotation {
    
    UITabBarController *tabBarC = (UITabBarController *)[[[UIApplication sharedApplication] delegate] window].rootViewController;
    MapViewController *mapViewController = tabBarC.viewControllers[0];
    mapViewController.annotation = annotation;
    [tabBarC setSelectedIndex:0];
    [tabBarC setSelectedViewController:tabBarC.viewControllers[0]];
}

@end
