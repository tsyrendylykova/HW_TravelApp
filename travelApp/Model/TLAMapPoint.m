//
//  TLAMapPoint.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 25/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//


#import "TLAMapPoint.h"


@implementation TLAMapPoint

- (instancetype)initWithName:(NSString *)name urlImage:(NSString *)urlImage address:(NSString *)address {
    self = [super init];
    if (self)
    {
        _name = name;
        _urlImage = urlImage;
        _address = address;
    }
    return self;
}

@end
