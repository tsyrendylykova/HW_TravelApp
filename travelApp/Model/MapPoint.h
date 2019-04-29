//
//  MapPoint.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 25/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MapPoint : NSObject

@property (nonatomic, strong) NSString *name;

-(instancetype)initWithName: (NSString *)name;

@end

NS_ASSUME_NONNULL_END
