//
//  TLAAddNewTrip.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 17/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "TLAAddNewTripDelegate.h"


NS_ASSUME_NONNULL_BEGIN


@interface TLAAddNewTrip : UIView

@property (nonatomic, nullable, weak) id<TLAAddNewTripDelegate> addNewTripDelegate; /**< Делегат внешних событий */

- (instancetype)initWithFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
