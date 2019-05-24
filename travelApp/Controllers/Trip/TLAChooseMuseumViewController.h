//
//  TLAChooseMuseumViewController.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 03/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "TLAMosDataNetworkService.h"
#import "Trip+CoreDataClass.h"
#import "TLAAddMuseumViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface TLAChooseMuseumViewController : UIViewController <TLAMosDataNetworkServiceOutputProtocol>

@property (nonatomic, strong) Trip *trip;
@property (nonatomic, strong) TLAMosDataNetworkService *networkService;
@property (nonatomic, strong) TLAAddMuseumViewController *addMuseumVC;

@end

NS_ASSUME_NONNULL_END
