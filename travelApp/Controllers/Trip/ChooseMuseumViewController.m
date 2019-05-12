//
//  ChooseMuseumViewController.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 03/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "ChooseMuseumViewController.h"
#import "DetailMuseumCollectionViewCell.h"
#import "AddMuseumViewController.h"

@interface ChooseMuseumViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray<NSDate *> *dates; // надо удалить
@property (nonatomic, strong) Trip *trip;
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableDictionary *dictInfo;

@end

@implementation ChooseMuseumViewController

-(instancetype)initWithTrip: (Trip *)trip {
    self = [super init];
    if (self) {
        _trip = trip;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
    
    self.networkService = [TAMosDataNetworkService new];
    self.networkService.output = self;
    
    [self.networkService findMosDataMuseums];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame) / 3 - 2.5, CGRectGetWidth(self.view.frame) / 3 - 2.5);
    layout.minimumInteritemSpacing = 0;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.labelName.frame) + 10, self.view.frame.size.width, self.view.frame.size.height - CGRectGetMaxY(self.labelName.frame) - 10) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[DetailMuseumCollectionViewCell class] forCellWithReuseIdentifier:@"CellCollectionView"];
    
    [self.view addSubview:self.collectionView];
}

-(void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(goBackToVC)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    self.labelName = [[UILabel alloc] initWithFrame:CGRectMake(20, 120, 200, 20)];
    self.labelName.text = @"Museums near Moscow";
    self.labelName.font = [UIFont systemFontOfSize:18 weight:UIFontWeightSemibold];
    [self.labelName setTextColor:[UIColor blackColor]];
    [self.view addSubview:self.labelName];
}

#pragma mark - Actions

-(void)goBackToVC {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 54;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailMuseumCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellCollectionView" forIndexPath:indexPath];
    
    cell.coverImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg", (long)indexPath.row + 1]];
//    cell.coverImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"name.jpg"]];
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    AddMuseumViewController *addMuseumVC = [[AddMuseumViewController alloc] initWithTrip:self.trip rowNumber:indexPath.row info:self.dictInfo[[NSString stringWithFormat:@"%ld", (long)indexPath.row + 1]]];
    [self.navigationController pushViewController:addMuseumVC animated:YES];
}

#pragma mark - MosDataNetworkServiceOutputProtocol

-(void)loadingIsDoneWithDataRecieved:(NSDictionary *)dataRecieved {
    self.dictInfo = [NSMutableDictionary new];
    for (id elem in dataRecieved) {
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:elem[@"Cells"][@"CommonName"] forKey:@"CommonName"];
        [dict setObject:elem[@"Cells"][@"ObjectAddress"][0][@"Address"] forKey:@"Address"];
        
        NSMutableDictionary *dictHours = [NSMutableDictionary new];
        
        for (int i = 0; i < 7; i++) {
            [dictHours setObject:elem[@"Cells"][@"WorkingHours"][i][@"WorkHours"] forKey:elem[@"Cells"][@"WorkingHours"][i][@"DayWeek"]];
        }
        [dict setObject:dictHours forKey:@"WorkHours"];
        [self.dictInfo setObject:dict forKey:[NSString stringWithFormat:@"%@", elem[@"Number"]]];
    }
}

@end
