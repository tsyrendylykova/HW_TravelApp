//
//  MuseumsForDayView.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 17/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "MuseumsForDayView.h"
#import "Constants.h"

@interface MuseumsForDayView()

@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UILabel *labelDate;
@property (nonatomic, strong) UILabel *labelChoose;
@property (nonatomic, strong) NSDateFormatter *dateFormatterFull;
@property (nonatomic, strong) NSDateFormatter *dateFormatterShort;
@property (nonatomic, strong) Trip *trip;

@end

@implementation MuseumsForDayView

-(instancetype)initWithFrame:(CGRect)frame trip:(Trip *)trip {
    self = [super initWithFrame:frame];
    if (self) {
        _trip = trip;
        [self prepareDateFormatter];
        [self prepareUI];
    }
    return self;
}

-(void)prepareUI {
    self.labelName = [[UILabel alloc] initWithFrame:CGRectMake(MuseumLabelLeftOffset, MuseumLabelFirstTopOffset, [UIScreen mainScreen].bounds.size.width - MuseumLabelWidth, MuseumLabelHeight)];
    self.labelName.text = self.trip.name;
    self.labelName.font = [UIFont systemFontOfSize:MuseumLabelNameFontSize weight:UIFontWeightSemibold];
    self.labelName.numberOfLines = 0;
    [self.labelName setTextColor:[UIColor blackColor]];
    [self addSubview:self.labelName];
    
    self.labelDate = [[UILabel alloc] initWithFrame:CGRectMake(MuseumLabelLeftOffset, CGRectGetMaxY(self.labelName.frame) + MuseumLabelTopOffset, [UIScreen mainScreen].bounds.size.width - MuseumLabelWidth, MuseumLabelDateHeight)];
    
    NSString *startDateString = [self.dateFormatterFull stringFromDate:self.trip.startDate];
    NSString *startEndString = [self.dateFormatterFull stringFromDate:self.trip.endDate];
    
    self.labelDate.text = [NSString stringWithFormat:@"%@ - %@", startDateString, startEndString];
    self.labelDate.font = [UIFont systemFontOfSize:MuseumFontSize weight:UIFontWeightSemibold];
    self.labelDate.numberOfLines = 0;
    [self.labelDate setTextColor:[UIColor grayColor]];
    [self addSubview:self.labelDate];
    
    self.labelChoose = [[UILabel alloc] initWithFrame:CGRectMake(MuseumLabelLeftOffset, CGRectGetMaxY(self.labelDate.frame) + MuseumLabelSecondTopOffset, [UIScreen mainScreen].bounds.size.width - MuseumLabelWidth, MuseumLabelHeight)];
    self.labelChoose.text = @"Choose";
    self.labelChoose.font = [UIFont systemFontOfSize:MuseumFontSize weight:UIFontWeightSemibold];
    [self.labelChoose setTextColor:[UIColor blackColor]];
    [self addSubview:self.labelChoose];
}

-(void)prepareDateFormatter {
    self.dateFormatterFull = [[NSDateFormatter alloc] init];
    [self.dateFormatterFull setDateFormat:@"EEEE, MMM d, yyyy"];
    
    self.dateFormatterShort = [[NSDateFormatter alloc] init];
    [self.dateFormatterShort setDateFormat:@"MMM d"];
}

@end
