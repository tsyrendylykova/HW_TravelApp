//
//  TAMosDataNetworkServiceProtocol.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 12/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

@protocol MosDataNetworkServiceOutputProtocol <NSObject>
@optional

-(void)loadingIsDoneWithDataRecieved:(NSDictionary *)dataRecieved;

@end

@protocol MosDataNetworkServiceInputProtocolMuseums <NSObject>
@optional

-(void)findMosDataMuseums;

@end
