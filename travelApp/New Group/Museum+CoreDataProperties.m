//
//  Museum+CoreDataProperties.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 30/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//
//

#import "Museum+CoreDataProperties.h"

@implementation Museum (CoreDataProperties)

+ (NSFetchRequest<Museum *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Museum"];
}

@dynamic name;
@dynamic address;
@dynamic latitude;
@dynamic longitude;
@dynamic museumId;
@dynamic openHours;
@dynamic days;

@end
