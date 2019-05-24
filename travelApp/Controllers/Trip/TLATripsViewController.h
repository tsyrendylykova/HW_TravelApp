//
//  TripsViewController.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 23/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "TLATripsService.h"


NS_ASSUME_NONNULL_BEGIN


@interface TLATripsViewController : UIViewController

@property (nonatomic, strong) TLATripsService *tripsService; /**< Сервис работы с CoreData */

@end

NS_ASSUME_NONNULL_END
