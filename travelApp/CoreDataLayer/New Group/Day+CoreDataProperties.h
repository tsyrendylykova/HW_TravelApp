//
//  Day+CoreDataProperties.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 30/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//
//

#import "Day+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Day (CoreDataProperties)

+ (NSFetchRequest<Day *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *date;
@property (nullable, nonatomic, copy) NSString *weather;
@property (nullable, nonatomic, retain) Trip *trip;
@property (nullable, nonatomic, retain) NSSet<Museum *> *museums;

@end

@interface Day (CoreDataGeneratedAccessors)

- (void)addMuseumsObject:(Museum *)value;
- (void)removeMuseumsObject:(Museum *)value;
- (void)addMuseums:(NSSet<Museum *> *)values;
- (void)removeMuseums:(NSSet<Museum *> *)values;

@end

NS_ASSUME_NONNULL_END
