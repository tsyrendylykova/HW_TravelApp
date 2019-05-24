//
//  TLAFoursquareNetworkService.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 24/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//


#import "TLAFoursquareNetworkService.h"


@interface TLAFoursquareNetworkService () <NSURLSessionDelegate>

@end


@implementation TLAFoursquareNetworkService

- (NSString *)URLForSearchString:(NSString *)searchString latitude:(NSString *)latitude longitude:(NSString *)longitude {
    NSString *clientID = @"OJYGNXT5D3QZ5QBGZYRQDKSBEGUM5KZ0FRGOROFOSB0Y1RWE";
    NSString *clientSecret = @"CSCKMAASBRQIA2K5QHTIUTWKUQKZILSBOELDEBBPJ3MCP3XW";
    return [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?client_id=%@&client_secret=%@&v=20180323&ll=%@,%@&query=%@&categoryId=4bf58dd8d48988d181941735", clientID, clientSecret, latitude, longitude, searchString];
}

- (void)findFoursquarePlacesWithSearchString: (NSString *)searchString latitude:(NSString *)latitude longitude:(NSString *)longitude {
    NSString *urlString = [self URLForSearchString:searchString latitude:latitude longitude:longitude];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setTimeoutInterval:15];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error)
        {
            NSDictionary *temp = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.output loadingIsDoneWithDataRecieved:temp];
            });
        }
        else
        {
            NSLog(@"%@", error);
        }
    }];

    [sessionDataTask resume];
}

- (void)getImageNSDataFromURL:(NSString *)urlString withCompletionHandler:(void (^)(NSData *data))completionHandler {
    NSURL *imageURL = [NSURL URLWithString:urlString];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    if (completionHandler && imageData)
    {
        completionHandler(imageData);
    }
}

@end
