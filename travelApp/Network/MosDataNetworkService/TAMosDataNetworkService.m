//
//  TAMosDataNetworkService.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 12/05/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "TAMosDataNetworkService.h"

@interface TAMosDataNetworkService() <NSURLSessionDelegate>

@end

@implementation TAMosDataNetworkService

-(NSString *)URLForMuseumSearch {
    NSString *api_key = @"4391df2ef2ed86f69c4bccbacba38a5a";
    return [NSString stringWithFormat:@"https://apidata.mos.ru/v1/datasets/529/rows?$top=54&api_key=%@", api_key];
}

-(void)findMosDataMuseums {
    NSString *urlString = [self URLForMuseumSearch];
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

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
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
