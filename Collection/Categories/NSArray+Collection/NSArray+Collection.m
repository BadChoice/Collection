//
//  NSArray+Collection.m
//  revo-retail
//
//  Created by Badchoice on 25/5/16.
//  Copyright © 2016 Revo. All rights reserved.
//

#import "NSArray+Collection.h"

@implementation NSArray (Collection)

- (NSArray*)filter:(BOOL (^)(id object))condition{
    return [self filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nonnull evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return condition(evaluatedObject);
    }]];
}

- (NSArray*)reject:(BOOL (^)(id object))condition{
    return [self filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nonnull evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return !condition(evaluatedObject);
    }]];
}

- (id)first:(BOOL (^)(id object))condition{
    NSUInteger index = [self indexOfObjectPassingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        return condition(obj);
    }];
    
    return (index == NSNotFound) ? nil : self[index];
}

- (id)first:(BOOL (^)(id object))condition default:(id)defaultObject{
    id object = [self first:condition];
    return (object) ? object : defaultObject;
}

- (id)last:(BOOL (^)(id))condition{
    return [self.reverse first:condition];
}

- (id)last:(BOOL (^)(id object))condition default:(id)defaultObject{
    id object = [self last:condition];
    return (object) ? object : defaultObject;
}

-(BOOL)contains:(BOOL (^)(id object))checker{
    bool __block found = false;
    [self eachWithIndex:^(id object, int index, BOOL *stop) {
        if (checker(object)){
            found = true;
            *stop = true;
        }
    }];
    return found;
}

-(BOOL)doesntContain:(BOOL (^)(id object))checker{
    bool __block found = false;
    [self eachWithIndex:^(id object, int index, BOOL *stop) {
        if (checker(object)){
            found = true;
            *stop = true;
        }
    }];
    return ! found;
}

- (NSArray*)where:(NSString*)keypath like:(id)value{
    return [self whereAny:@[keypath] like:value];
}

- (NSArray*)where:(NSString*)keypath is:(id)value{
    return [self whereAny:@[keypath] is:value];
}

- (NSArray*)whereAny:(NSArray*)keyPaths is:(id)value{
    NSMutableArray* predicates = [NSMutableArray new];
    
    [keyPaths each:^(NSString* keypath) {
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"%K = %@",keypath,value];
        [predicates addObject:predicate];
    }];
    
    NSPredicate *resultPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:predicates];
    return [self filteredArrayUsingPredicate:resultPredicate];
}

- (NSArray*)whereAny:(NSArray*)keyPaths like:(id)value{
    NSMutableArray* predicates = [NSMutableArray new];
    
    [keyPaths each:^(NSString* keypath) {
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"%K contains[c] %@",keypath,value];
        [predicates addObject:predicate];
    }];
    
    NSPredicate *resultPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:predicates];
    return [self filteredArrayUsingPredicate:resultPredicate];
}


- (void)each:(void(^)(id object))operation{
    [self enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
        operation(object);
    }];
}

- (void)eachWithIndex:(void(^)(id object, int index, BOOL *stop))operation{
    [self enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
        operation(object, (int)idx, stop);
    }];
}

-(NSArray*)sort{
    return [self sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        return [a compare:b];
    }];
}

- (NSArray*)sort:(NSString*)key{
    return [self sort:key ascending:YES];
}

- (NSArray*)sort:(NSString*)key ascending:(BOOL)ascending{
    NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:key ascending:ascending];
    return [self sortedArrayUsingDescriptors:@[sortDescriptor]];
}

- (NSArray*)sortWith:(NSComparisonResult (^)(id a, id b))callback{
    return [self sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        return callback(a,b);
    }];
}

- (NSArray*)reverse{
    return [[self reverseObjectEnumerator] allObjects];
}

- (NSArray*)slice:(int)howMany{
    if(howMany > self.count) return @[];
    return  [self subarrayWithRange:NSMakeRange(howMany, self.count - howMany)];
}

-(NSArray*)take:(int)howMany{
    if(howMany > 0)
        return  [self subarrayWithRange:NSMakeRange(0, MIN(howMany,self.count))];
    else
        return  [self subarrayWithRange:NSMakeRange(MAX(0, (int)self.count + howMany), MIN(-howMany,self.count))];
}

