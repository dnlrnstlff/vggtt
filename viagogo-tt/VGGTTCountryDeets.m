//
//  VGGTTCountryDeets.m
//  viagogo-tt
//
//  Created by Daniel-Ernest Luff on 23/03/2016.
//  Copyright © 2016 toutright. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VGGTTCountryDeets.h"

static VGGTTCountryDeets *sharedCDManager = nil;

@implementation VGGTTCountryDeets

@synthesize responseData;
@synthesize username;
@synthesize password;
@synthesize accountType;
@synthesize entryCount;
@synthesize population;
@synthesize twoLetterCode;
@synthesize region;
@synthesize fullDataEntry;

//- (NSURL) flagURL {
//NSString *url = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture", self.userId];
//return [NSURL URLWithString:url];
//}

- (id) init
{
    if (self = [super init])
    {
        [self countryLoad];
    }
    return self;
}

+ (VGGTTCountryDeets *)sharedCDManager {
    if(sharedCDManager == nil){
        sharedCDManager = [[super allocWithZone:NULL] init];
    }
    return sharedCDManager;
}


- (void)countryLoad {
    responseData = [NSMutableData data];
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:@"https://restcountries.eu/rest/v1/all"]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"didReceiveResponse");
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
    NSLog([NSString stringWithFormat:@"Connection failed: %@", [error description]]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %lu bytes of data",(unsigned long)[self.responseData length]);
    
    NSError *myError = nil;
    NSArray *resonse = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    fullDataEntry = resonse;
    username = [resonse valueForKey:@"name"];
    population = [resonse valueForKey:@"population"];
    twoLetterCode = [resonse valueForKey:@"alpha2Code"];
    region = [resonse valueForKey:@"region"];
    
    entryCount = resonse.count;
    
    NSLog(@"945: %@", username);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kFinishedLoading object:nil];
}






@end