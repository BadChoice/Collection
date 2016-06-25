//
//  RVArrayCollectionMinMaxTests.m
//  Collection
//
//  Created by Jordi Puigdellívol on 24/6/16.
//  Copyright © 2016 Revo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSArray+Collection.h"

@interface RVArrayCollectionMinMaxTests : XCTestCase

@end

@implementation RVArrayCollectionMinMaxTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

-(void)testMax{
    NSNumber* max = [@[@1,@2,@3,@12,@4,@5,@6] max];
    XCTAssertTrue([max isEqual:@12]);
}

-(void)testMaxByKeypath{
    NSDictionary *a = @{@"value":@1};
    NSDictionary *b = @{@"value":@2};
    NSDictionary *c = @{@"value":@3};
    
    NSNumber* max = [@[a,b,c] max:@"value"];
    XCTAssertTrue([max isEqual:@3]);
}

-(void)testMaxObjectByKeypath{
    NSDictionary *a = @{@"value":@1};
    NSDictionary *b = @{@"value":@2};
    NSDictionary *c = @{@"value":@3};
    
    id max = [@[a,b,c] maxObject:@"value"];
    XCTAssertTrue([max isEqual:c]);
}

-(void)testMin{
    NSNumber* min = [@[@1,@2,@-3,@12,@4,@5,@6] min];
    XCTAssertTrue([min isEqual:@-3]);
}

-(void)testMinByKeypath{
    NSDictionary *a = @{@"value":@1};
    NSDictionary *b = @{@"value":@2};
    NSDictionary *c = @{@"value":@3};
    
    NSNumber* min = [@[a,b,c] min:@"value"];
    XCTAssertTrue([min isEqual:@1]);
}

-(void)testMinObjectByKeypath{
    NSDictionary *a = @{@"value":@1};
    NSDictionary *b = @{@"value":@2};
    NSDictionary *c = @{@"value":@3};
    
    id min = [@[a,b,c] minObject:@"value"];
    XCTAssertTrue([min isEqual:a]);
}


@end
