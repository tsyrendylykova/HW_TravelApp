//
//  TLAMosDataNetworkServiceProtocol.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 12/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

@protocol TLAMosDataNetworkServiceOutputProtocol <NSObject>
@optional

-(void)loadingIsDoneWithDataRecieved:(NSDictionary *)dataRecieved;

@end

@protocol TLAMosDataNetworkServiceInputProtocolMuseums <NSObject>
@optional

-(void)findMosDataMuseums;

@end
