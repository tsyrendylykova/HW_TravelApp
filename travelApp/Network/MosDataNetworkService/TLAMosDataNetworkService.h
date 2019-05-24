//
//  TLAMosDataNetworkService.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 12/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "TLAMosDataNetworkServiceProtocol.h"


NS_ASSUME_NONNULL_BEGIN


@interface TLAMosDataNetworkService : NSObject <TLAMosDataNetworkServiceInputProtocolMuseums>

@property (nonatomic, nullable, weak) id<TLAMosDataNetworkServiceOutputProtocol> output; /**< Делегат внешних событий */

@end

NS_ASSUME_NONNULL_END
