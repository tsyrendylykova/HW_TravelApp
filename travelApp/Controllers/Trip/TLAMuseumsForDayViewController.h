//
//  ChooseMuseumViewController.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 02/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Trip+CoreDataClass.h"
#import "TLAMuseumsForDayService.h"


NS_ASSUME_NONNULL_BEGIN


@interface TLAMuseumsForDayViewController : UIViewController

- (instancetype)initWithCoreDataService:(TLAMuseumsForDayService *)service trip:(Trip *)trip;

@end

NS_ASSUME_NONNULL_END
