//
//  DetailPointViewController.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 25/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "DetailPointViewController.h"

@interface DetailPointViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MapPoint *mapPoint;
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
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(goBackToVC)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    self.navigationItem.title = self.mapPoint.name;
    self.title = self.mapPoint.name;
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 89, self.view.frame.size.width, self.view.frame.size.height * 0.25)];
    self.imageView.image = self.mapPoint.categoryImage;
    [self.imageView.layer setCornerRadius:5];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.imageView setClipsToBounds:YES];
    [self.imageView setBackgroundColor:[UIColor colorWithRed:192/255.0 green:192/255.0 blue:192/255.0 alpha:1]];
    [self.view addSubview:self.imageView];
    
    self.buttonTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imageView.frame) + 20, self.view.frame.size.width, 220)];
    [self.view addSubview:self.buttonTableView];
    
}



- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellButton" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"The Pushkin State Museum of Fine Arts";
    }
    else if (indexPath.row == 1) {
        cell.textLabel.text = @"Ulitsa Volkhonka, 12, Moskva, 119019";
    }
    else if (indexPath.row == 2) {
        cell.textLabel.text = @"Art Museum";
    }
    else if (indexPath.row == 3) {
        cell.textLabel.text = @"arts-museum.ru";
    }
    else if (indexPath.row == 4) {
        cell.textLabel.text = @"8 (495) 697-95-78";
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

#pragma mark - Methods

-(void)goBackToVC {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
