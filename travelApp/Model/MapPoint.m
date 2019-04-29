//
//  MapPoint.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 25/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "MapPoint.h"

@implementation MapPoint

-(instancetype)initWithName: (NSString *)name {
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}

@end
