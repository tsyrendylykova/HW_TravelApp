//
//  TLATripsService.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 20/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//


#import "TLAService.h"


NS_ASSUME_NONNULL_BEGIN


@interface TLATripsService : TLAService

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

NS_ASSUME_NONNULL_END
