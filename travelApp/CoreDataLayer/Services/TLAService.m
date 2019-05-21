//
//  TLAService.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 20/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "TLAService.h"

@implementation TLAService

-(instancetype)initWithCoreDataProvider: (TLACoreDataProvider *)coreDataProvider {
    self = [super init];
    if (self) {
        _coreDataProvider = coreDataProvider;
    }
    return self;
}

@end
