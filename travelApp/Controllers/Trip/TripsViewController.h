//
//  TripsViewController.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 23/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TACoordinator.h"
#import "CoreDataProvider.h"
#import "TLATripsService.h"
#import "AddTripViewController.h"
#import "MuseumsForDayViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TripsViewController : UIViewController

@property (nonatomic, strong) TLATripsService *tripsService;
@property (nonatomic, strong) AddTripViewController *addTripVC;
@property (nonatomic, strong) MuseumsForDayViewController *museumForDayVC;

@end

NS_ASSUME_NONNULL_END
