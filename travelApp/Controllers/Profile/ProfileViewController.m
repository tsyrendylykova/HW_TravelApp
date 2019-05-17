//
//  ProfileViewController.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 23/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileView.h"
#import "TAPerson.h"

@interface ProfileViewController ()

@property (nonatomic, strong) ProfileView *profileView;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
    
    TAPerson *me = [TAPerson new];
    me.name = @"Erzhena";
    me.sirName = @"Tsyrendylykova";
    
    self.profileView = [[ProfileView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) person:me];
    [self.view addSubview:self.profileView];
}

-(void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
}


@end
