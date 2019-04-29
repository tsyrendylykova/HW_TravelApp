//
//  TANetworkService.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 24/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TANetworkServiceProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface TANetworkService : NSObject <NetworkServiceInputProtocol>

@property (nonatomic, weak) id<NetworkServiceOutputProtocol> output; /**< Делегат внешних событий */

@end

NS_ASSUME_NONNULL_END
