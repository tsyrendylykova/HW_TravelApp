//
//  AddMuseumViewController.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 03/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Trip+CoreDataClass.h"
#import "TLAAddMuseumService.h"


NS_ASSUME_NONNULL_BEGIN

@interface TLAAddMuseumViewController : UIViewController

@property (nonatomic, strong) TLAAddMuseumService *addMuseumService;
@property (nonatomic, strong) Trip *trip;
@property (nonatomic, assign) NSInteger rowNumber;
@property (nonatomic, strong) NSMutableDictionary *info;

@end

NS_ASSUME_NONNULL_END
