//
//  TAPerson.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 30/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "TAPerson.h"

@interface TAPerson ()

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger *age;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *preferences;

@end

@implementation TAPerson

-(instancetype)initWithName: (NSString *)name age:(NSInteger *)age address:(NSString *)address preferences:(NSString *)preferences {
    self = [super init];
    if (self) {
        _name = name;
        _age = age;
        _address = address;
        _preferences = preferences;
    }
    return self;
}

@end
