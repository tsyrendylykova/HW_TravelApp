//
//  TLAAddTripViewController.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 29/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//


#import "TLAAddTripViewController.h"
#import "Trip+CoreDataClass.h"
#import "Day+CoreDataClass.h"
#import "TLAConstants.h"
#import "TLAAddNewTrip.h"


@interface TLAAddTripViewController () <TLAAddNewTripDelegate>

@property (nonatomic, strong) TLAAddNewTrip *addNewTrip;
@property (nonatomic, strong) TLAAddTripService *addTripService;

@end

@implementation TLAAddTripViewController

- (instancetype)initWithAddTripService:(TLAAddTripService *)service {
    self = [super init];
    if (self)
    {
        _addTripService = service;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
    self.addNewTrip = [[TLAAddNewTrip alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.addNewTrip.addNewTripDelegate = self;
    [self.view addSubview:self.addNewTrip];
    [self.view bringSubviewToFront:self.addNewTrip];
}

- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"New trip";
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(goBackToVC)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}


#pragma mark - AddNewTripDelegate

- (void)addNewTripActionWith:(NSDate *)startDate endDate:(NSDate *)endDate name:(NSString *)name {

    [self.addTripService addNewTripActionWith:startDate endDate:endDate name:name];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)goBackToVC {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
