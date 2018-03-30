//
//  RVUtilsTests.m
//  RVUtilsTests
//
//  Created by Badchoice on 15/6/16.
//  Copyright © 2016 Revo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSArray+Collection.h"
#import "TestObject.h"

@interface RVArrayCollectionTests : XCTestCase

@end

@implementation RVArrayCollectionTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

-(void)testSlice{
    NSArray * result        = [@[@1,@2,@3,@4,@5,@6] slice:3];
    NSArray * expectation   = @[@4,@5,@6];
    XCTAssertTrue([result isEqual:expectation]);
}

-(void)testSliceBigger{
    NSArray * result        = [@[@1,@2,@3,@4,@5,@6] slice:10];
    NSArray * expectation   = @[];
    XCTAssertTrue([result isEqual:expectation]);
}

-(void)testSliceEqual{
    NSArray * result        = [@[@1,@2,@3,@4,@5,@6] slice:6];
    NSArray * expectation   = @[];
    XCTAssertTrue([result isEqual:expectation]);
}

-(void)testTake{
    NSArray * result        = [@[@1,@2,@3,@4,@5,@6] take:2];
    NSArray * expectation   = @[@1,@2];
    XCTAssertTrue([result isEqual:expectation]);
}

-(void)testTakeBigger{
    NSArray * result        = [@[@1,@2,@3,@4,@5,@6] take:10];
    NSArray * expectation   = @[@1,@2,@3,@4,@5,@6];
    XCTAssertTrue([result isEqual:expectation]);
}

-(void)testTagkeNegative{
    NSArray * result        = [@[@1,@2,@3,@4,@5,@6] take:-2];
    NSArray * expectation   = @[@5,@6];
    XCTAssertTrue([result isEqual:expectation]);
}

-(void)testTakeNegativeBigger{
    NSArray * result        = [@[@1,@2,@3,@4,@5,@6] take:-10];
    NSArray * expectation   = @[@1,@2,@3,@4,@5,@6];
    XCTAssertTrue( [result isEqual:expectation] );
}

-(void)testSplice{
    NSArray* array2             = @[@1, @2, @3, @4, @5].mutableCopy;
    NSArray* chunk              = [array2 splice:2];
    NSArray* cunkExpectation    = @[@1, @2];
    NSArray* arrayExpectation   = @[@3, @4, @5];
    XCTAssertTrue([chunk isEqual:cunkExpectation]);
    XCTAssertTrue([array2 isEqual:arrayExpectation]);
}

-(void)testSpliceBigger{
    NSArray* array2             = @[@1,@2,@3,@4,@5].mutableCopy;
    NSArray* chunk              = [array2 splice:10];
    NSArray* cunkExpectation    = @[@1,@2,@3,@4,@5];
    NSArray* arrayExpectation   = @[];
    XCTAssertTrue([chunk isEqual:cunkExpectation]);
    XCTAssertTrue([array2 isEqual:arrayExpectation]);
}

-(void)testExpand{
    NSDictionary* d1    = @{@"groups" : @[@1,@2]};
    NSDictionary* d2    = @{@"groups" : @[@2,@3,@3]};
    NSArray * array     = @[d1,d2];
    
    NSDictionary* result = [array expand:@"groups"];
    
    NSDictionary* expectation = @{
                                  @1 : @[d1],
                                  @2 : @[d1,d2],
                                  @3 : @[d2,d2]
                                  }.mutableCopy;
    
    XCTAssertTrue([result isEqual: expectation]);
}

-(void)testExpandUnique{
    NSDictionary* d1    = @{@"groups" : @[@1,@2]};
    NSDictionary* d2    = @{@"groups" : @[@2,@3,@3]};
    NSArray * array     = @[d1,d2];
    
    NSDictionary* result = [array expand:@"groups" unique:YES];
    
    NSDictionary* expectation = @{
                                  @1 : @[d1],
                                  @2 : @[d1,d2],
                                  @3 : @[d2]
                                  }.mutableCopy;
    
    XCTAssertTrue([result isEqual: expectation]);
}

