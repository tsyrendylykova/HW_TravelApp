//
//  SearchViewController.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 24/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "TLAFoursquareNetworkService.h"
#import "TLAFoursquareNetworkServiceProtocol.h"
#import "TLAMapPoint.h"


NS_ASSUME_NONNULL_BEGIN


@protocol SearchViewDelegate <NSObject>

- (void)didSelectRow:(TLAMapPoint *)mapPoint;

@end


@interface TLASearchViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, TLAFoursquareNetworkServiceOutputProtocol>

@property (nonatomic, strong) TLAFoursquareNetworkService *networkService; /**< Сервис для получения данных о музеях */
@property (nonatomic, nullable, weak) id<SearchViewDelegate> delegate; /**< Делегат внешних событий */

@end

NS_ASSUME_NONNULL_END
