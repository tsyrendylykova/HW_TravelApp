//
//  MuseumsForDayViewController.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 02/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "MuseumsForDayViewController.h"
#import "ChooseMuseumViewController.h"
#import "AppDelegate.h"
#import "Day+CoreDataClass.h"
#import "Museum+CoreDataClass.h"
#import "DayCollectionViewCell.h"

#import "MapViewController.h"

@interface MuseumsForDayViewController () <NSFetchedResultsControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) Trip *trip;
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UILabel *labelDate;
@property (nonatomic, strong) UILabel *labelChoose;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSDate *selectedDate;
@property (nonatomic, strong) NSArray<Museum *> *arrayMuseums;

@property (nonatomic, strong) UIButton *testButton;
@property (nonatomic, strong) UIButton *showMuseumOnMapButton;

@property (nonatomic, strong) NSManagedObjectContext *coreDataContext;
@property (nonatomic, strong) NSFetchRequest *fetchRequest;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation MuseumsForDayViewController

- (void)dealloc
{
    _fetchedResultsController.delegate = nil;
}

-(instancetype)initWithTrip: (Trip *)trip {
    self = [super init];
    if (self) {
        _trip = trip;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectedDate = nil;
    
    [self prepareUI];
    [self prepareCollectionView];
    [self prepareTableView];
    
    [self prepareTestButton];
    [self prepareButtonShowMuseumOnMap];
}

-(void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(goBackToVC)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleDone target:self action:@selector(addNewMuseums)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    self.labelName = [[UILabel alloc] initWithFrame:CGRectMake(20, 110, self.view.frame.size.width - 40, 20)];
    self.labelName.text = self.trip.name;
    self.labelName.font = [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
    self.labelName.numberOfLines = 0;
    [self.labelName setTextColor:[UIColor blackColor]];
    [self.view addSubview:self.labelName];
    
    self.labelDate = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.labelName.frame) + 10, self.view.frame.size.width - 40, 60)];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *startDate = self.trip.startDate;
    NSDate *endDate = self.trip.endDate;
    [dateFormat setDateFormat:@"EEEE, MMM d, yyyy"];
    //MMM d, yyyy
    
    NSString *startDateString = [dateFormat stringFromDate:startDate];
    NSString *startEndString = [dateFormat stringFromDate:endDate];
    
    self.labelDate.text = [NSString stringWithFormat:@"%@ - %@", startDateString, startEndString];
    self.labelDate.font = [UIFont systemFontOfSize:16 weight:UIFontWeightSemibold];
    self.labelDate.numberOfLines = 0;
    [self.labelDate setTextColor:[UIColor grayColor]];
    [self.view addSubview:self.labelDate];
    
    self.labelChoose = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.labelDate.frame) + 5, self.view.frame.size.width - 40, 20)];
    self.labelChoose.text = @"Choose ";
    self.labelChoose.font = [UIFont systemFontOfSize:16 weight:UIFontWeightSemibold];
    [self.labelChoose setTextColor:[UIColor blackColor]];
    [self.view addSubview:self.labelChoose];
}

-(void)prepareTestButton {
    self.testButton = [[UIButton alloc] initWithFrame:CGRectMake(100, self.view.frame.size.height - 100, 200, 40)];
    self.testButton.backgroundColor = [UIColor orangeColor];
    [self.testButton setTitle:@"Show museums" forState:UIControlStateNormal];
    [self.testButton addTarget:self action:@selector(testFunction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.testButton];
}

-(void)prepareButtonShowMuseumOnMap {
    self.showMuseumOnMapButton = [[UIButton alloc] initWithFrame:CGRectMake(100, self.view.frame.size.height - 50, 200, 40)];
    self.showMuseumOnMapButton.backgroundColor = [UIColor orangeColor];
    [self.showMuseumOnMapButton setTitle:@"Show museums on map" forState:UIControlStateNormal];
    [self.showMuseumOnMapButton addTarget:self action:@selector(showMuseumsOnMap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.showMuseumOnMapButton];
}

-(void)prepareCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(50, 50);
    layout.minimumInteritemSpacing = 5;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(8.0, 8.0, 8.0, 8.0);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.labelChoose.frame) + 20, self.view.frame.size.width - 50, 50) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[DayCollectionViewCell class] forCellWithReuseIdentifier:@"CellDay"];
    
    [self.view addSubview:self.collectionView];
}

