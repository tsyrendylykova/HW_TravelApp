//
//  ChooseMuseumViewController.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 02/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Trip+CoreDataClass.h"
#import "TACoordinator.h"
#import "CoreDataProvider.h"
#import "TLAMuseumsForDayService.h"
#import "ChooseMuseumViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MuseumsForDayViewController : UIViewController

@property (nonatomic, strong) Trip *trip;
@property (nonatomic, strong) TLAMuseumsForDayService *museumsForDayService;
@property (nonatomic, strong) ChooseMuseumViewController *chooseMuseumVC;

@end

NS_ASSUME_NONNULL_END
