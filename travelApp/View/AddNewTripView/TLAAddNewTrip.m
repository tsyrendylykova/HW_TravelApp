//
//  TLAAddNewTrip.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 17/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "TLAAddNewTrip.h"
#import "Constants.h"

@interface TLAAddNewTrip()

@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UILabel *labelStartDate;
@property (nonatomic, strong) UILabel *labelEndDate;
@property (nonatomic, strong) UIButton *createTripButton;
@property (nonatomic, strong) UITextField *textFieldName;
@property (nonatomic, strong) UITextField *textFieldStartDate;
@property (nonatomic, strong) UITextField *textFieldEndDate;
@property (nonatomic, strong) UIDatePicker *startDatePicker;
@property (nonatomic, strong) UIDatePicker *endDatePicker;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;


@end

@implementation TLAAddNewTrip

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareDetailsForTrip];
        [self prepareDateRormatter];
    }
    return self;
}

-(void)prepareDetailsForTrip {
    self.labelName = [[UILabel alloc] initWithFrame:CGRectMake(AddTripLabelNameLeftOffset, AddTripLabelNameTopOffset, AddTripLabelNameWidth, AddTripLabelNameHeight)];
    self.labelName.text = @"Name";
    self.labelName.font = [UIFont systemFontOfSize:AddTripFontSize weight:UIFontWeightSemibold];
    [self addSubview:self.labelName];
    
    UIView *firstLineView = [[UIView alloc] initWithFrame:CGRectMake(AddTripLineLeftOffset, CGRectGetMaxY(self.labelName.frame) + AddTripLineTopOffset, [UIScreen mainScreen].bounds.size.width - AddTripLineWidth, AddTripLineHeight)];
    firstLineView.backgroundColor = [UIColor grayColor];
    [self addSubview:firstLineView];
    
    self.labelStartDate = [[UILabel alloc] initWithFrame:CGRectMake(AddTripLabelNameLeftOffset, CGRectGetMaxY(firstLineView.frame) + AddTripLabelTopOffset, AddTripLabelNameWidth, AddTripLabelNameHeight)];
    self.labelStartDate.text = @"Start date";
    self.labelStartDate.font = [UIFont systemFontOfSize:AddTripFontSize weight:UIFontWeightSemibold];
    [self addSubview:self.labelStartDate];
    
    UIView *secondLineView = [[UIView alloc] initWithFrame:CGRectMake(AddTripLineLeftOffset, CGRectGetMaxY(self.labelStartDate.frame) + AddTripLineTopOffset, [UIScreen mainScreen].bounds.size.width - AddTripLineWidth, AddTripLineHeight)];
    secondLineView.backgroundColor = [UIColor grayColor];
    [self addSubview:secondLineView];
    
    self.labelEndDate = [[UILabel alloc] initWithFrame:CGRectMake(AddTripLabelNameLeftOffset, CGRectGetMaxY(secondLineView.frame) + AddTripLabelTopOffset, AddTripLabelNameWidth, AddTripLabelNameHeight)];
    self.labelEndDate.text = @"End date";
    self.labelEndDate.font = [UIFont systemFontOfSize:AddTripFontSize weight:UIFontWeightSemibold];
    [self addSubview:self.labelEndDate];
    
    UIView *thirdLineView = [[UIView alloc] initWithFrame:CGRectMake(AddTripLineLeftOffset, CGRectGetMaxY(self.labelEndDate.frame) + AddTripLineTopOffset, [UIScreen mainScreen].bounds.size.width - AddTripLineWidth, AddTripLineHeight)];
    thirdLineView.backgroundColor = [UIColor grayColor];
    [self addSubview:thirdLineView];
    
    self.createTripButton = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - AddTripCreateTopOffset, CGRectGetMaxY(thirdLineView.frame) + AddTripCreateLeftOffset, AddTripCreateWidth, AddTripCreateHeight)];
    self.createTripButton.userInteractionEnabled = @YES;
    self.createTripButton.backgroundColor = [UIColor blueColor];
    [self.createTripButton setTitle:@"CREATE TRIP" forState:UIControlStateNormal];
    [self.createTripButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.createTripButton.layer.cornerRadius = AddTripCreateCornerRadius;
    self.createTripButton.layer.masksToBounds = @YES;
    [self.createTripButton addTarget:self action:@selector(addNewTripButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.createTripButton];
    
    self.textFieldName = [[UITextField alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - AddTripFieldLeftOffset, AddTripFieldFirstTopOffset, AddTripFieldWidth, AddTripFieldHeight)];
    self.textFieldName.textAlignment = NSTextAlignmentRight;
    self.textFieldName.placeholder = @"Trip to London";
    [self.textFieldName setFont:[UIFont systemFontOfSize:AddTripFontSize weight:UIFontWeightSemibold]];
    [self.textFieldName setTextColor:[UIColor blueColor]];
    [self addSubview:self.textFieldName];
    
    self.startDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    [self.startDatePicker setDatePickerMode:UIDatePickerModeDate];
    [self.startDatePicker addTarget:self action:@selector(onDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.endDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    [self.endDatePicker setDatePickerMode:UIDatePickerModeDate];
    [self.endDatePicker addTarget:self action:@selector(onDateEndPickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.textFieldStartDate = [[UITextField alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - AddTripFieldLeftOffset, CGRectGetMaxY(firstLineView.frame) + AddTripFieldTopOffset, AddTripFieldWidth, AddTripFieldHeight)];
    self.textFieldStartDate.inputView = self.startDatePicker;
    self.textFieldStartDate.textAlignment = NSTextAlignmentRight;
    self.textFieldStartDate.placeholder = @"30/04/2019";
    [self.textFieldStartDate setFont:[UIFont systemFontOfSize:AddTripFontSize weight:UIFontWeightSemibold]];
    [self.textFieldStartDate setTextColor:[UIColor blueColor]];
    [self addSubview:self.textFieldStartDate];
    
    self.textFieldEndDate = [[UITextField alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - AddTripFieldLeftOffset, CGRectGetMaxY(secondLineView.frame) + AddTripFieldTopOffset, AddTripFieldWidth, AddTripFieldHeight)];
    self.textFieldEndDate.inputView = self.endDatePicker;
    self.textFieldEndDate.textAlignment = NSTextAlignmentRight;
    self.textFieldEndDate.placeholder = @"01/05/2019";
    [self.textFieldEndDate setFont:[UIFont systemFontOfSize:AddTripFontSize weight:UIFontWeightSemibold]];
    [self.textFieldEndDate setTextColor:[UIColor blueColor]];
    [self addSubview:self.textFieldEndDate];
    
}

-(void)prepareDateRormatter {
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"dd/MM/yyyy"];
}

#pragma mark - Actions

-(void)addNewTripButton {
    [self.addNewTripDelegate addNewTripActionWith:self.startDatePicker.date endDate:_endDatePicker.date name:self.textFieldName.text];
}

-(void)onDatePickerValueChanged:(UIDatePicker *)datePicker {
    NSString *dateString = [self.dateFormatter stringFromDate:datePicker.date];
    self.textFieldStartDate.text = [NSString stringWithFormat:@"%@", dateString];;
}

-(void)onDateEndPickerValueChanged:(UIDatePicker *)datePicker {
    NSString *dateString = [self.dateFormatter stringFromDate:datePicker.date];
    self.textFieldEndDate.text = [NSString stringWithFormat:@"%@",dateString];
}

@end
