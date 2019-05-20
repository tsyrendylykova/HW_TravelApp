//
//  TLAAddTripService.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 20/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "TLAService.h"

NS_ASSUME_NONNULL_BEGIN

@interface TLAAddTripService : TLAService

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

-(void)addNewTripActionWith:(NSDate *)startDate endDate:(NSDate *)endDate name:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
