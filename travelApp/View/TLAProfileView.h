//
//  TLAProfileView.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 17/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "TLAPerson.h"


NS_ASSUME_NONNULL_BEGIN

@interface TLAProfileView : UIView

- (instancetype)initWithFrame:(CGRect)frame person:(TLAPerson *)person;

@end

NS_ASSUME_NONNULL_END
