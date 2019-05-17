//
//  ProfileView.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 17/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TAPerson.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileView : UIView

-(instancetype)initWithFrame:(CGRect)frame person:(TAPerson *)person;

@end

NS_ASSUME_NONNULL_END
