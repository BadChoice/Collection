//
//  NSString+Collection.m
//  Collection
//
//  Created by Jordi Puigdellívol on 10/8/16.
//  Copyright © 2016 Revo. All rights reserved.
//

#import "NSString+Collection.h"
#import "NSArray+Collection.h"

@implementation NSString (Collection)

-(NSArray*)explode:(NSString*)delimiter{
    return [self componentsSeparatedByString:delimiter];
}

- (NSString*)initials{
    NSArray* components = [self explode:@" "];
    
    if(components.count == 1) return [self substringToIndex:MIN(3,self.length)];
    
    return [[components take:3] reduce:^id(NSString* carry, NSString* component) {
        return [carry stringByAppendingString:[component substringToIndex:1]];
    } carry:@""];
}

-(NSNumber*)toNumber{
    return @([self stringByReplacingOccurrencesOfString:@"," withString:@"."].floatValue);
}

@end
