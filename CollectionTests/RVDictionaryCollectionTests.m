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

- (void)testFromString{    
    NSDictionary* result = [NSDictionary fromString:@"{\"hello\":\"how are you\"}"];
    NSDictionary* expectation =@{@"hello":@"how are you" };
    XCTAssertTrue([result isEqualToDictionary:expectation]);
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

-(void)testMap{
    NSDictionary* result = [@{@"toBeMapped":@"value",@"toBeMapped2":@"value2"} map:^id(id key, id object) {
        return [key stringByAppendingString:object];
    }];
    
    NSDictionary* expectation = @{@"toBeMapped":@"toBeMappedvalue",@"toBeMapped2":@"toBeMapped2value2"};
    XCTAssertTrue([result isEqualToDictionary:expectation]);
}

-(void)testExcept{
    
    NSDictionary* result = [@{
                            @"key1" : @"hello",
                            @"key2" : @"world",
                            @"key3" : @"forever"
                            } except:@[@"key3", @"unexistingKey"]];
                                       
    XCTAssertTrue(2 == result.count);
    XCTAssertNil(result[@"key3"]);
    XCTAssertEqual(result[@"key2"], @"world");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
