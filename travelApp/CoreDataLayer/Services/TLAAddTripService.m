//
//  TLAAddTripService.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 20/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "TLAAddTripService.h"
#import "Trip+CoreDataClass.h"
#import "Day+CoreDataClass.h"

@implementation TLAAddTripService

-(void)addNewTripActionWith:(NSDate *)startDate endDate:(NSDate *)endDate name:(NSString *)name {
    Trip *trip = [NSEntityDescription insertNewObjectForEntityForName:@"Trip" inManagedObjectContext:self.coreDataProvider.persistentContainer.viewContext];
    
    trip.name = name;
    trip.startDate = startDate;
    trip.endDate = endDate;
    
    NSSet<Day *> *dates = [NSSet setWithSet:[self getArrayOfDays:trip]];
    [trip addDays:dates];
    
    //  TO-DO - сделать проверку : endDate > startDate
    NSError *error;
    if (![trip.managedObjectContext save:&error]) {
        NSLog(@"Не удалось сохранить объект");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
}

-(NSMutableSet<Day *> *)getArrayOfDays:(Trip *)trip {
    
    NSDate *startDate = trip.startDate;
    NSDate *endDate = trip.endDate;
    
    NSMutableSet<Day *> *setDays = [NSMutableSet<Day *> new];
    
    Day *startDay = [NSEntityDescription insertNewObjectForEntityForName:@"Day" inManagedObjectContext:self.coreDataProvider.persistentContainer.viewContext];
    startDay.date = startDate;
    [setDays addObject:startDay];
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                        fromDate:startDate
                                                          toDate:endDate
                                                         options:0];
    
    for (int i = 1; i < components.day; ++i) {
        NSDateComponents *newComponents = [NSDateComponents new];
        newComponents.day = i;
        
        NSDate *date = [gregorianCalendar dateByAddingComponents:newComponents
                                                          toDate:startDate
                                                         options:0];
        Day *day = [NSEntityDescription insertNewObjectForEntityForName:@"Day" inManagedObjectContext:self.coreDataProvider.persistentContainer.viewContext];
        day.date = date;
        [setDays addObject:day];
    }
    
    Day *endDay = [NSEntityDescription insertNewObjectForEntityForName:@"Day" inManagedObjectContext:self.coreDataProvider.persistentContainer.viewContext];
    endDay.date = endDate;
    [setDays addObject: endDay];
    
    return setDays;
    
}

@end
