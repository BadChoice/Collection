//
//  NSString+Collection.h
//  Collection
//
//  Created by Jordi Puigdellívol on 10/8/16.
//  Copyright © 2016 Revo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Collection)

- (NSArray*)  explode:(NSString*)delimiter;
- (NSString*) initials;
- (NSNumber*) toNumber;
- (NSString*) append:(NSString*)append;
- (NSString*) prepend:(NSString*)prepend;

- (NSString*)replace:(NSString*)character with:(NSString*)replace;

/**
 Trims spaces on both ends
 */
- (NSString*) trim;

/**
 Trims spaces and new line characters on both ends
 */
- (NSString*) trimWithNewLine;

- (NSString*) trimLeft;
- (NSString*) trimRight;

/**
 * Converts @"this text" to @"thisText" or @"a_text" to @"aText"
 */
- (NSString *)camelCase;

/**
 * Converts @"this text" to @"ThisText" or @"a_text" to @"AText"
 */
- (NSString *)pascalCase;

/** 
 Converts @"fooBar" to @"foo_bar"
 */
- (NSString *)snakeCase;

/** 
 * Capitalizes first letter
 */
- (NSString *)ucFirst;

/**
 * Lowercases first letter
 */
- (NSString *)lcFirst;

-(BOOL)endsWith:(NSString*)compare;
-(BOOL)startsWith:(NSString*)compare;
-(BOOL)contains:(NSString*)compare;
@end