-(NSArray*)splice:(int)howMany{
    if([self isKindOfClass:[NSMutableArray class]]){
        if(howMany > self.count) return @[];
        NSArray* chunk = [self slice:howMany];
        [(NSMutableArray*)self removeObjectsInRange:NSMakeRange(howMany, self.count - howMany)];
        return chunk;
    }
    else{
        [NSException raise:@"Array is not mutable" format:@"Array needs to be mutable"];
        return nil;
    }
}

- (NSArray *)map:(id (^)(id obj, NSUInteger idx))block {
    NSMutableArray* result = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateObjectsUsingBlock:^(id currentObject, NSUInteger index, BOOL *stop) {
        id mappedCurrentObject = block(currentObject, index);
        if (mappedCurrentObject)
        {
            [result addObject:mappedCurrentObject];
        }
    }];
    return result;
}

- (NSArray*)flatMap:(id (^)(id obj, NSUInteger idx))block{
    NSMutableArray* results = [NSMutableArray new];
    [self each:^(NSArray* array) {
        [results addObject:[array map:^id(id obj, NSUInteger idx) {
            return block(obj,idx);
        }]];
    }];
    return results;
}

- (NSArray*)flatMap:(NSString*)key block:(id (^)(id obj, NSUInteger idx))block{
    NSMutableArray* results = [NSMutableArray new];
    [self each:^(id object) {
        [results addObject:[[object valueForKey:key] map:^id(id obj, NSUInteger idx) {
            return block(obj,idx);
        }]];
    }];
    return results;
}

- (NSArray*)flatten{
    NSMutableArray* results = [NSMutableArray new];
    [self each:^(NSArray* array) {
        [results addObjectsFromArray:array];
    }];
    return results;
}

- (NSArray*)flatten:(NSString*)keypath{
    NSMutableArray* results = [NSMutableArray new];
    [self each:^(id object) {
        [results addObjectsFromArray:[object valueForKeyPath:keypath]];
    }];
    return results;
}

- (NSArray*)pluck:(NSString*)keyPath{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:self.count];
    [self each:^(id object) {
        [result addObject:[object valueForKeyPath:keyPath]];
    }];
    return result;
}

- (NSDictionary*)pluck:(NSString*)keyPath key:(NSString*)keyKeypath{
    NSMutableDictionary* result = [NSMutableDictionary dictionaryWithCapacity:self.count];
    [self each:^(id object) {
        result[[object valueForKey:keyKeypath]] = [object valueForKey:keyPath];
    }];
    return result;
}

- (id)reduce:(id(^)(id carry, id object))block carry:(id)carry{
    id __block carry2 = carry;
    [self each:^(id object) {
        carry2 = block(carry2,object);
    }];
    return carry2;
}

- (id)reduce:(id(^)(id carry, id object))block{
    return [self reduce:block carry:nil];
}

- (NSDictionary*)groupBy:(NSString*)keypath{
    return [self groupBy:keypath block:^NSString *(id object, NSString *key) {
        return key;
    }];
}

- (NSDictionary*)groupBy:(NSString*)keypath block:(NSString*(^)(id object, NSString* key))block{
    NSMutableDictionary *result = [NSMutableDictionary new];
    
    NSString* finalKeypath = [NSString stringWithFormat:@"%@.@distinctUnionOfObjects.self",keypath];
    NSArray *distinct = [self valueForKeyPath:finalKeypath];
    
    [distinct each:^(NSString* value) {
        NSPredicate *predicate  = [NSPredicate predicateWithFormat:@"%K = %@", keypath,value];
        NSArray *objects        = [self filteredArrayUsingPredicate:predicate];
        [result setObject:objects forKey:block(objects[0],value)];
    }];
    
    //NSLog(@"%@", result);
    return result;
}

- (NSDictionary*)expand:(NSString*)keypath{
    return [self expand:keypath unique:NO];
}

- (NSDictionary*)expand:(NSString *)keypath unique:(BOOL)unique{
    if(unique) keypath = [NSString stringWithFormat:@"%@.@distinctUnionOfObjects.self",keypath];
    
    NSMutableDictionary* result = [NSMutableDictionary new];
    [self each:^(id object) {
        [[object valueForKeyPath:keypath] each:^(id key) {
            if(result[key] == nil) result[key] = [NSMutableArray new];
            [result[key] addObject:object];
        }];
    }];
    return result;
}

-(id)maxObject{
    return [self reduce:^id(id carry, id object) {
        return (object > carry ) ? object : carry;
    } carry:self.firstObject];
}

-(id)maxObject:(NSString *)keypath{
    return [self reduce:^id(id carry, id object) {
        return ([object valueForKeyPath:keypath] > [carry valueForKeyPath:keypath] ) ? object : carry;
    } carry:self.firstObject];
}

