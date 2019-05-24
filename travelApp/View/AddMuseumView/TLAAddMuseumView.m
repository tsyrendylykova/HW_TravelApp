//
//  TLAAddMuseumView.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 17/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//


#import "TLAAddMuseumView.h"
#import "TLAConstants.h"


@interface TLAAddMuseumView()

@property (nonatomic, strong) Trip *trip;
@property (nonatomic, assign) NSInteger rowNumber;
@property (nonatomic, strong) NSMutableDictionary *info;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UILabel *labelAddress;
@property (nonatomic, copy) NSArray<NSString *> *weekDays;
@property (nonatomic, strong) UIButton *buttonAdd;

@end


@implementation TLAAddMuseumView

- (instancetype)initWithFrame:(CGRect)frame trip:(Trip *)trip info:(NSMutableDictionary *)info rowNumber:(NSInteger)rowNumber
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _trip = trip;
        _info = info;
        _rowNumber = rowNumber;
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI
{
    self.backgroundColor = [UIColor whiteColor];

    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * TLAAddMuseumImagePartHeight)];
    self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg", (long)self.rowNumber + 1]];
    [self addSubview:self.imageView];

    self.labelName = [[UILabel alloc] initWithFrame:CGRectMake(TLAAddMuseumLeftOffset, CGRectGetMaxY(self.imageView.frame) + TLAAddMuseumLabelNameTopOffset, [UIScreen mainScreen].bounds.size.width - TLAAddMuseumLabelNameWidth, TLAAddMuseumLabelNameHeight)];
    self.labelName.numberOfLines = 0;
    self.labelName.text = self.info[@"CommonName"];
    self.labelName.font = [UIFont systemFontOfSize:TLAAddMuseumLabelNameFont weight:UIFontWeightSemibold];
    [self.labelName setTextColor:[UIColor blackColor]];
    [self addSubview:self.labelName];

    self.labelAddress = [[UILabel alloc] initWithFrame:CGRectMake(TLAAddMuseumLeftOffset, CGRectGetMaxY(self.labelName.frame) + TLAAddMuseumLabelAddressTopOffset, [UIScreen mainScreen].bounds.size.width - TLAAddMuseumLabelNameWidth, TLAAddMuseumLabelAddressHeight)];
    self.labelAddress.numberOfLines = 0;
    self.labelAddress.text = self.info[@"Address"];
    self.labelAddress.font = [UIFont systemFontOfSize:TLAAddMuseumFont weight:UIFontWeightSemibold];
    [self.labelAddress setTextColor:[UIColor grayColor]];
    [self addSubview:self.labelAddress];
    
    self.weekDays = @[@"понедельник", @"вторник", @"среда", @"четверг", @"пятница", @"суббота", @"воскресенье"];

    CGFloat y = CGRectGetMaxY(self.labelAddress.frame) + TLAAddMuseumDayTopOffset;
    for (int i = 0; i < 7; i++)
    {
        UILabel *day = [[UILabel alloc] initWithFrame:CGRectMake(TLAAddMuseumLeftOffset, y, [UIScreen mainScreen].bounds.size.width / 3, TLAAddMuseumDayHeight)];
        day.text = self.weekDays[i];
        day.font = [UIFont systemFontOfSize:TLAAddMuseumFont weight:UIFontWeightSemibold];
        [day setTextColor:[UIColor blackColor]];
        [self addSubview:day];

        UILabel *hour = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 3 + TLAAddMuseumHourTopOffset, y, [UIScreen mainScreen].bounds.size.width / 3, TLAAddMuseumDayHeight)];
        hour.text = self.info[@"WorkHours"][[NSString stringWithFormat:@"%@", self.weekDays[i]]];
        hour.font = [UIFont systemFontOfSize:TLAAddMuseumFont weight:UIFontWeightSemibold];
        [hour setTextColor:[UIColor blackColor]];
        [self addSubview:hour];
        y += TLAAddMuseumHourHeight;
    }

    self.buttonAdd = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - TLAAddMuseumButtonTopOffset, [UIScreen mainScreen].bounds.size.height - TLAAddMuseumButtonLeftOffset, TLAAddMuseumButtonWidth, TLAAddMuseumButtonHeight)];
    [self.buttonAdd setTitle:@"Add" forState:UIControlStateNormal];
    self.buttonAdd.backgroundColor = [UIColor orangeColor];
    [self.buttonAdd setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.buttonAdd addTarget:self action:@selector(chooseDates) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.buttonAdd];
}


#pragma mark - Actions

- (void)chooseDates
{
    [self.addNewMuseumDelegate chooseDates];
}

@end
