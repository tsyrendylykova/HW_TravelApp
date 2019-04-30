//
//  Trip+CoreDataProperties.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 30/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//
//

#import "Trip+CoreDataProperties.h"

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

@end
