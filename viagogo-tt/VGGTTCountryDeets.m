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
        [self countryLoad:nil];
    }
    return self;
}

+ (VGGTTCountryDeets *)sharedCDManager {
    if(sharedCDManager == nil){
        sharedCDManager = [[super allocWithZone:NULL] init];
    }
    return sharedCDManager;
}


+ (void)setConFilter:(NSNotification*)notification {
    
}

- (void)countryLoad:(NSString *)finalFilter {
    responseData = [NSMutableData data];
    
    if (!finalFilter) {
        NSURLRequest *request = [NSURLRequest requestWithURL:
                                 [NSURL URLWithString:@"https://restcountries.eu/rest/v1/all"]];;
         [[NSURLConnection alloc] initWithRequest:request delegate:self];
    } else {
        NSString *filter = [NSString stringWithFormat:@"https://restcountries.eu/rest/v1/region/%@", finalFilter];
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:filter]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    }
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
    [[[UIAlertView alloc] initWithTitle:@"Ooops" message:@"Something went wrong, please try again later! Code:DeetsCall" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil] show];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %lu bytes of data",(unsigned long)[self.responseData length]);
    
    NSError *myError = nil;
    NSArray *resonse = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    fullDataEntry = resonse;
    
    entryCount = resonse.count;
    
    NSLog(@"945: %@", username);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kFinishedLoading object:nil];
}






@end