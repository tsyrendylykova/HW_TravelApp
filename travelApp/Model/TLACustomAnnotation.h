//
//  TLACustomAnnotation.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 28/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TLACustomAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy, nullable) NSString *title;
@property (nonatomic, readonly, copy, nullable) NSString *subtitle;

-(instancetype)initWithTitle: (NSString *)newTitle subtitle: (NSString *)subtitle location:(CLLocationCoordinate2D)location;
-(MKAnnotationView *)annotationView;

@end

NS_ASSUME_NONNULL_END
