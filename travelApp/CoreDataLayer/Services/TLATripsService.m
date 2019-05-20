//
//  TLATripsService.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 20/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "TLATripsService.h"
#import "Trip+CoreDataClass.h"

@implementation TLATripsService

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController)
    {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:NSStringFromClass([Trip class]) inManagedObjectContext:self.coreDataProvider.persistentContainer.viewContext];
    [fetchRequest setEntity:entity];
    [fetchRequest setSortDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"startDate" ascending:YES]]];
    [fetchRequest setFetchBatchSize:20];
    
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.coreDataProvider.persistentContainer.viewContext sectionNameKeyPath:nil
                                                   cacheName:nil];
    
    _fetchedResultsController = theFetchedResultsController;
    
    return _fetchedResultsController;
    
}

@end
