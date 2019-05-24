//
//  TLAMapViewController.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 23/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//


#import "TLAMapViewController.h"
#import "TLASearchViewController.h"
#import "TLAFoursquareNetworkService.h"
#import "TLADetailPointViewController.h"
#import "TLAMapPoint.h"
#import "TLAConstants.h"


@interface TLAMapViewController () <UISearchBarDelegate>

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) UIBarButtonItem *leftBarButtonItem;
@property (nonatomic, strong) TLASearchViewController *searchVC;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) UINavigationBar *navBar;

@end


@implementation TLAMapViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self prepareAnnotations];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self prepareUI];
    [self initLocationManager];
    [self prepareNavBar];

    self.mapView.delegate = self;
    [self.mapView setShowsUserLocation:YES];
    
}

- (void)prepareUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, TLATopOffset, self.view.frame.size.width, self.view.frame.size.height - TLATopOffset)];
    [self.view addSubview:self.mapView];
}

- (void)prepareNavBar
{
    self.navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, TLANavBarLeftOffset, self.view.frame.size.width, TLANavBarLeftOffset)];
    self.navBar.backgroundColor = [UIColor whiteColor];
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"Sightseeing"];
    item.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"magnifier"] style:UIBarButtonItemStyleDone target:self action:@selector(didTapSearchButton)];
    self.navBar.items = @[item];
    [self.view addSubview:self.navBar];
}

- (void)initLocationManager
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}

- (void)prepareAnnotations
{
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView addAnnotation:self.annotation];
    if (self.annotation.title)
    {
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.annotation.coordinate, TLALatitudinalMeters, TLALongitudinalMeters);
        [self.mapView setRegion:region animated:YES];
    }
}


#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D location;
    location.latitude = TLAMoscowLatitude;
    location.longitude = TLAMoscowLongitude;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location, TLALatitudinalMeters, TLALongitudinalMeters);

    [self.mapView setRegion:region animated:YES];
    [self.mapView addAnnotation:self.annotation];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[TLACustomAnnotation class]])
    {
        TLACustomAnnotation *customAnnotation = (TLACustomAnnotation *)annotation;
        
        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:TLAAnnotationIdentifier];
        
        if (annotationView == nil)
        {
            annotationView = customAnnotation.annotationView;
        }
        else
        {
            annotationView.annotation = annotation;
        }
        return annotationView;
    }
    else
    {
        return nil;
    }
}


#pragma mark - Actions

- (void)didTapSearchButton
{
    self.searchVC = [[TLASearchViewController alloc] init];
    self.searchVC.delegate = self;

    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchVC];
    self.searchController.searchResultsUpdater = self;
    [self presentViewController:self.searchController animated:YES completion:nil];
}


#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchText = searchController.searchBar.text;
    
    if (searchController.searchResultsController) {
        TLASearchViewController *searchVC = (TLASearchViewController *)searchController.searchResultsController;
        [searchVC.networkService findFoursquarePlacesWithSearchString:searchText latitude:[NSString stringWithFormat:@"%f", TLAMoscowLatitude] longitude:[NSString stringWithFormat:@"%f", TLAMoscowLongitude]];
        [searchVC.tableView reloadData];
    }
}


#pragma mark - SearchViewDelegate

- (void)didSelectRow:(TLAMapPoint *)mapPoint
{
    self.searchController.active = NO;
    UINavigationController *detailNC = [[UINavigationController alloc] initWithRootViewController:[[TLADetailPointViewController alloc] initWithMapPoint:mapPoint]];
    [self presentViewController:detailNC animated:YES completion:nil];
}

@end
