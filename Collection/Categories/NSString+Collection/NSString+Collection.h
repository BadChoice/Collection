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
@end
