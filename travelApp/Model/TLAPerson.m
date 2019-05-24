//
//  TTLAPerson.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 30/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//


#import "TLAPerson.h"


@implementation TLAPerson

- (instancetype)initWithName:(NSString *)name age:(NSInteger *)age address:(NSString *)address preferences:(NSString *)preferences
{
    self = [super init];
    if (self)
    {
        _name = name;
        _age = age;
        _address = address;
        _preferences = preferences;
    }
    return self;
}

@end
