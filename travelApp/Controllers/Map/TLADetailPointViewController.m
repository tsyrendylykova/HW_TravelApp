//
//  TLADetailPointViewController.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 25/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//


#import "TLADetailPointViewController.h"
#import "TLAConstants.h"


@interface TLADetailPointViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) TLAMapPoint *mapPoint;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TLADetailPointViewController

- (instancetype)initWithMapPoint:(TLAMapPoint *)mapPoint {
    self = [super init];
    if (self)
    {
        _mapPoint = mapPoint;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TLADetailPointViewControllerCellIdentifier];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(goBackToVC)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    self.navigationItem.title = self.mapPoint.name;
    self.title = self.mapPoint.name;
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, TLATopOffset, self.view.frame.size.width, self.view.frame.size.height * TLADetailViewImageViewPercentHeight)];
    self.imageView.image = self.mapPoint.categoryImage;
    [self.imageView.layer setCornerRadius:TLADetailViewImageCornerRadius];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.imageView setClipsToBounds:YES];
    [self.imageView setBackgroundColor:[UIColor colorWithRed:TLADetailViewImageRed green:TLADetailViewImageGreen blue:TLADetailViewImageBlue alpha:TLAAlphaColor]];
    [self.view addSubview:self.imageView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imageView.frame) + TLADetailTableViewTopOffset, self.view.frame.size.width, TLADetailTableViewHeight)];
    [self.view addSubview:self.tableView];
    
}



- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TLADetailPointViewControllerCellIdentifier forIndexPath:indexPath];
    if (indexPath.row == 0)
    {
        cell.textLabel.text = self.mapPoint.name;
    }
    else if (indexPath.row == 1)
    {
        cell.textLabel.text = self.mapPoint.address;
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


#pragma mark - Methods

- (void)goBackToVC {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
