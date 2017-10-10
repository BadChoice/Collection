//
//  RVArrayHighOrderTest.m
//  CollectionTests
//
//  Created by Badchoice on 10/10/17.
//  Copyright © 2017 Revo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSArray+HighOrder.h"

@interface TestClass : NSObject
@property(nonatomic) BOOL available;
@end

@implementation TestClass : NSObject

+(TestClass*)make:(BOOL)available{
    TestClass * tc  = [TestClass new];
    tc.available    = available;
    return tc;
}

-(BOOL)isAvailable{
    return self.available;
}

-(NSString*)hello{
    return @"world";
}

-(NSString*)echo:(NSString*)echo{
    return echo;
}

@end


@interface RVArrayHighOrderTest : XCTestCase

@end

@implementation RVArrayHighOrderTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

-(void)test_map{
    NSArray* original  = @[[TestClass new], [TestClass new], [TestClass new]];
    NSArray * result   = [original map_:@selector(hello)];
    
    XCTAssertEqual(@"world", result.firstObject);
}

-(void)test_map_with_object{
    NSArray* original  = @[[TestClass new], [TestClass new], [TestClass new]];
    NSArray * result   = [original map_:@selector(echo:) withObject:@"baby"];
    
    XCTAssertEqual(@"baby", result.firstObject);
}

-(void)test_filter{
    NSArray* original  = @[[TestClass make:true], [TestClass make:true], [TestClass make:false]];
    NSArray * result   = [original filter_:@selector(isAvailable)];
    
    
    XCTAssertEqual(2, result.count);
}

-(void)test_reject{
    NSArray* original  = @[[TestClass make:true], [TestClass make:true], [TestClass make:false]];
    NSArray * result   = [original reject_:@selector(isAvailable)];
    
    
    XCTAssertEqual(1, result.count);
}

@end
