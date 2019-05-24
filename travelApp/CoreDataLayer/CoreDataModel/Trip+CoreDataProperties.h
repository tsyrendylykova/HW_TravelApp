//
//  Trip+CoreDataProperties.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 30/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//
//


#import "Trip+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Trip (CoreDataProperties)

+ (NSFetchRequest<Trip *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSDate *startDate;
@property (nullable, nonatomic, copy) NSDate *endDate;
@property (nullable, nonatomic, retain) NSData *image;
@property (nullable, nonatomic, copy) NSString *tripId;
@property (nullable, nonatomic, retain) Person *person;
@property (nullable, nonatomic, retain) NSSet<Day *> *days;

@end

@interface Trip (CoreDataGeneratedAccessors)

- (void)addDaysObject:(Day *)value;
- (void)removeDaysObject:(Day *)value;
- (void)addDays:(NSSet<Day *> *)values;
- (void)removeDays:(NSSet<Day *> *)values;

- (nullable Day *)dayForDate:(nonnull NSDate *)date;

@end

NS_ASSUME_NONNULL_END
