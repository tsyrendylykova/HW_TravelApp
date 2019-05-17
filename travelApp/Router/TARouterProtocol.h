//
//  TARouterProtocol.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 16/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

@class TARouter;

@protocol TARouterProtocol <NSObject>
@optional

+(TARouter *)sharedRouter;
-(void)showMuseumOnMapWithAnnotation:(TACustomAnnotation *)annotation;

@end
