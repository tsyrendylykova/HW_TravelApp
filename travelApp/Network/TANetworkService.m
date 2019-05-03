//
//  TANetworkService.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 24/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "TANetworkService.h"
#import "TANetworkHelper.h"


@interface TANetworkService () <NSURLSessionDelegate>

@end


@implementation TANetworkService

-(void)findFoursquarePlacesWithSearchString: (NSString *)searchString latitude:(NSString *)latitude longitude:(NSString *)longitude {
    NSString *urlString = [TANetworkHelper URLForSearchString:searchString latitude:latitude longitude:longitude];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setTimeoutInterval:15];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            [self downloadTaskWithURL:urlString];
        } else {
            NSLog(@"%@", error);
        }
    }];

    [sessionDataTask resume];
}

-(void)findMosDataMuseums {
    NSString *urlString = [TANetworkHelper URLForMuseumSearch];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setTimeoutInterval:15];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            [self downloadTaskWithURL:urlString];
        } else {
            NSLog(@"%@", error);
        }
    }];
    
    [sessionDataTask resume];
}


#pragma mark - URLSessionDelegate

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    NSData *data = [NSData dataWithContentsOfURL:location];
    NSDictionary *temp = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.output loadingIsDoneWithDataRecieved:temp];
    });
    [session finishTasksAndInvalidate];
}

-(void)downloadTaskWithURL: (NSString *)stringURL {
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:[NSURL URLWithString:stringURL]];
    
    [downloadTask resume];
}

@end
