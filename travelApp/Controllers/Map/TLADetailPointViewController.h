//
//  DetailPointViewController.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 25/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLAMapPoint.h"

NS_ASSUME_NONNULL_BEGIN

@interface TLADetailPointViewController : UIViewController

-(instancetype)initWithMapPoint: (TLAMapPoint *)mapPoint;

@end

NS_ASSUME_NONNULL_END
