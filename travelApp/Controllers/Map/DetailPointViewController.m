//
//  DetailPointViewController.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 25/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "DetailPointViewController.h"

@interface DetailPointViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) MapPoint *mapPoint;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UITableView *buttonTableView;


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
    [self.buttonTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellButton"];
    self.buttonTableView.delegate = self;
    self.buttonTableView.dataSource = self;
}

-(void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = self.mapPoint.name;
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 89, self.view.frame.size.width, self.view.frame.size.height * 0.35)];
    self.imageView.image = [UIImage imageNamed:@"1.jpg"];
    [self.view addSubview:self.imageView];
    
    self.buttonTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imageView.frame), self.view.frame.size.width, 88)];
    [self.view addSubview:self.buttonTableView];
    
}



- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellButton" forIndexPath:indexPath];
    cell.textLabel.text = @"qwerty";
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

@end
