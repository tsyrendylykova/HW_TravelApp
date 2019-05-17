//
//  AddTripViewController.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 29/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "AddTripViewController.h"
#import "AppDelegate.h"
#import "Trip+CoreDataClass.h"
#import "Day+CoreDataClass.h"
#import "Constants.h"
#import "AddNewTrip.h"


@interface AddTripViewController () <AddNewTripDelegate>

@property (nonatomic, strong) AddNewTrip *addNewTrip;


@end

@implementation AddTripViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
    self.addNewTrip = [[AddNewTrip alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.addNewTrip.addNewTripDelegate = self;
    [self.view addSubview:self.addNewTrip];
    [self.view bringSubviewToFront:self.addNewTrip];
}

-(void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"New trip";
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(goBackToVC)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}

#pragma mark - CoreData Stack

- (NSManagedObjectContext *)coreDataContext
{
    UIApplication *application = [UIApplication sharedApplication];
    NSPersistentContainer *container = ((AppDelegate *)(application.delegate)).persistentContainer;
    NSManagedObjectContext *context = container.viewContext;
    
    return context;
}

#pragma mark - AddNewTripDelegate

-(void)addNewTripActionWith:(NSDate *)startDate endDate:(NSDate *)endDate name:(NSString *)name {
    Trip *trip = [NSEntityDescription insertNewObjectForEntityForName:@"Trip" inManagedObjectContext:self.coreDataContext];
    
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
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(NSMutableSet<Day *> *)getArrayOfDays:(Trip *)trip {
    
    NSDate *startDate = trip.startDate;
    NSDate *endDate = trip.endDate;
    
    NSMutableSet<Day *> *setDays = [NSMutableSet<Day *> new];
    
    Day *startDay = [NSEntityDescription insertNewObjectForEntityForName:@"Day" inManagedObjectContext:self.coreDataContext];
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
        Day *day = [NSEntityDescription insertNewObjectForEntityForName:@"Day" inManagedObjectContext:self.coreDataContext];
        day.date = date;
        [setDays addObject:day];
    }
    
    Day *endDay = [NSEntityDescription insertNewObjectForEntityForName:@"Day" inManagedObjectContext:self.coreDataContext];
    endDay.date = endDate;
    [setDays addObject: endDay];
    
    return setDays;
    
}

-(void)goBackToVC {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
