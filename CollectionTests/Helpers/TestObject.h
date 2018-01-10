//
//  TestObject.h
//  CollectionTests
//
//  Created by Jordi Puigdellívol on 10/1/18.
//  Copyright © 2018 Revo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestObject : NSObject

@property(strong, nonatomic) NSString* name;
@property(strong, nonatomic) NSNumber* age;

+(TestObject*)make:(NSString*)name age:(NSNumber*)age;

@end
