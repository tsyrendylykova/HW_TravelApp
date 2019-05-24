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

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sirName;
@property (nonatomic, assign) NSInteger *age;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *preferences;

- (instancetype)initWithName:(NSString *)name age:(NSInteger *)age address:(NSString *)address preferences:(NSString *)preferences;

@end

NS_ASSUME_NONNULL_END
