//
//  TLAMapPoint.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 25/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TLAMapPoint : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *urlImage;
@property (nonatomic, strong) UIImage *categoryImage;
@property (nonatomic, strong) NSString *address;

-(instancetype)initWithName: (NSString *)name urlImage:(NSString *)urlImage address:(NSString *)address;

@end

NS_ASSUME_NONNULL_END
