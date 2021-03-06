//
//  TLACoordinatorProtocol.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 16/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

@class TLACoordinator;


@protocol TLACoordinatorProtocol <NSObject>

+ (TLACoordinator *)sharedCoordinator;
- (void)showMuseumOnMapWithAnnotation:(TLACustomAnnotation *)annotation;

@end
