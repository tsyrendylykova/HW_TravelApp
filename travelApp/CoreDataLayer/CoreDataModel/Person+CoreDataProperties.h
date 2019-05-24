//
//  Person+CoreDataProperties.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 30/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//
//


#import "Person+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int32_t age;
@property (nullable, nonatomic, copy) NSString *address;
@property (nullable, nonatomic, copy) NSString *preferences;
@property (nullable, nonatomic, retain) NSData *photo;
@property (nullable, nonatomic, retain) NSSet<Trip *> *trips;

@end

@interface Person (CoreDataGeneratedAccessors)

- (void)addTripsObject:(Trip *)value;
- (void)removeTripsObject:(Trip *)value;
- (void)addTrips:(NSSet<Trip *> *)values;
- (void)removeTrips:(NSSet<Trip *> *)values;

@end

NS_ASSUME_NONNULL_END
