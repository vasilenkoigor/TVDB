//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "TVShowsService.h"

@protocol NetworkClient;
@protocol KeychainService;
@protocol CoreDataStack;

@interface TVShowsServiceImpl : NSObject <TVShowsService>

@property (strong, nonatomic, readonly) id <NetworkClient> networkClient;
@property (strong, nonatomic, readonly) id <KeychainService> keychainService;
@property (strong, nonatomic, readonly) id <CoreDataStack> coreDataStack;

- (instancetype)initWithNetworkClient:(id <NetworkClient>)networkClient
                      keychainService:(id <KeychainService>)keychainService
                        coreDataStack:(id <CoreDataStack>)coreDataStack;

@end