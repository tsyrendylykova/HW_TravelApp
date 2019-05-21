//
//  TLACoreDataProvider.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 20/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface TLACoreDataProvider : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

@end

NS_ASSUME_NONNULL_END
