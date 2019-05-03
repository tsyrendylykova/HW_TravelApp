//
//  TANetworkHelper.m
//  travelApp
//
//  Created by Цырендылыкова Эржена on 24/04/2019.
//  Copyright © 2019 Erzhena Tsyrendylykova. All rights reserved.
//

#import "TANetworkHelper.h"
#import <CoreLocation/CoreLocation.h>

//Client ID
//OJYGNXT5D3QZ5QBGZYRQDKSBEGUM5KZ0FRGOROFOSB0Y1RWE
//Client Secret
//CSCKMAASBRQIA2K5QHTIUTWKUQKZILSBOELDEBBPJ3MCP3XW


//fetch('https://api.foursquare.com/v2/venues/explore?client_id=CLIENT_ID&client_secret=CLIENT_SECRET&v=20180323&limit=1&ll=40.7243,-74.0018&query=museum')

@implementation TANetworkHelper

+(NSString *)URLForSearchString: (NSString *)searchString latitude:(NSString *)latitude longitude:(NSString *)longitude {
    NSString *clientID = @"OJYGNXT5D3QZ5QBGZYRQDKSBEGUM5KZ0FRGOROFOSB0Y1RWE";
    NSString *clientSecret = @"CSCKMAASBRQIA2K5QHTIUTWKUQKZILSBOELDEBBPJ3MCP3XW";
    return [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?client_id=%@&client_secret=%@&v=20180323&ll=%@,%@&query=%@&categoryId=4bf58dd8d48988d181941735", clientID, clientSecret, latitude, longitude, searchString];
}

+(NSString *)URLForMuseumSearch {
    NSString *api_key = @"4391df2ef2ed86f69c4bccbacba38a5a";
    return [NSString stringWithFormat:@"https://apidata.mos.ru/v1/datasets/529/rows?$top=54&api_key=%@", api_key];
}

//4391df2ef2ed86f69c4bccbacba38a5a
//https://apidata.mos.ru/v1/datasets/529/rows?$top=54&api_key=4391df2ef2ed86f69c4bccbacba38a5a

@end
