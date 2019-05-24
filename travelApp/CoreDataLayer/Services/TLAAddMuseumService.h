//
//  TLAAddMuseumService.h
//  travelApp
//
//  Created by Цырендылыкова Эржена on 20/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//


#import "TLAService.h"
#import "Trip+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface TLAAddMuseumService : TLAService

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

- (void)saveWithInfo:(NSMutableDictionary *)info rowNumber:(NSInteger)rowNumber trip:(Trip *)trip electedDateInPicker:(NSDate *)selectedDateInPicker;

@end

NS_ASSUME_NONNULL_END
