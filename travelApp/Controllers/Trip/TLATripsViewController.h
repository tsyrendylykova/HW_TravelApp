//
//  TripsViewController.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 23/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "TLACoordinator.h"
#import "TLACoreDataProvider.h"
#import "TLATripsService.h"
#import "TLAAddTripViewController.h"
#import "TLAMuseumsForDayViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface TLATripsViewController : UIViewController

@property (nonatomic, strong) TLATripsService *tripsService;
@property (nonatomic, strong) TLAAddTripViewController *addTripVC;
@property (nonatomic, strong) TLAMuseumsForDayViewController *museumForDayVC;

@end

NS_ASSUME_NONNULL_END
