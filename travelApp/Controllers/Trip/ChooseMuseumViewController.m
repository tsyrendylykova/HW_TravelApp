//
//  ChooseMuseumViewController.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 02/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "ChooseMuseumViewController.h"
#import "ChooseMuseumForDayViewController.h"
#import "AppDelegate.h"
#import "Day+CoreDataClass.h"
#import "Museum+CoreDataClass.h"

@interface ChooseMuseumViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) Trip *trip;
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UILabel *labelDate;
@property (nonatomic, strong) UILabel *labelChoose;
@property (nonatomic, strong) NSMutableArray<NSDate *> *dates;

@property (nonatomic, strong) UIButton *testButton;

@property (nonatomic, strong) NSManagedObjectContext *coreDataContext;
@property (nonatomic, strong) NSFetchRequest *fetchRequest;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation ChooseMuseumViewController

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
    
    
    [self prepareUI];
    [self prepareDays];
    
    [self prepareTestButton];
    
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
    self.testButton = [[UIButton alloc] initWithFrame:CGRectMake(100, CGRectGetMaxY(self.labelChoose.frame) + 250, 200, 40)];
    self.testButton.backgroundColor = [UIColor orangeColor];
    [self.testButton setTitle:@"Show museums" forState:UIControlStateNormal];
    [self.testButton addTarget:self action:@selector(testFunction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.testButton];
}

-(void)prepareDays {
    CGFloat x = 20;

    for (Day *day in self.trip.days) {
        UIView *dateView = [[UILabel alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(self.labelChoose.frame) + 10, 50, 50)];
        dateView.layer.cornerRadius = 25;
        dateView.layer.masksToBounds = YES;
        dateView.layer.borderWidth = 2;
        dateView.layer.borderColor = [UIColor blackColor].CGColor;
        
        UILabel *newDate = [[UILabel alloc] initWithFrame:CGRectMake(x + 10, CGRectGetMaxY(self.labelChoose.frame) + 10, 50, 50)];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MMM d"];
        NSString *date = [dateFormat stringFromDate:day.date];
        newDate.text = date;
        newDate.font = [UIFont systemFontOfSize:10 weight:UIFontWeightThin];
        [newDate setTextColor:[UIColor blackColor]];
        x += 70;
        [self.view addSubview:dateView];
        [self.view addSubview:newDate];
    }
}



#pragma mark - Actions

-(void)goBackToVC {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addNewMuseums {
    ChooseMuseumForDayViewController *newVC = [[ChooseMuseumForDayViewController alloc] initWithTrip:self.trip];
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
            NSSet *set = [[NSSet alloc] initWithSet:day.museums];
            NSArray<Museum *> *array = [set allObjects];
            for (int j = 0; j < array.count; j++) {
                NSLog(@"%@", array[j].name);
                NSLog(@"%@", array[j].address);
            }
        }
    }
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



@end
