//
// Created by Igor Vasilenko on 02/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetworkClient;
@protocol CoreDataStack;

@protocol CoreComponentsFactory <NSObject>

- (id <NetworkClient>)networkClient;
- (id <CoreDataStack>)coreDataStack;

@end