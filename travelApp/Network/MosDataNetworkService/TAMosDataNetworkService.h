//
//  TAMosDataNetworkService.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 12/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TAMosDataNetworkServiceProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface TAMosDataNetworkService : NSObject <MosDataNetworkServiceInputProtocolMuseums>

@property (nonatomic, weak, nullable) id<MosDataNetworkServiceOutputProtocol> output; /**< Делегат внешних событий */

@end

NS_ASSUME_NONNULL_END
