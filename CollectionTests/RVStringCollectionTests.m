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

-(void)testContains{
    XCTAssertTrue   ( [@"Hello world" contains:@"lo wo" ]);
    XCTAssertFalse  ( [@"Hello world" contains:@"lo Wo" ]);
    XCTAssertFalse  ( [@"Hello world" contains:@"byebye" ]);
}

-(void)testLPad{
    NSString * result = [@"hola" lpad:8 string:@"."];
    XCTAssertTrue([@"....hola" isEqualToString:result]);
    
    NSString * result1 = [@"hola" lpad:9 string:@".*"];
    XCTAssertTrue([@".*.*.hola" isEqualToString:result1]);
    
    NSString * result2 = [@"hola" lpad:8 string:@".*-_"];
    XCTAssertTrue([@".*-_hola" isEqualToString:result2]);
    
    NSString * result3 = [@"hola" lpad:8 string:@".*-_/?¿"];
    XCTAssertTrue([@".*-_hola" isEqualToString:result3]);
    
    NSString * result4 = [@"hola" lpad:2 string:@"."];
    XCTAssertTrue([@"hola" isEqualToString:result4]);
}

-(void)testRPad{
    NSString * result = [@"hola" rpad:8 string:@"."];
    XCTAssertTrue([@"hola...." isEqualToString:result]);
    
    NSString * result1 = [@"hola" rpad:9 string:@".*"];
    XCTAssertTrue([@"hola.*.*." isEqualToString:result1]);
    
    NSString * result2 = [@"hola" rpad:8 string:@".*-_"];
    XCTAssertTrue([@"hola.*-_" isEqualToString:result2]);
    
    NSString * result3 = [@"hola" rpad:8 string:@".*-_/?¿"];
    XCTAssertTrue([@"hola.*-_" isEqualToString:result3]);
    
    NSString * result4 = [@"hola" rpad:2 string:@"."];
    XCTAssertTrue([@"hola" isEqualToString:result4]);
}

-(void)testRepeat{
    NSString* result = [NSString repeat:@".*" times:4];
    XCTAssertTrue([@".*.*.*.*" isEqualToString:result]);
    
    NSString* result2 = [NSString repeat:@".*" times:-4];
    XCTAssertTrue([@"" isEqualToString:result2]);
}

-(void)testSubstring{
    NSString* result = [@"a string to cut" substr:2];
    XCTAssertTrue([@"string to cut" isEqualToString:result]);
    
    NSString* result2 = [@"a string to cut" substr:4];
    XCTAssertTrue([@"ring to cut" isEqualToString:result2]);
    
    NSString* result3 = [@"123456" substr:-3];
    XCTAssertTrue([@"456" isEqualToString:result3]);
    
    NSString* result4 = [@"123456" substr:-2];
    XCTAssertTrue([@"56" isEqualToString:result4]);
    
    NSString* result5 = [@"1" substr:-2];
    XCTAssertTrue([@"1" isEqualToString:result5]);
}

-(void)testSubstring2{
    NSString* result = [@"a string to cut" substr:2 length:6];
    XCTAssertTrue([@"string" isEqualToString:result]);
    
    NSString* result2 = [@"a string to cut" substr:4 length:2];
    XCTAssertTrue([@"ri" isEqualToString:result2]);
    
    NSString* result3 = [@"123456" substr:-3 length:3];
    XCTAssertTrue([@"456" isEqualToString:result3]);
    
    NSString* result4 = [@"123456" substr:-2 length:2];
    XCTAssertTrue([@"56" isEqualToString:result4]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
