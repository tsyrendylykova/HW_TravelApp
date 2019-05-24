//
//  TLAFoursquareNetworkService.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 24/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "TLAFoursquareNetworkServiceProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@interface TLAFoursquareNetworkService : NSObject <TLAFoursquareNetworkServiceInputProtocol>

@property (nonatomic, nullable, weak) id<TLAFoursquareNetworkServiceOutputProtocol> output; /**< Делегат внешних событий */

@end

NS_ASSUME_NONNULL_END
