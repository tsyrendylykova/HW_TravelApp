//
//  TLAAddMuseumService.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 20/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//


#import "TLAAddMuseumService.h"
#import "Museum+CoreDataClass.h"
#import "Day+CoreDataClass.h"


@implementation TLAAddMuseumService

- (void)saveWithInfo:(NSMutableDictionary *)info rowNumber:(NSInteger)rowNumber trip:(Trip *)trip electedDateInPicker:(NSDate *)selectedDateInPicker {
    Museum *museum = [NSEntityDescription insertNewObjectForEntityForName:@"Museum" inManagedObjectContext:self.coreDataProvider.persistentContainer.viewContext];
    museum.name = info[@"CommonName"];
    museum.address = info[@"Address"];
    museum.museumId = [NSString stringWithFormat:@"%ld", (long)rowNumber];
    museum.latitude = [info[@"Coordinates"][1] doubleValue];
    museum.longitude = [info[@"Coordinates"][0] doubleValue];
    
    Day *dayInTrip = [trip dayForDate:selectedDateInPicker];
    [dayInTrip addMuseumsObject:museum];
    
    NSError *error;
    if (![museum.managedObjectContext save:&error])
    {
        NSLog(@"Не удалось сохранить объект");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
}

@end