-(void)testZipEqualSize{
    NSArray* n1         = @[@"a",@"b",@"c"];
    NSArray* n2         = @[@"1",@"2",@"3"];
    NSArray* result     = [n1 zip:n2];
    
    NSArray* expectation = @[
                             @[@"a",@"1"],
                             @[@"b",@"2"],
                             @[@"c",@"3"],
                             ];
    
    XCTAssertTrue([result isEqualToArray:expectation]);
}

-(void)testZipDifferentSize{
    NSArray* n1         = @[@"a",@"b",@"c",@"d"];
    NSArray* n2         = @[@"1",@"2",@"3"];
    NSArray* result     = [n1 zip:n2];
    
    NSArray* expectation = @[
                             @[@"a",@"1"],
                             @[@"b",@"2"],
                             @[@"c",@"3"],
                             ];
    
    XCTAssertTrue([result isEqualToArray:expectation]);
}

-(void)testMapToAssoc{
    NSArray* employees = @[
                           @{
                               @"name"          : @"John",
                               @"department"    : @"Sales",
                               @"email"         : @"john@example.com"
                            },
                           @{
                               @"name"          : @"Jane",
                               @"department"    : @"Marketing",
                               @"email"         : @"jane@example.com"
                               }
                           ,
                            @{
                               @"name"          : @"Dave",
                               @"department"    : @"Sales",
                               @"email"         : @"dave@example.com"
                               }
                        ];
    
    NSDictionary* result =[employees mapToAssoc:^NSArray *(NSDictionary* dict, NSUInteger idx) {
        return @[dict[@"name"], dict[@"email"]];
    }];
    
    NSDictionary* expectation = @{
                                  @"John" : @"john@example.com",
                                  @"Jane" : @"jane@example.com",
                                  @"Dave" : @"dave@example.com",
                                  };
    
    XCTAssertTrue([result isEqualToDictionary:expectation]);
    
}

-(void)test_contains_condition_true{
    BOOL doesContain = [@[@"hello",@"goodbye",@"nevermind"] contains:^BOOL(NSString* string) {
        return string.length > 8;
    }];
    
    XCTAssertTrue(doesContain);
}

-(void)test_contains_condition_false{
    
    BOOL doesContain = [@[@"hello",@"goodbye",@"nevermind"] contains:^BOOL(NSString* string) {
        return string.length > 28;
    }];
    
    XCTAssertFalse(doesContain);
}

-(void)test_pluck_with_key{
    
    NSArray* employees = @[
                           @{
                               @"name"          : @"John",
                               @"department"    : @"Sales",
                               @"email"         : @"john@example.com"
                               },
                           @{
                               @"name"          : @"Jane",
                               @"department"    : @"Marketing",
                               @"email"         : @"jane@example.com"
                               }
                           ,
                           @{
                               @"name"          : @"Dave",
                               @"department"    : @"Sales",
                               @"email"         : @"dave@example.com"
                               }
                           ];
    
    NSDictionary* result = [employees pluck:@"email" key:@"name"];
    NSDictionary* expectation = @{
                                  @"John" : @"john@example.com",
                                  @"Jane" : @"jane@example.com",
                                  @"Dave" : @"dave@example.com",
                                  };
    
    XCTAssertTrue([result isEqualToDictionary:expectation]);
    
}

-(void)testImplode{
    NSString* string = [@[@"hello",@"how are",@"you"] implode:@" "];
    XCTAssertTrue([string isEqualToString:@"hello how are you"]);
}


-(void)testDoesntContain{    
    BOOL doesNotContain1 = [@[@1,@2,@3,@4] doesntContain:^BOOL(id object) {
        return [object isEqual:@1];
    }];
    
    BOOL doesNotContain10 = [@[@1,@2,@3,@4] doesntContain:^BOOL(id object) {
        return [object isEqual:@10];
    }];
    
    XCTAssertFalse ( doesNotContain1  );
    XCTAssertTrue  ( doesNotContain10 );
}

-(void)testSumWith{
    NSNumber* result = [@[@1,@2,@3] sumWith:^NSNumber *(NSNumber* object) {
        return @(object.floatValue*2);
    }];
    
    XCTAssertTrue([@12 floatValue] == [result floatValue]);
}

