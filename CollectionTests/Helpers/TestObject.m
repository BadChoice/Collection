//
//  TestObject.m
//  CollectionTests
//
//  Created by Jordi Puigdellívol on 10/1/18.
//  Copyright © 2018 Revo. All rights reserved.
//

#import "TestObject.h"

@implementation TestObject


+(TestObject*)make:(NSString*)name age:(NSNumber*)age{
    TestObject* object = TestObject.new;
    object.name = name;
    object.age = age;
    return object;
}

@end
