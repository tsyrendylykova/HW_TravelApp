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

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *urlImage;
@property (nonatomic, strong) UIImage *categoryImage;
@property (nonatomic, copy) NSString *address;

- (instancetype)initWithName:(NSString *)name urlImage:(NSString *)urlImage address:(NSString *)address;

@end

NS_ASSUME_NONNULL_END
