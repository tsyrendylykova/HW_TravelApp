//
//  TripsViewController.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 23/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "TripsViewController.h"
#import "AddTripViewController.h"
#import "AppDelegate.h"
#import "Trip+CoreDataClass.h"
#import "MuseumsForDayViewController.h"
#import "MuseumCollectionViewCell.h"
#import "Constants.h"

@import CoreData;

@interface TripsViewController () <UICollectionViewDelegate, UICollectionViewDataSource, NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation TripsViewController

- (void)dealloc
{
    _fetchedResultsController.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame) - TripLayoutWidth, CGRectGetWidth(self.view.frame)/2 - TripLayoutHeight);
    layout.minimumInteritemSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, TopOffset, self.view.frame.size.width, self.view.frame.size.height - TopOffset) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[MuseumCollectionViewCell class] forCellWithReuseIdentifier:TripsViewControllerCellIdentifier];
    [self.view addSubview:self.collectionView];

    [self prepareUI];
    [self prepareBarButtonItems];
    [self prepareDateFormatter];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSError *error;
    [self.fetchedResultsController performFetch:&error];
    if (error) {
        NSLog(@"Error");
    }
    
    [self.collectionView reloadData];
}

-(void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"Your museum`s trips";
}

-(void)prepareBarButtonItems {
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(presentNewTrip)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

-(void)prepareDateFormatter {
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"EEEE, MMM d, yyyy"];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.fetchedResultsController.fetchedObjects.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MuseumCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TripsViewControllerCellIdentifier forIndexPath:indexPath];
    Trip *trip = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    if (trip) {
        cell.coverImageView.image = [UIImage imageNamed:@"sun2"];
        cell.name.text = trip.name;
        cell.descriptionTrip.text = [NSString stringWithFormat:@"%@ - %@", [self.dateFormatter stringFromDate:trip.startDate], [self.dateFormatter stringFromDate:trip.endDate]];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Trip *trip = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    MuseumsForDayViewController *chooseMuseumVC = [[MuseumsForDayViewController alloc] initWithTrip:trip];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:chooseMuseumVC];
    [self presentViewController:navVC animated:YES completion:nil];
}

#pragma mark - Actions

-(void)presentNewTrip {
    AddTripViewController *addTripVC = [AddTripViewController new];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:addTripVC];
    [self presentViewController:navVC animated:YES completion:nil];
}

#pragma mark - CoreData Stack

- (NSManagedObjectContext *)coreDataContext
{
    UIApplication *application = [UIApplication sharedApplication];
    NSPersistentContainer *container = ((AppDelegate *)(application.delegate)).
    persistentContainer;
    NSManagedObjectContext *context = container.viewContext;
    
    return context;
}


- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController)
    {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:NSStringFromClass([Trip class]) inManagedObjectContext:self.coreDataContext];
    [fetchRequest setEntity:entity];
    [fetchRequest setSortDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"startDate" ascending:YES]]];
    [fetchRequest setFetchBatchSize:20];
    
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.coreDataContext sectionNameKeyPath:nil
                                                   cacheName:nil];
    
    _fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
    
}

@end
