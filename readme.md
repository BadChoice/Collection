```
    _pageButton.states = @[
                            @"state 1",
                            @"state 2",
                            @"state 3",
                            @"state 4",
    ];
    _pageButton.delegate = theDelegate;
```

or 

```
    [_pageButton setStates:@[@"state 1",@"state 2",@"state 3"] 
        changed:^(int page) {
            NSLog(@"block Page changed");
        }
    ];
```
