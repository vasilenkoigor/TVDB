//
// Created by Igor Vasilenko on 02/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "AuthenticationService.h"

@protocol NetworkClient;
@protocol KeychainService;

@interface AuthenticationServiceImpl : NSObject <AuthenticationService>

@property (strong, nonatomic, readonly) id <NetworkClient> networkClient;
@property (strong, nonatomic, readonly) id <KeychainService> keychainService;

- (instancetype)initWithNetworkClient:(id <NetworkClient>)networkClient
                      keychainService:(id <KeychainService>)keychainService;

@end