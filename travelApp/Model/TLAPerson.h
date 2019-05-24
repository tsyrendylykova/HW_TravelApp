//
//  TLAPerson.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 30/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//


#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN


@interface TLAPerson : NSObject

@property (nonatomic, copy) NSString *name; /**< Имя пользователя */
@property (nonatomic, copy) NSString *sirName; /**< Фамилия пользователя */
@property (nonatomic, assign) NSInteger *age; /**< Возраст пользователя */
@property (nonatomic, copy) NSString *address; /**< Адрес пользователя */
@property (nonatomic, copy) NSString *preferences; /**< Предпочтения пользователя */

- (instancetype)initWithName:(NSString *)name age:(NSInteger *)age address:(NSString *)address preferences:(NSString *)preferences;

@end

NS_ASSUME_NONNULL_END
