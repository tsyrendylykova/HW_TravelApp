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

@import CoreData;

@interface AddMuseumViewController () <UIPickerViewDelegate, UIPickerViewDataSource, NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSMutableArray<NSDate *> *dates;
@property (nonatomic, strong) Trip *trip;
@property (nonatomic, assign) NSInteger rowNumber;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSMutableDictionary *info;
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UILabel *labelAddress;
@property (nonatomic, strong) NSArray *weekDays;
@property (nonatomic, strong) UIButton *buttonAdd;
@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, assign) NSInteger activePickerView;
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) NSDate *selectedDateInPicker;
@property (nonatomic, strong) NSMutableArray<NSDate *> *availableDates;
@property (nonatomic, strong) NSDictionary *weakDaysEnRu;

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
    
    self.weekDays = [NSArray arrayWithObjects:@"понедельник", @"вторник", @"среда", @"четверг", @"пятница", @"суббота", @"воскресенье", nil];
    self.weakDaysEnRu = [NSDictionary dictionaryWithObjectsAndKeys:@"понедельник", @"Monday",  @"вторник", @"Tuesday", @"среда", @"Wednesday", @"четверг", @"Thursday", @"пятница", @"Friday", @"суббота", @"Saturday", @"воскресенье", @"Sunday", nil];
    [self chooseAvailableDaysForMuseum];
    
    [self prepareUI];
    self.activePickerView = 0;
    self.picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height * 0.7 + 44, self.view.frame.size.width, self.view.frame.size.height * 0.3)];
    self.picker.backgroundColor = [UIColor whiteColor];
    self.picker.showsSelectionIndicator = YES;
    self.picker.delegate = self;
    self.picker.dataSource = self;
    
    self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height * 0.7, self.view.frame.size.width, 44)];
    self.toolBar.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched:)];
    // add cancel button
    
    [self.toolBar setItems:[NSArray arrayWithObjects:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneButton, nil]];
    
    [self.view addSubview:self.toolBar];
    [self.view addSubview:self.picker];
    
    [self.picker setHidden:YES];
    [self.toolBar setHidden:YES];
}

-(void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 0.35)];
    self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg", (long)self.rowNumber + 1]];
    [self.view addSubview:self.imageView];
    
    self.labelName = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.imageView.frame) + 20, self.view.frame.size.width - 40, 110)];
    self.labelName.numberOfLines = 0;
    self.labelName.text = self.info[@"CommonName"];
    self.labelName.font = [UIFont systemFontOfSize:23 weight:UIFontWeightSemibold];
    [self.labelName setTextColor:[UIColor blackColor]];
    [self.view addSubview:self.labelName];
    
    self.labelAddress = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.labelName.frame) + 5, self.view.frame.size.width - 40, 60)];
    self.labelAddress.numberOfLines = 0;
    self.labelAddress.text = self.info[@"Address"];
    self.labelAddress.font = [UIFont systemFontOfSize:16 weight:UIFontWeightSemibold];
    [self.labelAddress setTextColor:[UIColor grayColor]];
    [self.view addSubview:self.labelAddress];
    
    CGFloat y = CGRectGetMaxY(self.labelAddress.frame) + 15;
    for (int i = 0; i < 7; i++) {
        UILabel *day = [[UILabel alloc] initWithFrame:CGRectMake(20, y, self.view.frame.size.width / 3, 20)];
        day.text = self.weekDays[i];
        day.font = [UIFont systemFontOfSize:16 weight:UIFontWeightSemibold];
        [day setTextColor:[UIColor blackColor]];
        [self.view addSubview:day];
        
        UILabel *hour = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 3 + 5, y, self.view.frame.size.width / 3, 20)];
        hour.text = self.info[@"WorkHours"][[NSString stringWithFormat:@"%@", self.weekDays[i]]];
        hour.font = [UIFont systemFontOfSize:16 weight:UIFontWeightSemibold];
        [hour setTextColor:[UIColor blackColor]];
        [self.view addSubview:hour];
        y += 30;
    }
    
    self.buttonAdd = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 100, self.view.frame.size.height - 80, 200, 40)];
    [self.buttonAdd setTitle:@"Add" forState:UIControlStateNormal];
    self.buttonAdd.backgroundColor = [UIColor orangeColor];
    [self.buttonAdd setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.buttonAdd addTarget:self action:@selector(chooseDates) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.buttonAdd];
}

#pragma mark - Actions

-(void)chooseDates {
    [self.toolBar setHidden:NO];
    [self.picker setHidden:NO];
}

- (void)doneTouched:(UIBarButtonItem *)sender {
    [self.toolBar setHidden:YES];
    [self.picker setHidden:YES];
    
    // save museum to core data at chosen day
    Museum *museum = [NSEntityDescription insertNewObjectForEntityForName:@"Museum" inManagedObjectContext:self.coreDataContext];
    
    // filling
    museum.name = self.info[@"CommonName"];
    museum.address = self.info[@"Address"];
    museum.museumId = [NSString stringWithFormat:@"%ld", (long)self.rowNumber];
    // lat
    // lon
    //museum.openHours = self.info[@"WorkHours"];
    for (Day *day in self.trip.days) {
        NSLog(@"%@", day.date);
    }
    
    Day *dayInTrip = [self.trip dayForDate:self.selectedDateInPicker];
    [dayInTrip addMuseumsObject:museum];
    // weather is empty now
    
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
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE, MMM d, yyyy"];
    return [dateFormatter stringFromDate:self.availableDates[row]];
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

-(void)chooseAvailableDaysForMuseum {
    self.availableDates = [NSMutableArray<NSDate *> new];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    NSDateFormatter *weekDateFormatter = [[NSDateFormatter alloc] init];
    [weekDateFormatter setDateFormat:@"EEEE"];
    
    for (Day *day in [self.trip.days sortedArrayUsingDescriptors:@[sortDescriptor]]) {
        NSString *dayName = [weekDateFormatter stringFromDate:day.date];
        NSString *weekDayNameRu = self.weakDaysEnRu[dayName];
        if (![self.info[@"WorkHours"][weekDayNameRu] isEqualToString:@"выходной"]) {
            [self.availableDates addObject:day.date];
        }
    }
}

@end
