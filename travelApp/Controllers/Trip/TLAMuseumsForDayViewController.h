//
//  ChooseMuseumViewController.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 02/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Trip+CoreDataClass.h"
#import "TLACoordinator.h"
#import "TLACoreDataProvider.h"
#import "TLAMuseumsForDayService.h"
#import "TLAChooseMuseumViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface TLAMuseumsForDayViewController : UIViewController

@property (nonatomic, strong) Trip *trip;
@property (nonatomic, strong) TLAMuseumsForDayService *museumsForDayService;
@property (nonatomic, strong) TLAChooseMuseumViewController *chooseMuseumVC;

@end

NS_ASSUME_NONNULL_END
