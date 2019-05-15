//
//  MapViewController.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 23/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "MapViewController.h"
#import "SearchViewController.h"
#import "TAFoursquareNetworkService.h"
#import "DetailPointViewController.h"
#import "MapPoint.h"

@interface MapViewController ()

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, assign) Boolean firstTime;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) UIBarButtonItem *leftBarButtonItem;
@property (nonatomic, strong) SearchViewController *searchVC;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSMutableArray<MapPoint *> *array;

@end

@implementation MapViewController

//надо удалить?
-(instancetype)initWithAnnotation: (TACustomAnnotation *)annotation {
    self = [super init];
    if (self) {
        _annotation = annotation;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [self.mapView addAnnotation:self.annotation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
    [self initLocationManager];

    self.mapView.delegate = self;
    [self.mapView setShowsUserLocation:YES];
    
    self.firstTime = YES;
}

-(void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"Sightseeing";
    
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 89, self.view.frame.size.width, self.view.frame.size.height - 89)];
    [self.view addSubview:self.mapView];
    
    self.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"magnifier.png"] style:UIBarButtonItemStyleDone target:self action:@selector(didTapSearchButton)];
    self.navigationItem.leftBarButtonItem = self.leftBarButtonItem;
}

-(void)initLocationManager {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
//    CLLocationCoordinate2D location = self.mapView.userLocation.location.coordinate;
    CLLocationCoordinate2D location;
    location.latitude = 55.7558;
    location.longitude = 37.6173;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location, 2500.0, 2500.0);

    [self.mapView setRegion:region animated:YES];
    [self updateNearbyCFsAtCoordinate:userLocation.coordinate];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[TACustomAnnotation class]]) {
        TACustomAnnotation *customAnnotation = (TACustomAnnotation *)annotation;
        
        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"myCustomAnnotation"];
        
        if (annotationView == nil) {
            annotationView = customAnnotation.annotationView;
        } else {
            annotationView.annotation = annotation;
        }
        return annotationView;
    } else {
        return nil;
    }
}

#pragma mark - MapView update

-(void)updateNearbyCFsAtCoordinate: (CLLocationCoordinate2D)locationCoordinate {
//    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(55.7514, 37.6285);
//    self.annotation = [[TACustomAnnotation alloc] initWithTitle:@"Zaryadye Park" location:coord];
    
    [self.mapView addAnnotation:self.annotation];
}

#pragma mark - Actions

-(void)didTapSearchButton {
    self.searchVC = [[SearchViewController alloc] init];
    self.searchVC.delegate = self;
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchVC];
    self.searchController.searchResultsUpdater = self;
    [self.navigationController presentViewController:self.searchController animated:YES completion:nil];
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = searchController.searchBar.text;
    
    if (searchController.searchResultsController) {
        SearchViewController *searchVC = (SearchViewController *)searchController.searchResultsController;
        [searchVC.networkService findFoursquarePlacesWithSearchString:searchText latitude:[NSString stringWithFormat:@"55.7558"] longitude:[NSString stringWithFormat:@"37.6173"]];
        
        searchVC.dataArray = self.array;
        [searchVC.tableView reloadData];
    }
}

#pragma mark - SearchViewDelegate

-(void)didSelectRow:(MapPoint *)mapPoint {
    self.searchController.active = NO;
    DetailPointViewController *detailPointVC = [[DetailPointViewController alloc] initWithMapPoint:mapPoint];
    [detailPointVC.view layoutIfNeeded]; // avoid warning
    [self.navigationController pushViewController:detailPointVC animated:YES];
}


@end
