//
//  NSString+Collection.m
//  Collection
//
//  Created by Jordi Puigdellívol on 10/8/16.
//  Copyright © 2016 Revo. All rights reserved.
//

#import "NSString+Collection.h"
#import "NSArray+Collection.h"
#import <CommonCrypto/CommonDigest.h>

#define str(A,...)          [NSString stringWithFormat:A,##__VA_ARGS__]

@implementation NSString (Collection)


+(NSString*)repeat:(NSString*)text times:(int)times{
    if(times <= 0) return @"";
    NSMutableString* str = [NSMutableString string];
    for(int i = 0; i < times; i++){
        [str appendString:text];
    }
    return str;
}

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

-(NSString*)append:(NSString*)append{
    return [self stringByAppendingString:append];
}

-(NSString*)prepend:(NSString*)prepend{
    return [prepend stringByAppendingString:self];
}

-(NSString*) substr:(int)from{
    if(from >=0) return [self substringFromIndex:MIN(from,(int)self.length)];
    else         return [self substringFromIndex:MAX((int)self.length + from, 0 )];
}

-(NSString*)substr:(int)from length:(int)length{
    if(from >=0){
        return [self substringWithRange:NSMakeRange(from,length)];
    }
    else{
        return [self substringWithRange:NSMakeRange(self.length + from,length)];
    }
}

-(NSString*)trim{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

-(NSString*)trimWithNewLine{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];    
}

-(NSString*)replace:(NSString*)character with:(NSString*)replace{
    return [self stringByReplacingOccurrencesOfString:character withString:replace];
}



- (NSString *)trimLeft{
    NSCharacterSet *characterSet = [NSCharacterSet whitespaceCharacterSet];
    NSUInteger location = 0;
    NSUInteger length = [self length];
    unichar charBuffer[length];
    [self getCharacters:charBuffer];
    
    for (location = 0; location < length; location++) {
        if (![characterSet characterIsMember:charBuffer[location]]) {
            break;
        }
    }
    
    return [self substringWithRange:NSMakeRange(location, length - location)];
}

- (NSString *)trimRight{
    NSCharacterSet *characterSet = [NSCharacterSet whitespaceCharacterSet];
    NSUInteger location = 0;
    NSUInteger length = 0;
    unichar charBuffer[length];
    [self getCharacters:charBuffer];
    
    for (length = self.length; length > 0; length--) {
        if (![characterSet characterIsMember:charBuffer[length - 1]]) {
            break;
        }
    }
    
    return [self substringWithRange:NSMakeRange(location, length - location)];
}

- (NSString *)camelCase{
    return self.pascalCase.lcFirst;
}

- (NSString *)pascalCase{
    NSString* withoutWhiteSpaces =  [[self explode:@" "] reduce:^id(NSString* carry, NSString* word) {
        return str(@"%@%@",carry,word.ucFirst);
    } carry:@""];
    
    return [[withoutWhiteSpaces explode:@"_"] reduce:^id(NSString* carry, NSString* word) {
        return str(@"%@%@",carry,word.ucFirst);
    } carry:@""];
}

-(NSString *)snakeCase{
    NSUInteger index = 1;
    NSMutableString *snakeCaseString = [NSMutableString stringWithString:self];
    NSUInteger length = snakeCaseString.length;
    NSMutableCharacterSet *characterSet = [NSCharacterSet uppercaseLetterCharacterSet].mutableCopy;
    [characterSet formUnionWithCharacterSet:[NSCharacterSet whitespaceCharacterSet]];
    while (index < length) {
        if ([characterSet characterIsMember:[snakeCaseString characterAtIndex:index]]) {
            [snakeCaseString insertString:@"_" atIndex:index];
            index++;
        }
        index++;
    }
    return [snakeCaseString.lowercaseString replace:@" " with:@""];
}

- (NSString *)ucFirst  {
    if (self.length <= 1) {
        return self.uppercaseString;
    } else {
        return str(@"%@%@",[[self substringToIndex:1] uppercaseString],
                            [self substringFromIndex:1]);
    }
}

- (NSString *)lcFirst {
    if (self.length <= 1) {
        return self.lowercaseString;
    } else {
        return str(@"%@%@",[[self substringToIndex:1] lowercaseString],
                            [self substringFromIndex:1]);
    }
}

-(BOOL)endsWith:(NSString *)compare{
    NSPredicate *fltr = [NSPredicate predicateWithFormat:@"self ENDSWITH %@",compare];
    return [fltr evaluateWithObject:self];
}

-(BOOL)startsWith:(NSString *)compare{
    //[c] for case insensitive
    //NSPredicate *fltr = [NSPredicate predicateWithFormat:@"self BEGINSWITH[c] %@",compare];
    NSPredicate *fltr = [NSPredicate predicateWithFormat:@"self BEGINSWITH %@",compare];
    return [fltr evaluateWithObject:self];
}

-(BOOL)contains:(NSString *)compare{
    //[c] for case insensitive
    //NSPredicate *fltr = [NSPredicate predicateWithFormat:@"self BEGINSWITH[c] %@",compare];
    NSPredicate *fltr = [NSPredicate predicateWithFormat:@"self CONTAINS %@",compare];
    return [fltr evaluateWithObject:self];
}

-(NSString*)lpad:(int)lenght string:(NSString*)string{
    int finalLength = MAX(0, lenght - (int)self.length);
    NSString* padChars = [[NSString string] stringByPaddingToLength:finalLength
                                                         withString:string
                                                    startingAtIndex:0];
    
    return [padChars append:self];
    
}

-(NSString*)rpad:(int)lenght string:(NSString*)string{
    return [self stringByPaddingToLength:MAX((int)self.length,lenght)
                              withString:string
                         startingAtIndex:0];
}

-(NSString*)urlEncode{
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]];
}

-(NSString*)urlDecode{
    return [self stringByRemovingPercentEncoding];
}

-(NSString*)md5{
    const char *cStr = [self UTF8String];
    unsigned char digest[16];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSMutableString *md5 = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [md5 appendFormat:@"%02x", digest[i]];
    }
    return md5;
}


@end