-(id)minObject{
    return [self reduce:^id(id carry, id object) {
        return (object < carry ) ? object : carry;
    } carry:self.firstObject];
}

-(id)minObject:(NSString *)keypath{
    return [self reduce:^id(id carry, id object) {
        return ([object valueForKeyPath:keypath] < [carry valueForKeyPath:keypath] ) ? object : carry;
    } carry:self.firstObject];
}

-(NSArray*)zip:(NSArray*)other{
    NSInteger size = MIN(self.count, other.count);
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:size];
    for (NSUInteger idx = 0; idx < size; idx++)
    {
        [result addObject:[NSArray arrayWithObjects:[self objectAtIndex:idx], [other objectAtIndex:idx], nil]];
    }
    
    return result;
}

-(NSDictionary*)mapToAssoc:(NSArray*(^)(id obj, NSUInteger idx))block{
    NSArray* pairs = [self map:block];
    
    return [pairs reduce:^id(NSMutableDictionary* dict, NSArray* mapped) {
        dict[mapped[0]] = mapped[1];
        return dict;
    } carry:[NSMutableDictionary new]];
}

-(NSCountedSet*)countedSet{
    return [NSCountedSet setWithArray:self];
}

-(NSString*)implode:(NSString*)delimiter{
    return [self componentsJoinedByString:delimiter];
}

//==============================================
#pragma mark - Operators
//==============================================
- (NSNumber*)operator:(NSString*)operator keypath:(NSString*)keypath{
    NSString* finalKeyPath;
    if(keypath != nil)
        finalKeyPath = [NSString stringWithFormat:@"%@.@%@.self",keypath, operator];
    else
        finalKeyPath = [NSString stringWithFormat:@"@%@.self",operator];
    
    return [self valueForKeyPath:finalKeyPath];
}

- (NSNumber*)sum                    { return [self operator:@"sum" keypath:nil];    }
- (NSNumber*)sum:(NSString*)keypath { return [self operator:@"sum" keypath:keypath];}
- (NSNumber*)avg                    { return [self operator:@"avg" keypath:nil];    }
- (NSNumber*)avg:(NSString*)keypath { return [self operator:@"avg" keypath:keypath];}
- (NSNumber*)max                    { return [self operator:@"max" keypath:nil];    }
- (NSNumber*)max:(NSString*)keypath { return [self operator:@"max" keypath:keypath];}
- (NSNumber*)min                    { return [self operator:@"min" keypath:nil];    }
- (NSNumber*)min:(NSString*)keypath { return [self operator:@"min" keypath:keypath];}

- (NSNumber*)sumWith:(NSNumber*(^)(id object))block{
    return [self reduce:^id(NSNumber* carry, id object) {
        return @(carry.floatValue + block(object).floatValue);
    } carry:@(0)];
}

//==============================================
#pragma mark - Set operations
//==============================================
- (NSArray*)intersect:(NSArray*)b{
    NSMutableOrderedSet *setA = [NSMutableOrderedSet orderedSetWithArray:self];
    NSOrderedSet *setB        = [NSOrderedSet orderedSetWithArray:b];
    [setA intersectOrderedSet:setB];
    return [setA array];
}

- (NSArray*)union:(NSArray*)b{
    NSMutableOrderedSet *setA = [NSMutableOrderedSet orderedSetWithArray:self];
    NSOrderedSet *setB        = [NSOrderedSet orderedSetWithArray:b];
    [setA unionOrderedSet:setB];
    return [setA array];
}

- (NSArray*)minus:(NSArray*)b{
    NSMutableOrderedSet *setA = [NSMutableOrderedSet orderedSetWithArray:self];
    NSOrderedSet *setB        = [NSOrderedSet orderedSetWithArray:b];
    [setA minusOrderedSet:setB];
    return [setA array];
}

-(NSArray*)diff:(NSArray*)b{
    return [self minus:b];
}

- (NSArray*)join:(NSArray*)b{
    return [self arrayByAddingObjectsFromArray:b];
}

- (NSArray*)distinct{
    NSOrderedSet *distinct = [NSOrderedSet orderedSetWithArray:self];
    return [distinct array];
}

- (NSArray*)distinct:(NSString*)keypath{
    NSString* finalKeypath = [NSString stringWithFormat:@"%@.@distinctUnionOfObjects.self",keypath];
    return [self valueForKeyPath:finalKeypath];
}


@end
