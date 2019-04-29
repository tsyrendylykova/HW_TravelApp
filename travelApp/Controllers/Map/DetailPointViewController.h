//
//  DetailPointViewController.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 25/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapPoint.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailPointViewController : UIViewController

-(instancetype)initWithMapPoint: (MapPoint *)mapPoint;

@end

NS_ASSUME_NONNULL_END
