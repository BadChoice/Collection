//
//  RVDictionaryCollectionTests.m
//  Collection
//
//  Created by Jordi Puigdellívol on 10/8/16.
//  Copyright © 2016 Revo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDictionary+Collection.h"

@interface RVDictionaryCollectionTests : XCTestCase

@end

@implementation RVDictionaryCollectionTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testFilter {
    NSDictionary* filtered = [@{@"pass":@0,@"dontPass":@1} filter:^BOOL(id key, id object) {
        return [object floatValue] == 0;
    }];
    
    NSDictionary* expectation =@{@"pass":@0 };
    XCTAssertTrue([filtered isEqualToDictionary:expectation]);
}

- (void)testReject {
    NSDictionary* filtered = [@{@"pass":@0,@"dontPass":@1} reject:^BOOL(id key, id object) {
        return [object floatValue] == 0;
    }];
    
    NSDictionary* expectation =@{@"dontPass":@1 };
    XCTAssertTrue([filtered isEqualToDictionary:expectation]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
