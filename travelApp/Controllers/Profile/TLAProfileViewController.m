//
//  TLAProfileViewController.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 23/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//


#import "TLAProfileViewController.h"
#import "TLAProfileView.h"
#import "TLAPerson.h"


@interface TLAProfileViewController ()

@property (nonatomic, strong) TLAProfileView *profileView;

@end

@implementation TLAProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
    
    TLAPerson *me = [TLAPerson new];
    me.name = @"Erzhena";
    me.sirName = @"Tsyrendylykova";
    
    self.profileView = [[TLAProfileView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) person:me];
    [self.view addSubview:self.profileView];
}

- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
}


@end
