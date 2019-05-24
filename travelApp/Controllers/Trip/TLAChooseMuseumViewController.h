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
#import "TLAAddMuseumService.h"


NS_ASSUME_NONNULL_BEGIN

@interface TLAChooseMuseumViewController : UIViewController <TLAMosDataNetworkServiceOutputProtocol>

- (instancetype)initWithService:(TLAAddMuseumService *)service trip:(Trip *)trip networkService:(TLAMosDataNetworkService *)networkService;

@end

NS_ASSUME_NONNULL_END
