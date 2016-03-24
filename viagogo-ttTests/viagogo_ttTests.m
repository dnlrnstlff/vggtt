//
//  viagogo_ttTests.m
//  viagogo-ttTests
//
//  Created by Daniel-Ernest Luff on 22/03/2016.
//  Copyright © 2016 toutright. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "VGGTTCountryDeets.h"
@interface viagogo_ttTests : XCTestCase

@property (nonatomic, strong) NSMutableData *responseData;

@end

@implementation viagogo_ttTests



- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testServerCall {

	XCTestExpectation *exp = [self expectationWithDescription:@"wait for server response"];

    _responseData = [NSMutableData data];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:@"https://restcountries.eu/rest/v1/all"]];;
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (!theConnection) {
        // Release the receivedData object.
        _responseData = nil;
        
        // Inform the user that the connection failed.
        
    }
    
    NSLog(@"request is as follows: %@", request);
    
    
		[exp fulfill];

		[self waitForExpectationsWithTimeout:30 handler:^(NSError * _Nullable error) {
		NSLog(@"\n\n Finished general asynchronous API test: %s \n\n", __FUNCTION__);
	}];

}

- (void)testDownloadPerformance {
    // This is an example of a performance test case.
    [self measureBlock:^{
        VGGTTCountryDeets *countryDeets = [VGGTTCountryDeets sharedCDManager];
        [countryDeets countryLoad:nil];
    }];
}

@end
