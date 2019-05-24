//
//  TLASearchViewController.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 24/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//


#import "TLASearchViewController.h"
#import "TLAConstants.h"


@interface TLASearchViewController ()

@property (nonatomic, strong) NSMutableArray<TLAMapPoint *> *dataArray;

@end


@implementation TLASearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TLASearchViewControllerCellIdentifier];
    self.networkService = [TLAFoursquareNetworkService new];
    self.networkService.output = self;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TLASearchViewControllerCellIdentifier forIndexPath:indexPath];
    
    TLAMapPoint *point = [TLAMapPoint new];
    if (self.dataArray.count > 0)
    {
        point.name = self.dataArray[indexPath.row].name;
        point.urlImage = self.dataArray[indexPath.row].urlImage;
     
        cell.textLabel.text = point.name;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLAMapPoint *mapPoint = [[TLAMapPoint alloc] initWithName:self.dataArray[indexPath.row].name urlImage:self.dataArray[indexPath.row].urlImage address:self.dataArray[indexPath.row].address];
    
    [self.networkService getImageNSDataFromURL: mapPoint.urlImage withCompletionHandler:^(NSData *data) {
        mapPoint.categoryImage = [UIImage imageWithData:data];
    }];
    if (_delegate)
    {
        [_delegate didSelectRow:mapPoint];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma mark - FoursquareNetworkServiceOutputProtocol

- (void)loadingIsDoneWithDataRecieved:(NSDictionary *)dataRecieved
{
    [self.dataArray removeAllObjects];
    
    NSArray *array = [[dataRecieved objectForKey:@"response"] objectForKey:@"venues"];
    NSMutableArray<TLAMapPoint *> *tempArray = [NSMutableArray<TLAMapPoint *> new];
    for (int i = 0; i < array.count; i++) {
        NSString *imageURL = [NSString stringWithFormat:@"%@88%@", array[i][@"categories"][0][@"icon"][@"prefix"], array[i][@"categories"][0][@"icon"][@"suffix"]];
        TLAMapPoint *obj = [[TLAMapPoint alloc] initWithName:array[i][@"name"] urlImage:imageURL address:[NSString stringWithFormat:@"%@, %@", array[i][@"location"][@"city"], array[i][@"location"][@"address"]]];
        [tempArray addObject:obj];
    }
    self.dataArray = tempArray;
    
    [self.tableView reloadData];
}

@end
