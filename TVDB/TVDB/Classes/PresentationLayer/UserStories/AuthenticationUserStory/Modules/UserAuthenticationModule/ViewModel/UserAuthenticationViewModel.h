//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "UserAuthenticationViewModelInput.h"

@protocol UserAuthenticationRouterInput;
@protocol AuthenticationService;
@protocol KeychainService;

@interface UserAuthenticationViewModel : NSObject <UserAuthenticationViewModelInput>

@property (strong, nonatomic, readonly) id <UserAuthenticationRouterInput> router;
@property (strong, nonatomic, readonly) id <AuthenticationService> authenticationService;
@property (strong, nonatomic, readonly) id <KeychainService> keychainService;

@end