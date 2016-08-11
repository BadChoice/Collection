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

-(void)testCamelCase{
    NSString* result = @"this should be camelcased".camelCase;
    XCTAssertTrue( [result isEqualToString:@"thisShouldBeCamelcased"]);
    
    NSString* result2 = @"this_should_be_camelcased".camelCase;
    XCTAssertTrue( [result2 isEqualToString:@"thisShouldBeCamelcased"]);
    
    NSString* result3 = @"this Should be camelCased".camelCase;
    XCTAssertTrue( [result3 isEqualToString:@"thisShouldBeCamelCased"]);
    
    NSString* result4 = @"this_should_beCamelCased".camelCase;
    XCTAssertTrue( [result4 isEqualToString:@"thisShouldBeCamelCased"]);
}

-(void)testPascalCase{
    NSString* result = @"this should be pascalcased".pascalCase;
    XCTAssertTrue( [result isEqualToString:@"ThisShouldBePascalcased"]);
    
    NSString* result2 = @"this_should_be_pascalcased".pascalCase;
    XCTAssertTrue( [result2 isEqualToString:@"ThisShouldBePascalcased"]);
    
    NSString* result3 = @"this Should be pascalCased".pascalCase;
    XCTAssertTrue( [result3 isEqualToString:@"ThisShouldBePascalCased"]);
    
    NSString* result4 = @"this_should_be_pascalCased".pascalCase;
    XCTAssertTrue( [result4 isEqualToString:@"ThisShouldBePascalCased"]);
}

-(void)testSnakeCase{
    NSString* result = @"thisShouldBeSnakeCased".snakeCase;
    XCTAssertTrue( [result isEqualToString:@"this_should_be_snake_cased"]);
    
    NSString* result2 = @"ThisShouldBeSnakeCased".snakeCase;
    XCTAssertTrue( [result2 isEqualToString:@"this_should_be_snake_cased"]);
    
    NSString* result3 = @"this should be snakeCased".snakeCase;
    XCTAssertTrue( [result3 isEqualToString:@"this_should_be_snake_cased"]);
    
    NSString* result4 = @"this should be snake cased".snakeCase;
    XCTAssertTrue( [result4 isEqualToString:@"this_should_be_snake_cased"]);
}

-(void)testEndsWith{
    XCTAssertTrue   ( [@"Hello world" endsWith:@"world" ]);
    XCTAssertFalse  ( [@"Hello world" endsWith:@"World" ]);
    XCTAssertFalse  ( [@"Hello world" endsWith:@"Hello" ]);
}

-(void)testStartsWith{
    XCTAssertTrue   ( [@"Hello world" startsWith:@"Hello" ]);
    XCTAssertFalse  ( [@"Hello world" startsWith:@"hello" ]);
    XCTAssertFalse  ( [@"Hello world" startsWith:@"World" ]);
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
