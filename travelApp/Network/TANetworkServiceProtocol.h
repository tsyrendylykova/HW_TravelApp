//
//  TANetworkServiceProtocol.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 24/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

@protocol NetworkServiceOutputProtocol <NSObject>
@optional

-(void)loadingIsDoneWithDataRecieved:(NSDictionary *)dataRecieved;

@end

@protocol NetworkServiceInputProtocol <NSObject>
@optional

-(void)findFoursquarePlacesWithSearchString: (NSString *)searchString latitude:(NSString *)latitude longitude:(NSString *)longitude;

@end
