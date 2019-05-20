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
#import "TACoordinator.h"
#import "Constants.h"
#import "MuseumsForDayView.h"

@interface MuseumsForDayViewController () <NSFetchedResultsControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) Trip *trip;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic, strong) NSDateFormatter *dateFormatterFull;
@property (nonatomic, strong) NSDateFormatter *dateFormatterShort;
@property (nonatomic, strong) NSManagedObjectContext *coreDataContext;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSArray<Museum *> *arrayMuseums;
@property (nonatomic, strong) NSArray<Day *> *sortedDaysArray;
@property (nonatomic, strong) MuseumsForDayView *museumsForDay;
//@property (nonatomic, strong) UILabel *labelShow;

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
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    self.sortedDaysArray = [NSArray<Day *> arrayWithArray:[self.trip.days sortedArrayUsingDescriptors:@[sortDescriptor]]];
    self.selectedDate = nil;
    
    [self prepareDateFormatter];
    self.museumsForDay = [[MuseumsForDayView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 0.25) trip:self.trip];
    [self.view addSubview:self.museumsForDay];
    [self prepareUI];
    [self prepareCollectionView];
    [self prepareTableView];
    self.tableView.alpha = 0;
}

-(void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(goBackToVC)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleDone target:self action:@selector(addNewMuseums)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
}

-(void)prepareCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(MuseumLayoutSize, MuseumLayoutSize);
    layout.minimumInteritemSpacing = MuseumCollectionViewLayout;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(MuseumEdgeInsets, MuseumEdgeInsets, MuseumEdgeInsets, MuseumEdgeInsets);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(MuseumCollectionViewTopOffset, CGRectGetMaxY(self.museumsForDay.frame) + MuseumLabelLeftOffset, self.view.frame.size.width - MuseumCollectionViewWidth, MuseumCollectionViewHeight) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[DayCollectionViewCell class] forCellWithReuseIdentifier:MuseumsViewControllerCollectionCellIdentifier];
    
    [self.view addSubview:self.collectionView];
}

-(void)prepareTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(MuseumLabelLeftOffset, CGRectGetMaxY(self.collectionView.frame) + MuseumLabelLeftOffset, self.view.frame.size.width - MuseumTableViewWidth, self.view.frame.size.height - MuseumTableViewHeight - CGRectGetMaxY(self.collectionView.frame))];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:MuseumsViewControllerTableCellIdentifier];
    
    [self.view addSubview:self.tableView];
}

-(void)prepareDateFormatter {
    self.dateFormatterFull = [[NSDateFormatter alloc] init];
    [self.dateFormatterFull setDateFormat:@"EEEE, MMM d, yyyy"];

    self.dateFormatterShort = [[NSDateFormatter alloc] init];
    [self.dateFormatterShort setDateFormat:@"MMM d"];
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

#pragma mark - CoreData Stack

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
                                                   cacheName:nil];
    self.fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sortedDaysArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MuseumsViewControllerCollectionCellIdentifier forIndexPath:indexPath];
    if (cell) {
        cell.dateLabel.text = [self.dateFormatterShort stringFromDate:self.sortedDaysArray[indexPath.row].date];
        cell.dateLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightThin];
        
        if ([self.selectedDate isEqualToDate:self.sortedDaysArray[indexPath.row].date]) {
            [cell selectedCell:YES];
        } else {
            [cell selectedCell:NO];
        }
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedDate = self.sortedDaysArray[indexPath.row].date;
    Day *dayInTrip = [self.trip dayForDate:self.selectedDate];
    self.arrayMuseums = [[NSArray<Museum *> alloc] initWithArray:[dayInTrip.museums allObjects]];
    
    [self.tableView reloadData];
    [self.collectionView reloadData];
    
    [UIView animateWithDuration:1 animations:^{
        self.museumsForDay.labelShow.alpha = 0;
    } completion:^(BOOL finished) {
        self.tableView.alpha = 1;
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayMuseums.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MuseumsViewControllerTableCellIdentifier];
    if (cell) {
        if (self.selectedDate) {
            cell.textLabel.text = self.arrayMuseums[indexPath.row].name;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(self.arrayMuseums[indexPath.row].latitude, self.arrayMuseums[indexPath.row].longitude);
    TACustomAnnotation *annotation = [[TACustomAnnotation alloc] initWithTitle:self.arrayMuseums[indexPath.row].name subtitle:self.arrayMuseums[indexPath.row].address location:coord];
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    [[TACoordinator sharedRouter] showMuseumOnMapWithAnnotation:annotation];
}


@end
