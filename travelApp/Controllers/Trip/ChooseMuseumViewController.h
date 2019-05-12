//
//  ChooseMuseumViewController.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 03/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TAMosDataNetworkService.h"
#import "Trip+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChooseMuseumViewController : UIViewController <MosDataNetworkServiceOutputProtocol>

-(instancetype)initWithTrip: (Trip *)trip;

@property (nonatomic, strong) TAMosDataNetworkService *networkService;

@end

NS_ASSUME_NONNULL_END
