//
//  CreateTripViewController.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 23/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "CreateTripViewController.h"
#import "MuseumCollectionViewCell.h"

@interface CreateTripViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation CreateTripViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame) - 2.5, CGRectGetWidth(self.view.frame)/2 - 2.5);
    layout.minimumInteritemSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 89, self.view.frame.size.width, self.view.frame.size.height - 89) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[MuseumCollectionViewCell class] forCellWithReuseIdentifier:@"CellCollectionView"];
    [self.view addSubview:self.collectionView];

    [self prepareUI];
}

-(void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"Museums";
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MuseumCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellCollectionView" forIndexPath:indexPath];
    
    cell.coverImageView.image = [UIImage imageNamed:@"1.jpg"];
    
    return cell;
}

@end
