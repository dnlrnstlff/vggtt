//
//  viagogo_ttTests.m
//  viagogo-ttTests
//
//  Created by Daniel-Ernest Luff on 22/03/2016.
//  Copyright © 2016 toutright. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface viagogo_ttTests : XCTestCase

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

- (void)testLogin {

	XCTestExpectation *exp = [self expectationWithDescription:@"wait for server response"];


	[HAAPICollection2 postUserLoginEmail:@"help@henchmanapp.com" password:@"tadas" success:^(AFHTTPRequestOperation *operation, id response, BOOL succeeded, NSString *message){

		XCTAssertEqual(succeeded, YES);
		[exp fulfill];

	}failure:^(AFHTTPRequestOperation *operation, NSError *error){
		XCTAssert(NO, @"log in test");
		[exp fulfill];
	}];



	[self waitForExpectationsWithTimeout:30 handler:^(NSError * _Nullable error) {
		NSLog(@"\n\n Finished general asynchronous API test %i: %s \n\n", _testNumber, __FUNCTION__);
	}];

}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
