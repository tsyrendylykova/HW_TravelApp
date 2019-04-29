//
//  TANetworkHelper.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 24/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TANetworkHelper : NSObject

+(NSString *)URLForSearchString: (NSString *)searchString latitude:(NSString *)latitude longitude:(NSString *)longitude;

@end

NS_ASSUME_NONNULL_END
