//
//  TACustomAnnotation.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 28/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "TACustomAnnotation.h"

@implementation TACustomAnnotation

-(instancetype)initWithTitle: (NSString *)newTitle subtitle: (NSString *)subtitle location:(CLLocationCoordinate2D)location {
    self = [super init];
    if (self) {
        _coordinate = location;
        _title = newTitle;
        _subtitle = subtitle;
    }
    return self;
}

-(MKAnnotationView *)annotationView {
    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"myCustomAnnotation"];
    
    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;
    annotationView.image = [UIImage imageNamed:@"pin"];
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    return annotationView;
}

@end
