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

@property (nonatomic, copy) NSString *name; /**< Имя для поинта */
@property (nonatomic, copy) NSString *urlImage; /**< url для картинки */
@property (nonatomic, strong) UIImage *categoryImage; /**< image музея */
@property (nonatomic, copy) NSString *address; /**< Адрес музея */

- (instancetype)initWithName:(NSString *)name urlImage:(NSString *)urlImage address:(NSString *)address;

@end

NS_ASSUME_NONNULL_END
