//
//  TAFoursquareNetworkService.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 24/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TAFoursquareNetworkServiceProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface TAFoursquareNetworkService : NSObject <FoursquareNetworkServiceInputProtocol>

@property (nonatomic, weak, nullable) id<FoursquareNetworkServiceOutputProtocol> output; /**< Делегат внешних событий */

@end

NS_ASSUME_NONNULL_END
