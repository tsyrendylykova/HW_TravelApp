//
//  Museum+CoreDataProperties.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 30/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//
//

#import "Museum+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Museum (CoreDataProperties)

+ (NSFetchRequest<Museum *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *address;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nullable, nonatomic, copy) NSString *museumId;
@property (nullable, nonatomic, retain) NSObject *openHours;
@property (nullable, nonatomic, retain) NSSet<Day *> *days;

@end

@interface Museum (CoreDataGeneratedAccessors)

- (void)addDaysObject:(Day *)value;
- (void)removeDaysObject:(Day *)value;
- (void)addDays:(NSSet<Day *> *)values;
- (void)removeDays:(NSSet<Day *> *)values;

@end

NS_ASSUME_NONNULL_END
