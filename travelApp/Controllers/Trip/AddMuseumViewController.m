//
//  AddMuseumViewController.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 03/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "AddMuseumViewController.h"
#import "AppDelegate.h"
#import "Museum+CoreDataClass.h"
#import "Day+CoreDataClass.h"
#import "Constants.h"
#import "AddMuseumView.h"

@import CoreData;

@interface AddMuseumViewController () <UIPickerViewDelegate, UIPickerViewDataSource, NSFetchedResultsControllerDelegate, AddMuseumDelegate>

@property (nonatomic, strong) Trip *trip;
@property (nonatomic, assign) NSInteger rowNumber;
@property (nonatomic, strong) NSMutableDictionary *info;
@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) NSDate *selectedDateInPicker;
@property (nonatomic, strong) NSMutableArray<NSDate *> *availableDates;
@property (nonatomic, copy) NSDictionary *weakDaysEnRu;
@property (nonatomic, strong) NSDateFormatter *dateFormatterFull;
@property (nonatomic, strong) NSDateFormatter *dateFormatterShort;
@property (nonatomic, strong) AddMuseumView *addMuseumView;

@end

@implementation AddMuseumViewController

-(instancetype)initWithTrip: (Trip *)trip rowNumber:(NSInteger)rowNumber info:(NSMutableDictionary *)info {
    self = [super init];
    if (self) {
        _trip = trip;
        _rowNumber = rowNumber;
        _info = info;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.weakDaysEnRu = [NSDictionary dictionaryWithObjectsAndKeys:@"понедельник", @"Monday",  @"вторник", @"Tuesday", @"среда", @"Wednesday", @"четверг", @"Thursday", @"пятница", @"Friday", @"суббота", @"Saturday", @"воскресенье", @"Sunday", nil];
    [self chooseAvailableDaysForMuseum];
    self.addMuseumView = [[AddMuseumView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) trip:self.trip info:self.info rowNumber:self.rowNumber];
    self.addMuseumView.addNewMuseumDelegate = self;
    [self.view addSubview:self.addMuseumView];
    
    [self prepareUI];
    [self prepareDateRormatter];
}

-(void)prepareUI {
    self.picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height * AddMuseumPickerPartTopOffset + AddMuseumPickerTopOffset, self.view.frame.size.width, self.view.frame.size.height * AddMuseumPickerPartHeight)];
    self.picker.backgroundColor = [UIColor whiteColor];
    self.picker.showsSelectionIndicator = YES;
    self.picker.delegate = self;
    self.picker.dataSource = self;
    
    self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height * AddMuseumToolbarPartTopOffset, self.view.frame.size.width, AddMuseumToolbarHeight)];
    self.toolBar.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched:)];
    // add cancel button
    
    [self.toolBar setItems:[NSArray arrayWithObjects:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneButton, nil]];
    
    [self.view addSubview:self.toolBar];
    [self.view addSubview:self.picker];
    
    [self.picker setHidden:YES];
    [self.toolBar setHidden:YES];
}

-(void)prepareDateRormatter {
    self.dateFormatterFull = [[NSDateFormatter alloc] init];
    [self.dateFormatterFull setDateFormat:@"EEEE, MMM d, yyyy"];
    
    self.dateFormatterShort = [[NSDateFormatter alloc] init];
    [self.dateFormatterShort setDateFormat:@"EEEE"];
}

#pragma mark - AddMuseumDelegate

-(void)chooseDates {
    [self.toolBar setHidden:NO];
    [self.picker setHidden:NO];
}

#pragma mark - Actions

- (void)doneTouched:(UIBarButtonItem *)sender {
    [self.toolBar setHidden:YES];
    [self.picker setHidden:YES];
    
    Museum *museum = [NSEntityDescription insertNewObjectForEntityForName:@"Museum" inManagedObjectContext:self.coreDataContext];
    museum.name = self.info[@"CommonName"];
    museum.address = self.info[@"Address"];
    museum.museumId = [NSString stringWithFormat:@"%ld", (long)self.rowNumber];
    museum.latitude = [self.info[@"Coordinates"][1] doubleValue];
    museum.longitude = [self.info[@"Coordinates"][0] doubleValue];
    
    Day *dayInTrip = [self.trip dayForDate:self.selectedDateInPicker];
    [dayInTrip addMuseumsObject:museum];
    
    NSError *error;
    if (![museum.managedObjectContext save:&error]) {
        NSLog(@"Не удалось сохранить объект");
        NSLog(@"%@, %@", error, error.localizedDescription);
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - UIPickerViewDataSource, UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.availableDates.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.dateFormatterFull stringFromDate:self.availableDates[row]];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedDateInPicker = self.availableDates[row];
}

#pragma mark - CoreData Stack

- (NSManagedObjectContext *)coreDataContext
{
    UIApplication *application = [UIApplication sharedApplication];
    NSPersistentContainer *container = ((AppDelegate *)(application.delegate)).persistentContainer;
    NSManagedObjectContext *context = container.viewContext;
    
    return context;
}

#pragma mark - Methods

// prevent availability to add museum for off-day
-(void)chooseAvailableDaysForMuseum {
    self.availableDates = [NSMutableArray<NSDate *> new];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    
    for (Day *day in [self.trip.days sortedArrayUsingDescriptors:@[sortDescriptor]]) {
        NSString *dayName = [self.dateFormatterShort stringFromDate:day.date];
        NSString *weekDayNameRu = self.weakDaysEnRu[dayName];
        if (![self.info[@"WorkHours"][weekDayNameRu] isEqualToString:@"выходной"]) {
            [self.availableDates addObject:day.date];
        }
    }
}

@end
