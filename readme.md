# NSArray+Collection

**Never write another loop again**   

This library is inspired by `Laravel` collection class to use its expressive syntax.
Check the .h file to see the documentation as well as all available methods.


## Installation
Copy the category files to your project or just

```
    pod 'Collection' 
```

## Array Examples

Just some examples, check the .h or the tests to see them all


```
    NSArray* array = @[@1,@3,@4,@5,@6];
    NSNumber* first = [array first:^BOOL(NSNumber* object) {
        return object.intValue > 4;
    }];
    NSLog(@"Fist: %@",first);
```

```
    NSNumber* second = [array first:^BOOL(NSNumber* object) {
        return object.intValue > 10;
    } default:@25];
    NSLog(@"second: %@",second);
```


```
    NSArray* oldHeroes = [self.heroes reject:^BOOL(Hero *object) {
        return object.age.intValue < 20;
    }];
    [self printHeroArray:oldHeroes];
```



```
    [self printHeroArray:[self.heroes map:^id(Hero* obj, NSUInteger idx) {
        obj.age = @(obj.age.intValue * 2);
        return obj;
    }]];
    [self printArray:[self.heroes pluck:@"enemy"]];
```

```
    NSNumber* totalAge = [self.heroes reduce:^id(NSNumber* carry, Hero* object) {
        return @(object.age.intValue + carry.intValue);
    } carry:@(0)];

    or

    NSNumber* totalAge2 = [self.heroes sum:@"age"];
```

```
    NSNumber* age = [self.heroes sum:@"age"];
    NSLog(@"Age again: %@",age);

    NSNumber* older = [self.heroes max:@"age"];
    NSLog(@"older: %@",older);

    NSNumber* younger = [self.heroes min:@"age"];
    NSLog(@"younger: %@",younger);

    NSNumber* average = [self.heroes avg:@"age"];
    NSLog(@"average: %@",average);
```

```
    [self printArray:[@[@1,@2,@3,@4] union:@[@4,@5,@6]]];
    [self printArray:[@[@1,@2,@3,@4] intersect:@[@4,@5,@6]]];
    [self printArray:[@[@1,@2,@3,@4] join:@[@4,@5,@6]]];
    [self printArray:[@[@1,@2,@3,@4] diff:@[@4,@5,@6]]];
```

```
    NSArray* grouped = [self.heroes join:self.heroes];

    [grouped groupBy:@"name"];

    [grouped groupBy:@"name" block:^NSString *(Hero* object, NSString *key) {
    return str(@"-- %@",object.name);
    }];
```

```
    BOOL containsSpiderman = [self.heroes contains:^BOOL(Hero* hero) {
        return [hero.name isEqualToString:@"Spiderman"];
    }];
```


```
    [self printArray:[@[@1,@2,@3,@4,@5,@6] slice:3]];
    [self printArray:[@[@1,@2,@3,@4,@5,@6] slice:10]];
    [self printArray:[@[@1,@2,@3,@4,@5,@6] slice:6]];
    [self printArray:[@[@1,@2,@3,@4,@5,@6] take:2]];
    [self printArray:[@[@1,@2,@3,@4,@5,@6] take:10]];
    [self printArray:[@[@1,@2,@3,@4,@5,@6] take:-2]];
    [self printArray:[@[@1,@2,@3,@4,@5,@6] take:-10]];
```

```
    NSArray* array2 = @[@1,@2,@3,@4,@5].mutableCopy;
    NSArray* chunk = [array2 splice:2];
    [self printArray:chunk];
    [self printArray:array2];
```

## Dictionary Examples

Just some examples, check the .h or the tests to see them all
    
```
    NSDictionary* filtered = [@{@"pass":@0,@"dontPass":@1} filter:^BOOL(id key, id object) {
        return [object floatValue] == 0;
    }];
```

```
    NSDictionary* result = [@{@"toBeMapped":@"value",@"toBeMapped2":@"value2"} map:^id(id key, id object) {
    return [key stringByAppendingString:object];
    }];
```

## String Examples

Just some examples, check the .h or the tests to see them all

```
    NSArray* result         = [@"hola;que;tal" explode:@";"];
    NSArray* expectation    = @[@"hola",@"que",@"tal"];
    XCTAssertTrue([result isEqual:expectation]);
```

```
    NSString* result = [@"   trim   " trim];
    XCTAssertTrue( [result isEqualToString:@"trim"]);
```

```
    NSString* result = @"this should be camelcased".camelCase;
    XCTAssertTrue( [result isEqualToString:@"thisShouldBeCamelcased"]);
```
