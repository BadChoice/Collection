//
//  NSDictionary+Collection.h
//  Collection
//
//  Created by Jordi Puigdellívol on 10/8/16.
//  Copyright © 2016 Revo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Collection)

+ (NSDictionary*)fromData:(NSData*)data;
+ (NSDictionary*)fromString:(NSString*)string;
- (NSString*)toString;

- (void)each:(void(^)(id key, id object))operation;
- (NSDictionary*)filter:(BOOL (^)(id key, id object))condition;
- (NSDictionary*)reject:(BOOL (^)(id key, id object))condition;
- (NSDictionary*)map:(id (^)(id key, id object))callback;
@end
