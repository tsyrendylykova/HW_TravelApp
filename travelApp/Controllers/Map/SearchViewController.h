//
//  SearchViewController.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 24/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TANetworkServiceProtocol.h"
#import "TANetworkService.h"
#import "MapPoint.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SearchViewDelegate <NSObject>

-(void)didSelectRow:(MapPoint *) mapPoint;

@end

@interface SearchViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, NetworkServiceOutputProtocol>

@property (nonatomic, strong) TANetworkService *networkService;

@property (nonatomic, strong) NSMutableArray<MapPoint *> *dataArray;
@property (nonatomic, weak) id<SearchViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
