//
//  TLAAddNewTripDelegate.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 17/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

@protocol TLAAddNewTripDelegate <NSObject>

-(void)addNewTripActionWith:(NSDate *)startDate endDate:(NSDate *)endDate name:(NSString *)name;

@end
