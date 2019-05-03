//
//  ChooseMuseumViewController.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 02/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "ChooseMuseumViewController.h"
#import "ChooseMuseumForDayViewController.h"

@interface ChooseMuseumViewController () 

@property (nonatomic, strong) Trip *trip;
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UILabel *labelDate;
@property (nonatomic, strong) UILabel *labelChoose;
@property (nonatomic, strong) NSMutableArray *dates;

@end

@implementation ChooseMuseumViewController

-(instancetype)initWithTrip: (Trip *)trip {
    self = [super init];
    if (self) {
        _trip = trip;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getArrayOfDays];
    
    [self prepareUI];
    [self prepareDays];
    
}

-(void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(goBackToVC)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleDone target:self action:@selector(addNewMuseums)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    self.labelName = [[UILabel alloc] initWithFrame:CGRectMake(20, 110, self.view.frame.size.width - 40, 20)];
    self.labelName.text = self.trip.name;
    self.labelName.font = [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
    self.labelName.numberOfLines = 0;
    [self.labelName setTextColor:[UIColor blackColor]];
    [self.view addSubview:self.labelName];
    
    self.labelDate = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.labelName.frame) + 10, self.view.frame.size.width - 40, 60)];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *startDate = self.trip.startDate;
    NSDate *endDate = self.trip.endDate;
    [dateFormat setDateFormat:@"EEEE, MMM d, yyyy"];
    //MMM d, yyyy
    
    NSString *startDateString = [dateFormat stringFromDate:startDate];
    NSString *startEndString = [dateFormat stringFromDate:endDate];
    
    self.labelDate.text = [NSString stringWithFormat:@"%@ - %@", startDateString, startEndString];
    self.labelDate.font = [UIFont systemFontOfSize:16 weight:UIFontWeightSemibold];
    self.labelDate.numberOfLines = 0;
    [self.labelDate setTextColor:[UIColor grayColor]];
    [self.view addSubview:self.labelDate];
    
    self.labelChoose = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.labelDate.frame) + 5, self.view.frame.size.width - 40, 20)];
    self.labelChoose.text = @"Choose ";
    self.labelChoose.font = [UIFont systemFontOfSize:16 weight:UIFontWeightSemibold];
    [self.labelChoose setTextColor:[UIColor blackColor]];
    [self.view addSubview:self.labelChoose];
}

-(void)getArrayOfDays {

    NSDate *startDate = self.trip.startDate;
    NSDate *endDate = self.trip.endDate;
    
    self.dates = [NSMutableArray new];
    [self.dates addObject:startDate];

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
        [self.dates addObject:date];
    }
    
    [self.dates addObject:endDate];

}

-(void)prepareDays {
    CGFloat x = 20;

    for (int i = 0; i < self.dates.count; i++) {
        UIView *dateView = [[UILabel alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(self.labelChoose.frame) + 10, 50, 50)];
        dateView.layer.cornerRadius = 25;
        dateView.layer.masksToBounds = YES;
        dateView.layer.borderWidth = 2;
        dateView.layer.borderColor = [UIColor blackColor].CGColor;
        
        UILabel *newDate = [[UILabel alloc] initWithFrame:CGRectMake(x + 10, CGRectGetMaxY(self.labelChoose.frame) + 10, 50, 50)];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MMM d"];
        NSString *date = [dateFormat stringFromDate:self.dates[i]];
        newDate.text = date;
        newDate.font = [UIFont systemFontOfSize:10 weight:UIFontWeightThin];
        [newDate setTextColor:[UIColor blackColor]];
        x += 70;
        [self.view addSubview:dateView];
        [self.view addSubview:newDate];
    }
}



#pragma mark - Actions

-(void)goBackToVC {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addNewMuseums {
    ChooseMuseumForDayViewController *newVC = [ChooseMuseumForDayViewController new];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:newVC];
    [self presentViewController:navVC animated:YES completion:nil];
}



@end
