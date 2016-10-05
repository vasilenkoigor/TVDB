//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MTLManagedObjectSerializing;
@class NSFetchRequest;
@class RACSignal;
@class NSManagedObject;

extern NSString *const CoreDataStackWasUpdatedNotification;

@protocol CoreDataStack <NSObject>

#pragma mark - Fetch

- (RACSignal *)fetchAllObjectsWithFetchRequest:(NSFetchRequest *)fetchRequest;

#pragma mark - Save

- (RACSignal *)saveObjects:(NSArray *)objects;
- (RACSignal *)saveObject:(id <MTLManagedObjectSerializing>)object;

#pragma mark - Deleting

- (RACSignal *)deleteObject:(NSManagedObject *)object;
- (RACSignal *)deleteObjects:(NSArray *)objects;

@end