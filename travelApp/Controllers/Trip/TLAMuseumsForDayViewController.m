//
//  TLAMuseumsForDayViewController.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 02/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//


#import "TLAMuseumsForDayViewController.h"
#import "TLAChooseMuseumViewController.h"
#import "Museum+CoreDataClass.h"
#import "TLADayCollectionViewCell.h"
#import "TLACoordinator.h"
#import "TLAConstants.h"
#import "TLAMuseumsForDayView.h"
#import "Day+CoreDataClass.h"
#import "TLAAddMuseumService.h"


@interface TLAMuseumsForDayViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) Trip *trip;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic, strong) NSDateFormatter *dateFormatterFull;
@property (nonatomic, strong) NSDateFormatter *dateFormatterShort;
@property (nonatomic, copy) NSArray<Museum *> *arrayMuseums;
@property (nonatomic, copy) NSArray<Day *> *sortedDaysArray;
@property (nonatomic, strong) TLAMuseumsForDayView *museumsForDay;
@property (nonatomic, strong) TLAMuseumsForDayService *museumsForDayService;

@end

@implementation TLAMuseumsForDayViewController

- (instancetype)initWithCoreDataService:(TLAMuseumsForDayService *)service trip:(Trip *)trip
{
    self = [super init];
    if (self)
    {
        _museumsForDayService = service;
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
    self.museumsForDay = [[TLAMuseumsForDayView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 0.25) trip:self.trip];
    [self.view addSubview:self.museumsForDay];
    [self prepareUI];
    [self prepareCollectionView];
    [self prepareTableView];
    self.tableView.alpha = 0;
}

- (void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(goBackToVC)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleDone target:self action:@selector(addNewMuseums)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
}

- (void)prepareCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(TLAMuseumLayoutSize, TLAMuseumLayoutSize);
    layout.minimumInteritemSpacing = TLAMuseumCollectionViewLayout;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(TLAMuseumEdgeInsets, TLAMuseumEdgeInsets, TLAMuseumEdgeInsets, TLAMuseumEdgeInsets);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(TLAMuseumCollectionViewTopOffset, CGRectGetMaxY(self.museumsForDay.frame) + TLAMuseumLabelLeftOffset, self.view.frame.size.width - TLAMuseumCollectionViewWidth, TLAMuseumCollectionViewHeight) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[TLADayCollectionViewCell class] forCellWithReuseIdentifier:TLAMuseumsViewControllerCollectionCellIdentifier];
    
    [self.view addSubview:self.collectionView];
}

- (void)prepareTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(TLAMuseumLabelLeftOffset, CGRectGetMaxY(self.collectionView.frame) + TLAMuseumLabelLeftOffset, self.view.frame.size.width - TLAMuseumTableViewWidth, self.view.frame.size.height - TLAMuseumTableViewHeight - CGRectGetMaxY(self.collectionView.frame))];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TLAMuseumsViewControllerTableCellIdentifier];
    
    [self.view addSubview:self.tableView];
}

- (void)prepareDateFormatter {
    self.dateFormatterFull = [[NSDateFormatter alloc] init];
    [self.dateFormatterFull setDateFormat:@"EEEE, MMM d, yyyy"];

    self.dateFormatterShort = [[NSDateFormatter alloc] init];
    [self.dateFormatterShort setDateFormat:@"MMM d"];
}


#pragma mark - Actions

- (void)goBackToVC {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addNewMuseums {
    TLAAddMuseumService *service = [[TLAAddMuseumService alloc] initWithCoreDataProvider:self.museumsForDayService.coreDataProvider];
    TLAChooseMuseumViewController *VC = [[TLAChooseMuseumViewController alloc] initWithService:service trip:self.trip networkService:[TLAMosDataNetworkService new]];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:VC];
    [self presentViewController:navVC animated:YES completion:nil];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sortedDaysArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TLADayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TLAMuseumsViewControllerCollectionCellIdentifier forIndexPath:indexPath];
    if (cell)
    {
        cell.dateLabel.text = [self.dateFormatterShort stringFromDate:self.sortedDaysArray[indexPath.row].date];
        cell.dateLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightThin];
        
        if ([self.selectedDate isEqualToDate:self.sortedDaysArray[indexPath.row].date])
        {
            [cell selectedCell:YES];
        }
        else
        {
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TLAMuseumsViewControllerTableCellIdentifier];
    if (cell)
    {
        if (self.selectedDate)
        {
            cell.textLabel.text = self.arrayMuseums[indexPath.row].name;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(self.arrayMuseums[indexPath.row].latitude, self.arrayMuseums[indexPath.row].longitude);
    TLACustomAnnotation *annotation = [[TLACustomAnnotation alloc] initWithTitle:self.arrayMuseums[indexPath.row].name subtitle:self.arrayMuseums[indexPath.row].address location:coord];
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    [[TLACoordinator sharedCoordinator] showMuseumOnMapWithAnnotation:annotation];
}


@end
