//
//  TLAMapViewController.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 23/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "TLASearchViewController.h"
#import "TLACustomAnnotation.h"

NS_ASSUME_NONNULL_BEGIN

@interface TLAMapViewController : UIViewController <MKMapViewDelegate, SearchViewDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) TLACustomAnnotation *annotation;

@end

NS_ASSUME_NONNULL_END
