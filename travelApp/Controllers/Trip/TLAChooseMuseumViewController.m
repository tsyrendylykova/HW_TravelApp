//
//  TLAChooseMuseumViewController.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 03/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//


#import "TLAChooseMuseumViewController.h"
#import "TLADetailMuseumCollectionViewCell.h"
#import "TLAConstants.h"
#import "TLAAddMuseumViewController.h"


@interface TLAChooseMuseumViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableDictionary *dictInfo;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@property (nonatomic, strong) TLAAddMuseumService *addMuseumService;
@property (nonatomic, strong) Trip *trip;
@property (nonatomic, strong) TLAMosDataNetworkService *networkService;

@end


@implementation TLAChooseMuseumViewController

- (instancetype)initWithService:(TLAAddMuseumService *)service trip:(Trip *)trip networkService:(TLAMosDataNetworkService *)networkService;
{
    self = [super init];
    if (self)
    {
        _addMuseumService = service;
        _trip = trip;
        _networkService = networkService;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self prepareUI];
    [self prepareCollectionView];
    
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    self.activityView.center = self.view.center;
    self.activityView.color = [UIColor blackColor];
    [self.activityView startAnimating];
    [self.view addSubview:self.activityView];
    
    self.dictInfo = [NSMutableDictionary new];
    
    self.networkService = [TLAMosDataNetworkService new];
    self.networkService.output = self;
    
    [self.networkService findMosDataMuseums];
}

- (void)prepareCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame) / 3 - TLAChooseMuseumLayout, CGRectGetWidth(self.view.frame) / 3 - TLAChooseMuseumLayout);
    layout.minimumInteritemSpacing = 0;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.labelName.frame) + TLAChooseMuseumCollectionView, self.view.frame.size.width, self.view.frame.size.height - CGRectGetMaxY(self.labelName.frame) - TLAChooseMuseumCollectionView) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[TLADetailMuseumCollectionViewCell class] forCellWithReuseIdentifier:TLAChooseMuseumViewControllerCollectionCellIdentifier];
    
    [self.view addSubview:self.collectionView];
}

- (void)prepareUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(goBackToVC)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    self.labelName = [[UILabel alloc] initWithFrame:CGRectMake(TLAChooseMuseumLeftOffset, TLAChooseMuseumTopOffset, TLAChooseMuseumWidth, TLAChooseMuseumHeight)];
    self.labelName.text = @"Museums near Moscow";
    self.labelName.font = [UIFont systemFontOfSize:TLAChooseMuseumFont weight:UIFontWeightSemibold];
    [self.labelName setTextColor:[UIColor blackColor]];
    [self.view addSubview:self.labelName];
    
}


#pragma mark - Actions

- (void)goBackToVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dictInfo.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TLADetailMuseumCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TLAChooseMuseumViewControllerCollectionCellIdentifier forIndexPath:indexPath];
    NSString *photoNameString = self.dictInfo[[NSString stringWithFormat:@"%ld", (long)indexPath.row + 1]][@"PhotoName"];
    cell.coverImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", photoNameString]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TLAAddMuseumViewController *VC = [[TLAAddMuseumViewController alloc] initWithTrip:self.trip rowNumber:indexPath.row info:self.dictInfo[[NSString stringWithFormat:@"%ld", (long)indexPath.row + 1]] addMuseumService:self.addMuseumService];
    [self.navigationController pushViewController:VC animated:YES];
}


#pragma mark - MosDataNetworkServiceOutputProtocol

- (void)loadingIsDoneWithDataRecieved:(NSDictionary *)dataRecieved
{
    NSNumber *photoName = @1;
    for (id elem in dataRecieved) {
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:elem[@"Cells"][@"CommonName"] forKey:@"CommonName"];
        [dict setObject:elem[@"Cells"][@"ObjectAddress"][0][@"Address"] forKey:@"Address"];
        
        NSMutableDictionary *dictHours = [NSMutableDictionary new];
        
        for (int i = 0; i < 7; i++) {
            [dictHours setObject:elem[@"Cells"][@"WorkingHours"][i][@"WorkHours"] forKey:elem[@"Cells"][@"WorkingHours"][i][@"DayWeek"]];
        }
        [dict setObject:dictHours forKey:@"WorkHours"];
        [dict setObject:photoName forKey:@"PhotoName"];
        photoName = @([photoName intValue] + 1.0);
        [dict setObject:elem[@"Cells"][@"geoData"][@"coordinates"][0] forKey:@"Coordinates"];
        
        [self.dictInfo setObject:dict forKey:[NSString stringWithFormat:@"%@", elem[@"Number"]]];
    }
    [self.activityView stopAnimating];
    [self.collectionView reloadData];
}

@end
