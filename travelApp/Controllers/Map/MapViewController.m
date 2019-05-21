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
#import "Constants.h"

@interface MapViewController () <UISearchBarDelegate>

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) UIBarButtonItem *leftBarButtonItem;
@property (nonatomic, strong) SearchViewController *searchVC;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) UINavigationBar *navBar;

@end

@implementation MapViewController

-(void)viewWillAppear:(BOOL)animated {
    [self prepareAnnotations];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
    [self initLocationManager];
    [self prepareNavBar];

    self.mapView.delegate = self;
    [self.mapView setShowsUserLocation:YES];
    
}

-(void)prepareUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, TopOffset, self.view.frame.size.width, self.view.frame.size.height - TopOffset)];
    [self.view addSubview:self.mapView];
}

-(void)prepareNavBar {
    self.navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, NavBarLeftOffset, self.view.frame.size.width, NavBarLeftOffset)];
    self.navBar.backgroundColor = [UIColor whiteColor];
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"Sightseeing"];
    item.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"magnifier"] style:UIBarButtonItemStyleDone target:self action:@selector(didTapSearchButton)];
    self.navBar.items = @[item];
    [self.view addSubview:self.navBar];
}

-(void)initLocationManager {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}

-(void)prepareAnnotations {
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView addAnnotation:self.annotation];
    if (self.annotation.title) {
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.annotation.coordinate, LatitudinalMeters, LongitudinalMeters);
        [self.mapView setRegion:region animated:YES];
    }
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {    
    //show moscow for simulator usage
    CLLocationCoordinate2D location;
    location.latitude = MoscowLatitude;
    location.longitude = MoscowLongitude;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location, LatitudinalMeters, LongitudinalMeters);

    [self.mapView setRegion:region animated:YES];
    [self.mapView addAnnotation:self.annotation];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[TACustomAnnotation class]]) {
        TACustomAnnotation *customAnnotation = (TACustomAnnotation *)annotation;
        
        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
        
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

#pragma mark - Actions

-(void)didTapSearchButton {
    self.searchVC = [[SearchViewController alloc] init];
    self.searchVC.delegate = self;

    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchVC];
    self.searchController.searchResultsUpdater = self;
    [self presentViewController:self.searchController animated:YES completion:nil];
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = searchController.searchBar.text;
    
    if (searchController.searchResultsController) {
        SearchViewController *searchVC = (SearchViewController *)searchController.searchResultsController;
        [searchVC.networkService findFoursquarePlacesWithSearchString:searchText latitude:[NSString stringWithFormat:@"%f", MoscowLatitude] longitude:[NSString stringWithFormat:@"%f", MoscowLongitude]];
        [searchVC.tableView reloadData];
    }
}

#pragma mark - SearchViewDelegate

-(void)didSelectRow:(MapPoint *)mapPoint {
    self.searchController.active = NO;
    UINavigationController *detailNC = [[UINavigationController alloc] initWithRootViewController:[[DetailPointViewController alloc] initWithMapPoint:mapPoint]];
    [self presentViewController:detailNC animated:YES completion:nil];
}

@end
