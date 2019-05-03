//
//  AddMuseumViewController.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 03/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "AddMuseumViewController.h"

@interface AddMuseumViewController ()

@property (nonatomic, strong) NSMutableArray *dates;
@property (nonatomic, assign) NSInteger rowNumber;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSMutableDictionary *info;
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UILabel *labelAddress;
@property (nonatomic, strong) UILabel *labelWorkingHours;
@property (nonatomic, strong) NSArray *weekDays;

@end

@implementation AddMuseumViewController

-(instancetype)initWithDates: (NSMutableArray *)dates rowNumber:(NSInteger)rowNumber info:(NSMutableDictionary *)info {
    self = [super init];
    if (self) {
        _dates = dates;
        _rowNumber = rowNumber;
        _info = info;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.weekDays = [NSArray arrayWithObjects:@"понедельник", @"вторник", @"среда", @"четверг", @"пятница", @"суббота", @"воскресенье", nil];
    
    [self prepareUI];
    

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
    
    self.labelWorkingHours = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.labelName.frame) + 5, self.view.frame.size.width - 40, 60)];
    self.labelWorkingHours.numberOfLines = 0;
    self.labelWorkingHours.text = self.info[@"Address"];
    self.labelWorkingHours.font = [UIFont systemFontOfSize:16 weight:UIFontWeightSemibold];
    [self.labelWorkingHours setTextColor:[UIColor grayColor]];
    [self.view addSubview:self.labelWorkingHours];
    
    CGFloat y = CGRectGetMaxY(self.labelWorkingHours.frame) + 15;
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
}

@end
