//
//  TLAAddTripViewController.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 29/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "TLAAddTripService.h"


NS_ASSUME_NONNULL_BEGIN


@interface TLAAddTripViewController : UIViewController

- (instancetype)initWithAddTripService:(TLAAddTripService *)service;

@end

NS_ASSUME_NONNULL_END