-(void)testToString{
    
    NSString* result        = @[@1,@2,@3].toString;
    NSString* expectation   = @"[1,2,3]";
    
    XCTAssertTrue([result isEqualToString:expectation]);
}

-(void)testCrossJoin{
    
    NSArray* result  = [@[@"a", @"b"] crossJoin: @[@1, @2] ];
    
    NSArray* result2 = [@[@1, @2] crossJoin: @[
                                               @[@"a", @"b"],
                                               @[@"I", @"II", @"III"]
                                               ] ];

    XCTAssertEqual(4,  result.count);
    XCTAssertEqual(12, result2.count);
    
    NSArray* expectation    = @[@"a", @1];
    NSArray* expectation2   = @[@1,@"b",@"II"];
    XCTAssertTrue( [result  containsObject:expectation] );
    XCTAssertTrue( [result2 containsObject:expectation2 ] );
}

-(void)test_filter_with{
    NSArray* array = @[
                       @{@"theKey": @1},
                       @{@"theKey": @1},
                       @{@"theKey": @0},
                       @{@"theKey": @0}
                       ];
    NSArray* result = [array filterWith:@"theKey"];
    
    XCTAssertEqual(2, result.count);
    XCTAssertTrue([result.firstObject[@"theKey"] boolValue]);
}

-(void)test_reject_with{
    NSArray* array = @[
                       @{@"theKey": @1},
                       @{@"theKey": @1},
                       @{@"theKey": @0},
                       @{@"theKey": @0}
                       ];
    NSArray* result = [array rejectWith:@"theKey"];
    
    XCTAssertEqual(2, result.count);
    XCTAssertFalse([result.firstObject[@"theKey"] boolValue]);
}

-(void)test_permutations{
    NSArray* array = @[@1, @2, @3];
    NSArray* permutations = [array permutations];
    XCTAssertEqual(6, permutations.count);
    
    array = @[@1, @2, @3, @4];
    permutations = [array permutations];
    XCTAssertEqual(24, permutations.count);
    
    array = @[@1, @2, @3, @4, @5, @6, @7];
    permutations = [array permutations];
    XCTAssertEqual(5040, permutations.count);
}

-(void)test_can_sort_with_nil_in_the_end{
    
    TestObject *a = [TestObject make:@"batman"    age:@(45)];
    TestObject *b = [TestObject make:@"spiderman" age:@(16)];
    TestObject *c = [TestObject make:@"jocker"    age:nil];
    TestObject *d = [TestObject make:@"ironman"   age:@(42)];
    
    NSArray* result = [@[a,b,c,d] sortWithNilAtTheEnd:@"age" ascending:YES];
    
    XCTAssertEqual(result[0], b);
    XCTAssertEqual(result[1], d);
    XCTAssertEqual(result[2], a);
    XCTAssertEqual(result[3], c);
}

-(void)test_can_find_where_like{
    NSArray* array = @[
                    @{@"key":@"hola que tal"},
                    @{@"key":@"hola tal"},
                    @{@"key":@"hello baby"},
                    @{@"key":@"hola"}
                ];
    
    NSArray* result = [array where:@"key" like:@"hola tal"];
    
    XCTAssertEqual( 2, result.count );
    XCTAssertEqual( @"hola que tal", result[0][@"key"] );
    XCTAssertEqual( @"hola tal", result[1][@"key"] );
}

-(void)test_range{
    NSArray* result = [NSArray range:0 to:4];
    NSArray* expectation = @[@0, @1, @2, @3, @4];
    XCTAssertEqualObjects(expectation, result);
}

-(void)test_range_step{
    NSArray* result = [NSArray range:0 to:6 step:2];
    NSArray* expectation = @[@0, @2, @4, @6];
    XCTAssertEqualObjects(expectation, result);
}

-(void)test_count_keypath{
    NSArray * sample = @[
      @ {@"toCount" : @[@1, @2]},
      @ {@"toCount" : @[@3, @4]},
      @ {@"toCount" : @[@5, @6, @7]},
    ];
    XCTAssertEqual(7, [sample countKeyPath:@"toCount"]);
}

@end
