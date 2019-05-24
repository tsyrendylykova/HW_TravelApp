//
//  TLACoordinator.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 13/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "TLACustomAnnotation.h"
#import "TLACoordinatorProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@interface TLACoordinator : NSObject <TLACoordinatorProtocol>

@property (nonatomic, strong) UITabBarController *tabBarController;

@end

NS_ASSUME_NONNULL_END
