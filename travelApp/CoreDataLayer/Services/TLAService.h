//
//  TLAService.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 20/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataProvider.h"

NS_ASSUME_NONNULL_BEGIN

@interface TLAService : NSObject

@property (nonatomic, strong) CoreDataProvider *coreDataProvider;

-(instancetype)initWithCoreDataProvider: (CoreDataProvider *)coreDataProvider;

@end

NS_ASSUME_NONNULL_END
