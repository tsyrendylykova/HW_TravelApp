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
    self.networkService = [TANetworkService new];
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
    point.name = self.dataArray[indexPath.row];
 
    cell.textLabel.text = point.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MapPoint *mapPoint = [[MapPoint alloc] initWithName:self.dataArray[indexPath.row]];
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectRow:)]) {
        [_delegate didSelectRow:mapPoint];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - NetworkServiceOutputProtocol

-(void)loadingIsDoneWithDataRecieved:(NSDictionary *)dataRecieved {
    [self.dataArray removeAllObjects];
    
    NSArray *array = [[dataRecieved objectForKey:@"response"] objectForKey:@"venues"];
    NSMutableArray *tempArray = [NSMutableArray new];
    for (int i = 0; i < array.count; i++) {
        [tempArray addObject:array[i][@"name"]];
    }
    self.dataArray = tempArray;
    [self.tableView reloadData];
}

@end
