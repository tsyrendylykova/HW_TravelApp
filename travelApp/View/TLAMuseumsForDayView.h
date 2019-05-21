//
//  TLAMuseumsForDayView.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 17/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Trip+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface TLAMuseumsForDayView : UIView

@property (nonatomic, strong) UILabel *labelShow;
-(instancetype)initWithFrame:(CGRect)frame trip:(Trip *)trip;

@end

NS_ASSUME_NONNULL_END
