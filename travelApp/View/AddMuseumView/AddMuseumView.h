//
//  AddMuseumView.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 17/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Trip+CoreDataClass.h"
#import "AddMuseumDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddMuseumView : UIView

@property (nonatomic, weak, nullable) id<AddMuseumDelegate> addNewMuseumDelegate;

-(instancetype)initWithFrame:(CGRect)frame trip:(Trip *)trip info:(NSMutableDictionary *)info rowNumber:(NSInteger)rowNumber;

@end

NS_ASSUME_NONNULL_END
