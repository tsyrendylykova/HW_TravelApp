//
//  TLAAddMuseumViewController.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 03/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//


#import "TLAAddMuseumViewController.h"
#import "Museum+CoreDataClass.h"
#import "Day+CoreDataClass.h"
#import "TLAConstants.h"
#import "TLAAddMuseumView.h"


@import CoreData;

@interface TLAAddMuseumViewController () <UIPickerViewDelegate, UIPickerViewDataSource, NSFetchedResultsControllerDelegate, TLAAddMuseumDelegate>


@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) NSDate *selectedDateInPicker;
@property (nonatomic, strong) NSMutableArray<NSDate *> *availableDates;
@property (nonatomic, copy) NSDictionary<NSString *, NSString *> *weakDaysEnRu;
@property (nonatomic, strong) NSDateFormatter *dateFormatterFull;
@property (nonatomic, strong) NSDateFormatter *dateFormatterShort;
@property (nonatomic, strong) TLAAddMuseumView *addMuseumView;
@property (nonatomic, strong) TLAAddMuseumService *addMuseumService;
@property (nonatomic, strong) Trip *trip;
@property (nonatomic, assign) NSInteger rowNumber;
@property (nonatomic, strong) NSMutableDictionary *info;

@end

@implementation TLAAddMuseumViewController

- (instancetype)initWithTrip:(Trip *)trip rowNumber:(NSInteger)rowNumber info:(NSMutableDictionary *)info addMuseumService:(TLAAddMuseumService *)service
{
    self = [super init];
    if (self)
    {
        _trip = trip;
        _rowNumber = rowNumber;
        _info = info;
        _addMuseumService = service;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.weakDaysEnRu = @{@"понедельник": @"Monday", @"вторник": @"Tuesday", @"среда": @"Wednesday", @"четверг": @"Thursday", @"пятница": @"Friday", @"суббота": @"Saturday", @"воскресенье": @"Sunday"};
    [self chooseAvailableDaysForMuseum];
    self.addMuseumView = [[TLAAddMuseumView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) trip:self.trip info:self.info rowNumber:self.rowNumber];
    self.addMuseumView.addNewMuseumDelegate = self;
    [self.view addSubview:self.addMuseumView];
    
    [self prepareUI];
    [self prepareDateRormatter];
}

- (void)prepareUI {
    self.picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height * TLAAddMuseumPickerPartTopOffset + TLAAddMuseumPickerTopOffset, self.view.frame.size.width, self.view.frame.size.height * TLAAddMuseumPickerPartHeight)];
    self.picker.backgroundColor = [UIColor whiteColor];
    self.picker.showsSelectionIndicator = @YES;
    self.picker.delegate = self;
    self.picker.dataSource = self;
    
    self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height * TLAAddMuseumToolbarPartTopOffset, self.view.frame.size.width, TLAAddMuseumToolbarHeight)];
    self.toolBar.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched:)];
    
    self.toolBar.items = @[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneButton];
    
    [self.view addSubview:self.toolBar];
    [self.view addSubview:self.picker];
    
    [self.picker setHidden:YES];
    [self.toolBar setHidden:YES];
}

- (void)prepareDateRormatter {
    self.dateFormatterFull = [[NSDateFormatter alloc] init];
    [self.dateFormatterFull setDateFormat:@"EEEE, MMM d, yyyy"];
    
    self.dateFormatterShort = [[NSDateFormatter alloc] init];
    [self.dateFormatterShort setDateFormat:@"EEEE"];
}


#pragma mark - AddMuseumDelegate

- (void)chooseDates {
    [self.toolBar setHidden:NO];
    [self.picker setHidden:NO];
}


#pragma mark - Actions

- (void)doneTouched:(UIBarButtonItem *)sender {
    [self.toolBar setHidden:YES];
    [self.picker setHidden:YES];
    
    [self.addMuseumService saveWithInfo:self.info rowNumber:self.rowNumber trip:self.trip electedDateInPicker:self.selectedDateInPicker];
    [self dismissViewControllerAnimated:YES completion:nil];
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


#pragma mark - Methods

- (void)chooseAvailableDaysForMuseum {
    self.availableDates = [NSMutableArray<NSDate *> new];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    
    for (Day *day in [self.trip.days sortedArrayUsingDescriptors:@[sortDescriptor]]) {
        NSString *dayName = [self.dateFormatterShort stringFromDate:day.date];
        NSString *weekDayNameRu = self.weakDaysEnRu[dayName];
        if (![self.info[@"WorkHours"][weekDayNameRu] isEqualToString:@"выходной"])
        {
            [self.availableDates addObject:day.date];
        }
    }
}

@end
