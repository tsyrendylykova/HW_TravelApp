//
//  MapViewController.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 23/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "TANetworkHelper.h"
#import "SearchViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MapViewController : UIViewController <MKMapViewDelegate, SearchViewDelegate, UISearchResultsUpdating>

@end

NS_ASSUME_NONNULL_END
