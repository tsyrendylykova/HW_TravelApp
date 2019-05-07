//
//  AddMuseumViewController.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 03/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddMuseumViewController : UIViewController

-(instancetype)initWithDates: (NSMutableArray<NSDate *> *)dates rowNumber:(NSInteger)rowNumber info:(NSMutableDictionary *)info;

@end

NS_ASSUME_NONNULL_END
