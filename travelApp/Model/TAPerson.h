//
//  TAPerson.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 30/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TAPerson : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *sirName;
@property (nonatomic, assign) NSInteger *age;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *preferences;

-(instancetype)initWithName: (NSString *)name age:(NSInteger *)age address:(NSString *)address preferences:(NSString *)preferences;

@end

NS_ASSUME_NONNULL_END
