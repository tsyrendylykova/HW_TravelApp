//
//  CreateTripViewController.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 23/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "CreateTripViewController.h"
#import "AddTripViewController.h"
#import "AppDelegate.h"
#import "Trip+CoreDataClass.h"
#import "ChooseMuseumViewController.h"
#import "MuseumCollectionViewCell.h"

@import CoreData;

@interface CreateTripViewController () <UICollectionViewDelegate, UICollectionViewDataSource, NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIBarButtonItem *rightBarButtonItem;
@property (nonatomic, strong) NSFetchRequest *fetchRequest;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

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
    [self prepareBarButtonItems];
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
    self.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(presentNewTrip)];
    self.navigationItem.rightBarButtonItem = self.rightBarButtonItem;
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
    MuseumCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellCollectionView" forIndexPath:indexPath];
    Trip *trip = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    if (trip) {
        cell.coverImageView.image = [UIImage imageNamed:@"sun2.jpg"];
        cell.name.text = trip.name;
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        NSDate *startDate = trip.startDate;
        NSDate *endDate = trip.endDate;
        [dateFormat setDateFormat:@"EEEE, MMM d, yyyy"];
        //MMM d, yyyy
        
        NSString *startDateString = [dateFormat stringFromDate:startDate];
        NSString *startEndString = [dateFormat stringFromDate:endDate];
        
        cell.descriptionTrip.text = [NSString stringWithFormat:@"%@ - %@", startDateString, startEndString];
    } else {
        cell.coverImageView.image = [UIImage imageNamed:@"sun2.jpg"];
        cell.name.text = @"Название поездки";
        cell.descriptionTrip.text = @"29 апреля 2019";
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Trip *trip = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    ChooseMuseumViewController *chooseMuseumVC = [[ChooseMuseumViewController alloc] initWithTrip:trip];
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

- (NSFetchRequest *)fetchRequest
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Trip"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    
    return fetchRequest;
}

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
    [fetchRequest setSortDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES]]];
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
