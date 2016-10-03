//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "TVShowsServiceImpl.h"
#import "NetworkClient.h"
#import "KeychainService.h"
#import "CoreDataStack.h"

@interface TVShowsServiceImpl ()

@property (strong, nonatomic, readwrite) id <NetworkClient> networkClient;
@property (strong, nonatomic, readwrite) id <KeychainService> keychainService;
@property (strong, nonatomic, readwrite) id <CoreDataStack> coreDataStack;

@end

@implementation TVShowsServiceImpl

- (instancetype)initWithNetworkClient:(id <NetworkClient>)networkClient
                      keychainService:(id <KeychainService>)keychainService
                        coreDataStack:(id <CoreDataStack>)coreDataStack
{
    self = [super init];
    if (self) {
        self.networkClient = networkClient;
        self.keychainService = keychainService;
        self.coreDataStack = coreDataStack;
    }
    return self;
}

@end