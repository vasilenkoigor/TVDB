//
// Created by Igor Vasilenko on 04/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "FavoritesTVShowsService.h"

@protocol NetworkClient;
@protocol CoreDataStack;
@protocol KeychainService;

@interface FavoritesTVShowsServiceImpl : NSObject <FavoritesTVShowsService>

@property (strong, nonatomic, readonly) id <NetworkClient> networkClient;
@property (strong, nonatomic, readonly) id <CoreDataStack> coreDataStack;
@property (strong, nonatomic, readonly) id <KeychainService> keychainService;

- (instancetype)initWithNetworkClient:(id <NetworkClient>)networkClient
                        coreDataStack:(id <CoreDataStack>)coreDataStack
                      keychainService:(id <KeychainService>)keychainService;

@end