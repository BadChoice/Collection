//
//  RVArrayCollectionSetsTests.m
//  Collection
//
//  Created by Jordi Puigdellívol on 24/6/16.
//  Copyright © 2016 Revo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSArray+Collection.h"

@interface RVArrayCollectionSetsTests : XCTestCase

@end

@implementation RVArrayCollectionSetsTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

-(void)test_minus{
    NSArray* result      = [@[@1, @2, @3, @4] minus:@[@2, @4, @5]];
    NSArray* expectation = @[@1, @3];
    
    XCTAssertEqualObjects(expectation, result);
}

-(void)test_minus_without_repeated{
    NSArray* result = [@[@1, @2, @2, @3, @4] minusExactOcurrences:@[@2, @4, @5]];
    NSArray* expectation   = @[@1, @2, @3];
    
    XCTAssertEqualObjects(expectation, result);
}



@end
