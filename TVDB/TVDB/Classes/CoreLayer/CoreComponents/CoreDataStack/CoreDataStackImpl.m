//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "CoreDataStackImpl.h"
#import "MTLModel.h"
#import "MTLManagedObjectAdapter.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

NSString *const CoreDataStackWasUpdatedNotification = @"CoreDataStackWasUpdatedNotification";

@interface CoreDataStackImpl ()

@property (strong, nonatomic) NSPersistentContainer *persistentContainer;
@property (strong, nonatomic) NSManagedObjectContext *backgroundManagedObjectContext;

@end

@implementation CoreDataStackImpl

- (RACSignal *)fetchAllObjectsWithFetchRequest:(NSFetchRequest *)fetchRequest
{
    return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        NSAsynchronousFetchRequest *asynchronousFetchRequest = [[NSAsynchronousFetchRequest alloc] initWithFetchRequest:fetchRequest
                                                                                                        completionBlock:^(NSAsynchronousFetchResult *result) {
                                                                                                            NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:result.finalResult.count];
                                                                                                            NSArray *items = result.finalResult;
                                                                                                            for (id managedObject in items) {
                                                                                                                id <MTLManagedObjectSerializing> object = [MTLManagedObjectAdapter modelOfClass:NSClassFromString(fetchRequest.entityName)
                                                                                                                                                                              fromManagedObject:managedObject
                                                                                                                                                                                          error:nil];
                                                                                                                [mutableArray addObject:object];
                                                                                                            }
                                                                                                            [subscriber sendNext:mutableArray];
                                                                                                        }];
        [self.backgroundManagedObjectContext executeRequest:asynchronousFetchRequest error:nil];
        return nil;
    }];
}

- (RACSignal *)saveObjects:(NSArray *)objects
{
    return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        for (id <MTLManagedObjectSerializing> object in objects) {
            NSError *error;
            [self createManagedObjectModelFromMantleObject:object intoContext:self.backgroundManagedObjectContext error:&error];
            [self.backgroundManagedObjectContext save:&error];
            if (!error) {
                [subscriber sendCompleted];
                [[NSNotificationCenter defaultCenter] postNotification:CoreDataStackWasUpdatedNotification];
            } else {
                [subscriber sendError:error];
            }
        }
        return nil;
    }];
}

- (RACSignal *)saveObject:(id <MTLManagedObjectSerializing>)object
{
    return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        NSError *error;
        [self createManagedObjectModelFromMantleObject:object intoContext:self.backgroundManagedObjectContext error:&error];
        if (error) {
            [subscriber sendError:error];
        }
        [self.backgroundManagedObjectContext save:&error];
        if (!error) {
            [subscriber sendCompleted];
            [[NSNotificationCenter defaultCenter] postNotification:CoreDataStackWasUpdatedNotification];
        } else {
            [subscriber sendError:error];
        }
        return nil;
    }];
}

- (RACSignal *)deleteObjects:(NSArray *)objects
{
    return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        for (id object in objects) {
            [self deleteObject:object];
        }
        [subscriber sendCompleted];
        return nil;
    }];
}

- (RACSignal *)deleteObject:(NSManagedObject *)object
{
    return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        NSError *error;

        [self.backgroundManagedObjectContext save:&error];
        if (!error) {
            [subscriber sendCompleted];
            [[NSNotificationCenter defaultCenter] postNotification:CoreDataStackWasUpdatedNotification];
        } else {
            [subscriber sendError:error];
        }
        return nil;
    }];
}

- (id)createManagedObjectModelFromMantleObject:(id <MTLManagedObjectSerializing>)object intoContext:(NSManagedObjectContext *)intoContext error:(NSError **)error
{
    return [MTLManagedObjectAdapter managedObjectFromModel:object
                                      insertingIntoContext:intoContext
                                                     error:error];
}

#pragma mark - Getters

- (NSPersistentContainer *)persistentContainer
{
    if (!_persistentContainer) {
        _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"TVDB"];
        [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *description, NSError *error) {
            NSLog(@"");
        }];
    }
    return _persistentContainer;
}

- (NSManagedObjectContext *)backgroundManagedObjectContext
{
    if (!_backgroundManagedObjectContext) {
        _backgroundManagedObjectContext = self.persistentContainer.newBackgroundContext;
    }
    return _backgroundManagedObjectContext;
}


@end