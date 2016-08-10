//
//  RVStringCollectionTests.m
//  Collection
//
//  Created by Jordi Puigdellívol on 10/8/16.
//  Copyright © 2016 Revo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+Collection.h"

@interface RVStringCollectionTests : XCTestCase

@end

@implementation RVStringCollectionTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testExplode {
    NSArray* result         = [@"hola;que;tal" explode:@";"];
    NSArray* expectation    = @[@"hola",@"que",@"tal"];
    XCTAssertTrue([result isEqual:expectation]);
}

-(void)testInitials{
    NSString* initials = [@"Jordi Puigdellívol Hernandez" initials];
    XCTAssertTrue([initials isEqualToString:@"JPH"]);
}

-(void)testInitialsMoreThan3{
    NSString* initials = [@"Jordi Puigdellívol Hernandez Patata" initials];
    XCTAssertTrue([initials isEqualToString:@"JPH"]);
}

-(void)testInitialsMoreLessThan3{
    NSString* initials = [@"Jordi Puigdellívol" initials];
    XCTAssertTrue([initials isEqualToString:@"JP"]);
}

-(void)testTrim{
    NSString* result = [@"   trim   " trim];
    XCTAssertTrue( [result isEqualToString:@"trim"]);
}

-(void)testTrimRight{
    NSString* result = [@"   trim   " trimRight];
    XCTAssertTrue( [result isEqualToString:@"   trim"]);
}

-(void)testTrimLeft{
    NSString* result = [@"   trim   " trimLeft];
    XCTAssertTrue( [result isEqualToString:@"trim   "]);
}

-(void)testReplace{
    NSString* result = [@"abcdef" replace:@"f" with:@"a"];
    XCTAssertTrue( [result isEqualToString:@"abcdea"]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
