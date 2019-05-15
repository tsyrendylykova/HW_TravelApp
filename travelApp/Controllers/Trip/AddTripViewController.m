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


@interface AddTripViewController ()

@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UILabel *labelStartDate;
@property (nonatomic, strong) UILabel *labelEndDate;
@property (nonatomic, strong) UIButton *createTripButton;
@property (nonatomic, strong) UITextField *textFieldName;
@property (nonatomic, strong) UITextField *textFieldStartDate;
@property (nonatomic, strong) UITextField *textFieldEndDate;
@property (nonatomic, strong) UIDatePicker *startDatePicker;
@property (nonatomic, strong) UIDatePicker *endDatePicker;

@end

@implementation AddTripViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
    [self prepareDetailsForTrip];
}

-(void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"New trip";
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(goBackToVC)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}

-(void)prepareDetailsForTrip {
    self.labelName = [[UILabel alloc] initWithFrame:CGRectMake(40, 100, 100, 60)];
    self.labelName.text = @"Name";
    self.labelName.font = [UIFont systemFontOfSize:18 weight:UIFontWeightSemibold];
    [self.view addSubview:self.labelName];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(self.labelName.frame) + 10, self.view.frame.size.width - 60, 0.5)];
    line1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line1];
    
    self.labelStartDate = [[UILabel alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(line1.frame) + 10, 100, 60)];
    self.labelStartDate.text = @"Start date";
    self.labelStartDate.font = [UIFont systemFontOfSize:18 weight:UIFontWeightSemibold];
    [self.view addSubview:self.labelStartDate];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(self.labelStartDate.frame) + 10, self.view.frame.size.width - 60, 0.5)];
    line2.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line2];
    
    self.labelEndDate = [[UILabel alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(line2.frame) + 10, 100, 60)];
    self.labelEndDate.text = @"End date";
    self.labelEndDate.font = [UIFont systemFontOfSize:18 weight:UIFontWeightSemibold];
    [self.view addSubview:self.labelEndDate];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(self.labelEndDate.frame) + 10, self.view.frame.size.width - 60, 0.5)];
    line3.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line3];
    
    self.createTripButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 150, CGRectGetMaxY(line3.frame) + 40, 300, 40)];
    self.createTripButton.backgroundColor = [UIColor blueColor];
    [self.createTripButton setTitle:@"CREATE TRIP" forState:UIControlStateNormal];
    [self.createTripButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.createTripButton.layer.cornerRadius = 10;
    self.createTripButton.layer.masksToBounds = YES;
    [self.createTripButton addTarget:self action:@selector(addNewTripAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.createTripButton];
    
    self.textFieldName = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 230, 100, 200, 60)];
    self.textFieldName.textAlignment = NSTextAlignmentRight;
    self.textFieldName.placeholder = @"Trip to London";
    [self.textFieldName setFont:[UIFont systemFontOfSize:18 weight:UIFontWeightSemibold]];
    [self.textFieldName setTextColor:[UIColor blueColor]];
    [self.view addSubview:self.textFieldName];
    
    self.startDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    [self.startDatePicker setDatePickerMode:UIDatePickerModeDate];
    [self.startDatePicker addTarget:self action:@selector(onDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.endDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    [self.endDatePicker setDatePickerMode:UIDatePickerModeDate];
    [self.endDatePicker addTarget:self action:@selector(onDateEndPickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.textFieldStartDate = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 230, CGRectGetMaxY(line1.frame) + 10, 200, 60)];
    self.textFieldStartDate.inputView = self.startDatePicker;
    self.textFieldStartDate.textAlignment = NSTextAlignmentRight;
    self.textFieldStartDate.placeholder = @"30/04/2019";
    [self.textFieldStartDate setFont:[UIFont systemFontOfSize:18 weight:UIFontWeightSemibold]];
    [self.textFieldStartDate setTextColor:[UIColor blueColor]];
    [self.view addSubview:self.textFieldStartDate];
    
    self.textFieldEndDate = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 230, CGRectGetMaxY(line2.frame) + 10, 200, 60)];
    self.textFieldEndDate.inputView = self.endDatePicker;
    self.textFieldEndDate.textAlignment = NSTextAlignmentRight;
    self.textFieldEndDate.placeholder = @"01/05/2019";
    [self.textFieldEndDate setFont:[UIFont systemFontOfSize:18 weight:UIFontWeightSemibold]];
    [self.textFieldEndDate setTextColor:[UIColor blueColor]];
    [self.view addSubview:self.textFieldEndDate];

}

#pragma mark - UIDatePicker

- (void)onDatePickerValueChanged:(UIDatePicker *)datePicker
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = datePicker.date;
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    self.textFieldStartDate.text = [NSString stringWithFormat:@"%@",dateString];
    [self.view endEditing:YES]; // ???
}

- (void)onDateEndPickerValueChanged:(UIDatePicker *)datePicker
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = datePicker.date;
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    self.textFieldEndDate.text = [NSString stringWithFormat:@"%@",dateString];
    [self.view endEditing:YES];
}

#pragma mark - CoreData Stack

- (NSManagedObjectContext *)coreDataContext
{
    UIApplication *application = [UIApplication sharedApplication];
    NSPersistentContainer *container = ((AppDelegate *)(application.delegate)).persistentContainer;
    NSManagedObjectContext *context = container.viewContext;
    
    return context;
}

#pragma mark - Actions

-(void)addNewTripAction {
    Trip *trip = [NSEntityDescription insertNewObjectForEntityForName:@"Trip" inManagedObjectContext:self.coreDataContext];
    
    trip.name = self.textFieldName.text;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSDate *startDate = [dateFormatter dateFromString:self.textFieldStartDate.text];
    trip.startDate = startDate;
    
    NSDate *endDate = [dateFormatter dateFromString:self.textFieldEndDate.text];
    trip.endDate = endDate;
    
    NSSet<Day *> *dates = [NSSet setWithSet:[self getArrayOfDays:trip]];
    [trip addDays:dates];
    
//    trip.image =
    
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
