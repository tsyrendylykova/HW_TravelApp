//
//  AddTripViewController.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 29/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataProvider.h"
#import "TLAAddTripService.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddTripViewController : UIViewController

@property (nonatomic, strong) TLAAddTripService *addTripService;

@end

NS_ASSUME_NONNULL_END
