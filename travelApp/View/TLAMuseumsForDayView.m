//
//  MTLAMuseumsForDayView.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 17/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//


#import "TLAMuseumsForDayView.h"
#import "TLAConstants.h"


@interface TLAMuseumsForDayView()

@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UILabel *labelDate;
@property (nonatomic, strong) UILabel *labelChoose;
@property (nonatomic, strong) NSDateFormatter *dateFormatterFull;
@property (nonatomic, strong) NSDateFormatter *dateFormatterShort;
@property (nonatomic, strong) Trip *trip;

@end


@implementation TLAMuseumsForDayView

- (instancetype)initWithFrame:(CGRect)frame trip:(Trip *)trip
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _trip = trip;
        [self prepareDateFormatter];
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI
{
    self.labelName = [[UILabel alloc] initWithFrame:CGRectMake(TLAMuseumLabelLeftOffset, TLAMuseumLabelFirstTopOffset, [UIScreen mainScreen].bounds.size.width - TLAMuseumLabelWidth, TLAMuseumLabelHeight)];
    self.labelName.text = self.trip.name;
    self.labelName.font = [UIFont systemFontOfSize:TLAMuseumLabelNameFontSize weight:UIFontWeightSemibold];
    self.labelName.numberOfLines = 0;
    [self.labelName setTextColor:[UIColor blackColor]];
    [self addSubview:self.labelName];
    
    self.labelDate = [[UILabel alloc] initWithFrame:CGRectMake(TLAMuseumLabelLeftOffset, CGRectGetMaxY(self.labelName.frame) + TLAMuseumLabelTopOffset, [UIScreen mainScreen].bounds.size.width - TLAMuseumLabelWidth, TLAMuseumLabelDateHeight)];
    
    NSString *startDateString = [self.dateFormatterFull stringFromDate:self.trip.startDate];
    NSString *startEndString = [self.dateFormatterFull stringFromDate:self.trip.endDate];
    
    self.labelDate.text = [NSString stringWithFormat:@"%@ - %@", startDateString, startEndString];
    self.labelDate.font = [UIFont systemFontOfSize:TLAMuseumFontSize weight:UIFontWeightSemibold];
    self.labelDate.numberOfLines = 0;
    [self.labelDate setTextColor:[UIColor grayColor]];
    [self addSubview:self.labelDate];
    
    self.labelChoose = [[UILabel alloc] initWithFrame:CGRectMake(TLAMuseumLabelLeftOffset, CGRectGetMaxY(self.labelDate.frame) + TLAMuseumLabelSecondTopOffset, [UIScreen mainScreen].bounds.size.width - TLAMuseumLabelWidth, TLAMuseumLabelHeight)];
    self.labelChoose.text = @"Choose";
    self.labelChoose.font = [UIFont systemFontOfSize:TLAMuseumFontSize weight:UIFontWeightSemibold];
    [self.labelChoose setTextColor:[UIColor blackColor]];
    [self addSubview:self.labelChoose];
    
    self.labelShow = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.labelChoose.frame) + 100, [UIScreen mainScreen].bounds.size.width, 40)];
    self.labelShow.text = @"Выберите даты";
    self.labelShow.font = [UIFont systemFontOfSize:22 weight:UIFontWeightSemibold];
    self.labelShow.textColor = [UIColor blackColor];
    self.labelShow.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.labelShow];
}

- (void)prepareDateFormatter
{
    self.dateFormatterFull = [[NSDateFormatter alloc] init];
    [self.dateFormatterFull setDateFormat:@"EEEE, MMM d, yyyy"];
    
    self.dateFormatterShort = [[NSDateFormatter alloc] init];
    [self.dateFormatterShort setDateFormat:@"MMM d"];
}

@end
