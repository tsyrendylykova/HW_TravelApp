//
//  Day+CoreDataProperties.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 30/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//
//


#import "Day+CoreDataProperties.h"


@implementation Day (CoreDataProperties)

+ (NSFetchRequest<Day *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Day"];
}

@dynamic date;
@dynamic weather;
@dynamic trip;
@dynamic museums;

@end
