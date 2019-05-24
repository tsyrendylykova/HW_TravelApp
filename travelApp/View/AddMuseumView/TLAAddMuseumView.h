//
//  TLAAddMuseumView.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 17/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Trip+CoreDataClass.h"
#import "TLAAddMuseumDelegate.h"


NS_ASSUME_NONNULL_BEGIN


@interface TLAAddMuseumView : UIView

@property (nonatomic, nullable, weak) id<TLAAddMuseumDelegate> addNewMuseumDelegate; /**< Делегат внешних событий */

- (instancetype)initWithFrame:(CGRect)frame trip:(Trip *)trip info:(NSMutableDictionary *)info rowNumber:(NSInteger)rowNumber;

@end

NS_ASSUME_NONNULL_END
