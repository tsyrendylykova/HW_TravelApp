//
//  ProfileView.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 17/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "ProfileView.h"

@interface ProfileView()

@property (nonatomic, strong) TAPerson *person;

@end

@implementation ProfileView

-(instancetype)initWithFrame:(CGRect)frame person:(TAPerson *)person {
    self = [super initWithFrame:frame];
    if (self) {
        _person = person;
        [self prepareUI];
    }
    return self;
}

-(void)prepareUI {
    UIImageView *topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.3)];
    topView.image = [UIImage imageNamed:@"color"];
    [self addSubview:topView];
    
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height * 0.3, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.3)];
    centerView.backgroundColor = [UIColor colorWithRed:216/255.0 green:208/255.0 blue:195/255.0 alpha:0.15];
    [self addSubview:centerView];
    
    UILabel *labelName = [[UILabel alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height * 0.4, [UIScreen mainScreen].bounds.size.width, 30)];
    labelName.text = self.person.name;
    labelName.textAlignment = NSTextAlignmentCenter;
    labelName.font = [UIFont systemFontOfSize:33 weight:UIFontWeightBold];
    [self addSubview:labelName];
    
    UILabel *labelSirName = [[UILabel alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height * 0.45, [UIScreen mainScreen].bounds.size.width, 50)];
    labelSirName.text = self.person.sirName;
    labelSirName.textAlignment = NSTextAlignmentCenter;
    labelSirName.font = [UIFont systemFontOfSize:33 weight:UIFontWeightBold];
    [self addSubview:labelSirName];
    
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - [UIScreen mainScreen].bounds.size.height * 0.2 / 2, [UIScreen mainScreen].bounds.size.height * 0.2, [UIScreen mainScreen].bounds.size.height * 0.2, [UIScreen mainScreen].bounds.size.height * 0.2)];
    iconView.image = [UIImage imageNamed:@"iconman"];
    iconView.contentMode = UIViewContentModeScaleAspectFit;
    iconView.backgroundColor = [UIColor whiteColor];
    iconView.layer.cornerRadius = iconView.frame.size.height / 2;
    iconView.layer.masksToBounds = @YES;
    [self addSubview:iconView];
}

@end
