//
//  SearchViewController.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 24/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()



@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.networkService = [TAFoursquareNetworkService new];
    self.networkService.output = self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    MapPoint *point = [MapPoint new];
    if (self.dataArray.count > 0) {
        point.name = self.dataArray[indexPath.row].name;
        point.urlImage = self.dataArray[indexPath.row].urlImage;
     
        cell.textLabel.text = point.name;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MapPoint *mapPoint = [[MapPoint alloc] initWithName:self.dataArray[indexPath.row].name urlImage:self.dataArray[indexPath.row].urlImage address:self.dataArray[indexPath.row].address];
    
    [self.networkService getImageNSDataFromURL: mapPoint.urlImage withCompletionHandler:^(NSData *data) {
        NSLog(@"%@", mapPoint.urlImage);
        mapPoint.categoryImage = [UIImage imageWithData:data];
    }];
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectRow:)]) {
        [_delegate didSelectRow:mapPoint];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - FoursquareNetworkServiceOutputProtocol

-(void)loadingIsDoneWithDataRecieved:(NSDictionary *)dataRecieved {
    [self.dataArray removeAllObjects];
    
    NSArray *array = [[dataRecieved objectForKey:@"response"] objectForKey:@"venues"];
    NSMutableArray<MapPoint *> *tempArray = [NSMutableArray<MapPoint *> new];
    for (int i = 0; i < array.count; i++) {
        NSString *imageURL = [NSString stringWithFormat:@"%@88%@", array[i][@"categories"][0][@"icon"][@"prefix"], array[i][@"categories"][0][@"icon"][@"suffix"]];
        MapPoint *obj = [[MapPoint alloc] initWithName:array[i][@"name"] urlImage:imageURL address:[NSString stringWithFormat:@"%@, %@", array[i][@"location"][@"city"], array[i][@"location"][@"address"]]];
        [tempArray addObject:obj];
    }
    self.dataArray = tempArray;
    
    [self.tableView reloadData];
}

@end