-(void)prepareTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.collectionView.frame) + 20, self.view.frame.size.width - 40, self.view.frame.size.height - 110 - CGRectGetMaxY(self.collectionView.frame) - 20)];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellMuseum"];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - Actions

-(void)goBackToVC {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addNewMuseums {
    ChooseMuseumViewController *newVC = [[ChooseMuseumViewController alloc] initWithTrip:self.trip];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:newVC];
    [self presentViewController:navVC animated:YES completion:nil];
}

-(void)testFunction {
    NSError *error;
    NSFetchRequest *fetch = [[NSFetchRequest alloc] initWithEntityName:@"Day"];
    NSArray *result = [self.coreDataContext executeFetchRequest: fetch error:&error];
    if (result.count > 0) {
        for (int i = 0; i < result.count; i++) {
            Day *day = [result objectAtIndex:i];
            NSLog(@"%@", day.date);
            NSSet *set = [[NSSet alloc] initWithSet:day.museums];
            NSArray<Museum *> *array = [set allObjects];
            for (int j = 0; j < array.count; j++) {
                NSLog(@"%@", array[j].name);
                NSLog(@"%@", array[j].address);
            }
        }
    }
}

-(void)showMuseumsOnMap {
    UITabBarController *tabBarController = (UITabBarController *)self.presentingViewController;
    
    //???
    TACustomAnnotation *annotation = [TACustomAnnotation new];
    MapViewController *mapVC = [[MapViewController alloc] initWithAnnotation:annotation];
    UINavigationController *searchVC = [[UINavigationController alloc] initWithRootViewController:[MapViewController new]];
//    [tabBarController.viewControllers insert]
//    searchVC.tabBarItem.title = @"Map";
//    searchVC.tabBarItem.image = [UIImage imageNamed:@"map"];
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    [tabBarController setSelectedIndex:0];
}

#pragma mark - CoreData Stack

- (NSFetchRequest *)fetchRequest
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Day"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    
    return fetchRequest;
}

- (NSManagedObjectContext *)coreDataContext
{
    if (_coreDataContext)
    {
        return _coreDataContext;
    }
    
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
                                   entityForName:NSStringFromClass([Day class]) inManagedObjectContext:self.coreDataContext];
    [fetchRequest setEntity:entity];
    [fetchRequest setSortDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES]]];
    [fetchRequest setFetchBatchSize:20];
    
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.coreDataContext sectionNameKeyPath:nil
                                                   cacheName:@"Root"];
    self.fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.trip.days.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellDay" forIndexPath:indexPath];
    if (cell) {
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MMM d"];
        NSString *date = [dateFormat stringFromDate:[self.trip.days sortedArrayUsingDescriptors:@[sortDescriptor]][indexPath.row].date];
        cell.dateLabel.text = date;
        cell.dateLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightThin];
        [cell.dateLabel setTextColor:[UIColor blackColor]];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    self.selectedDate = [self.trip.days sortedArrayUsingDescriptors:@[sortDescriptor]][indexPath.row].date;
    Day *dayInTrip = [self.trip dayForDate:self.selectedDate];
    self.arrayMuseums = [[NSArray<Museum *> alloc] initWithArray:[dayInTrip.museums allObjects]];
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayMuseums.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellMuseum"];
    if (cell) {
        if (self.selectedDate) {
            cell.textLabel.text = self.arrayMuseums[indexPath.row].name;
        }
    }
    return cell;
}


@end