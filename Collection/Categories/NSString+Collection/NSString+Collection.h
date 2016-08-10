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
@end
