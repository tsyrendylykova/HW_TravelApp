//
//  DetailPointViewController.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 25/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "DetailPointViewController.h"
#import "Constants.h"

@interface DetailPointViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MapPoint *mapPoint;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DetailPointViewController

-(instancetype)initWithMapPoint: (MapPoint *)mapPoint {
    self = [super init];
    if (self) {
        _mapPoint = mapPoint;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:DetailPointViewControllerCellIdentifier];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(goBackToVC)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    self.navigationItem.title = self.mapPoint.name;
    self.title = self.mapPoint.name;
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, TopOffset, self.view.frame.size.width, self.view.frame.size.height * DetailViewImageViewPercentHeight)];
    self.imageView.image = self.mapPoint.categoryImage;
    [self.imageView.layer setCornerRadius:DetailViewImageCornerRadius];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.imageView setClipsToBounds:YES];
    [self.imageView setBackgroundColor:[UIColor colorWithRed:DetailViewImageRed green:DetailViewImageGreen blue:DetailViewImageBlue alpha:AlphaColor]];
    [self.view addSubview:self.imageView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imageView.frame) + DetailTableViewTopOffset, self.view.frame.size.width, DetailTableViewHeight)];
    [self.view addSubview:self.tableView];
    
}



- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DetailPointViewControllerCellIdentifier forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.textLabel.text = self.mapPoint.name;
    }
    else if (indexPath.row == 1) {
        cell.textLabel.text = self.mapPoint.address;
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

#pragma mark - Methods

-(void)goBackToVC {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
