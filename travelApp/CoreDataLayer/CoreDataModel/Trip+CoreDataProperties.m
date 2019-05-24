//
//  Trip+CoreDataProperties.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 30/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//
//


#import "Trip+CoreDataProperties.h"
#import "Day+CoreDataProperties.h"


@implementation Trip (CoreDataProperties)

+ (NSFetchRequest<Trip *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Trip"];
}

@dynamic name;
@dynamic startDate;
@dynamic endDate;
@dynamic image;
@dynamic tripId;
@dynamic person;
@dynamic days;

- (nullable Day *)dayForDate:(nonnull NSDate *)date
{
    
    for (Day *day in self.days)
    {
        if (day.date == date)
        {
            return day;
        }
    }
    
    return nil;
}

@end
