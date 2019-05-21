//
//  AddNewTrip.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 17/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddNewTripDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddNewTrip : UIView

@property (nonatomic, weak, nullable) id<AddNewTripDelegate> addNewTripDelegate;

-(instancetype)initWithFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
