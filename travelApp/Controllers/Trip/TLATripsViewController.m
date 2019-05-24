//
//  TTLATripsViewController.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 23/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//


#import "TLATripsViewController.h"
#import "Trip+CoreDataClass.h"
#import "TLAMuseumCollectionViewCell.h"
#import "TLAAddTripViewController.h"
#import "TLAMuseumsForDayViewController.h"
#import "TLAConstants.h"


@import CoreData;

@interface TLATripsViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation TLATripsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame) - TLATripLayoutWidth, CGRectGetWidth(self.view.frame)/2 - TLATripLayoutHeight);
    layout.minimumInteritemSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, TLATopOffset, self.view.frame.size.width, self.view.frame.size.height - TLATopOffset) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[TLAMuseumCollectionViewCell class] forCellWithReuseIdentifier:TLATripsViewControllerCellIdentifier];
    [self.view addSubview:self.collectionView];

    [self prepareUI];
    [self prepareBarButtonItems];
    [self prepareDateFormatter];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSError *error;
    [self.tripsService.fetchedResultsController performFetch:&error];
    if (error)
    {
        NSLog(@"Error");
    }
    
    [self.collectionView reloadData];
}

- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"Your museum`s trips";
}

- (void)prepareBarButtonItems {
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(presentNewTrip)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)prepareDateFormatter {
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"EEEE, MMM d, yyyy"];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.tripsService.fetchedResultsController.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.tripsService.fetchedResultsController.fetchedObjects.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TLAMuseumCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TLATripsViewControllerCellIdentifier forIndexPath:indexPath];
    Trip *trip = [self.tripsService.fetchedResultsController objectAtIndexPath:indexPath];
    
    if (trip)
    {
        cell.coverImageView.image = [UIImage imageNamed:@"sun2"];
        cell.name.text = trip.name;
        cell.descriptionTrip.text = [NSString stringWithFormat:@"%@ - %@", [self.dateFormatter stringFromDate:trip.startDate], [self.dateFormatter stringFromDate:trip.endDate]];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Trip *trip = [self.tripsService.fetchedResultsController objectAtIndexPath:indexPath];
    TLAMuseumsForDayService *service = [[TLAMuseumsForDayService alloc] initWithCoreDataProvider:self.tripsService.coreDataProvider];
    TLAMuseumsForDayViewController *VC = [[TLAMuseumsForDayViewController alloc] initWithCoreDataService:service trip:trip];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:VC];
    [self presentViewController:navVC animated:YES completion:nil];
}


#pragma mark - Actions

- (void)presentNewTrip {
    TLAAddTripService *service = [[TLAAddTripService alloc] initWithCoreDataProvider:self.tripsService.coreDataProvider];
    TLAAddTripViewController *VC = [[TLAAddTripViewController alloc] initWithAddTripService:service];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:VC];
    [self presentViewController:navVC animated:YES completion:nil];

}

@end
