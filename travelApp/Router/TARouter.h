//
//  TARouter.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 13/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TACustomAnnotation.h"

NS_ASSUME_NONNULL_BEGIN

@interface TARouter : NSObject

@property (nonatomic, strong) UITabBarController *tabBarController;

+(TARouter *)sharedRouter;
-(void)showMuseumOnMapWithAnnotation:(TACustomAnnotation *)annotation;

@end

NS_ASSUME_NONNULL_END
