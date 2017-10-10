//
//  RVCollection.h
//  RVCollection
//
//  Created by Badchoice on 10/8/16.
//  Copyright © 2016 Revo. All rights reserved.
//

#ifndef RVCollection_h
#define RVCollection_h

#import "NSArray+HighOrder.h"
#import "NSDictionary+Collection.h"
#import "NSString+Collection.h"

//#define isEqual(x,y)        ((x && [x isEqual:y]) || (!x && !y))
#define isEqual(x,y)        ((!isNull(x) && [x isEqual:y]) || (isNull(x) && isNull(y))) //To avoid new warnings
#define valueOrNull(A)      A?A:[NSNull null]
#define valueOr(A,B)        isNull(A)?B:A
#define isNull(A)           (A == nil || [A isKindOfClass:NSNull.class])
#define isEmptyString(A)    [NSString isEmptyString:A]
#define str(A,...)          [NSString stringWithFormat:A,##__VA_ARGS__]

#ifdef DEBUG
#define DLog(format, ...) NSLog(format, ##__VA_ARGS__)
#else
#define DLog(format, ...)
#endif

#endif /* Collection_h */
