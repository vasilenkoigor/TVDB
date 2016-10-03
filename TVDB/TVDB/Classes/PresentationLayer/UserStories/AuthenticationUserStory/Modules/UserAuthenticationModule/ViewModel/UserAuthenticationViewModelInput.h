//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACCommand;
@class RACSignal;

@protocol UserAuthenticationViewModelInput <NSObject>

@property (copy, nonatomic, readonly) NSString *loginTextFieldText;
@property (copy, nonatomic, readonly) NSString *passwordTextFieldText;

@property (assign, nonatomic, readonly) BOOL isAuthenticated;
@property (strong, nonatomic, readonly) RACCommand *signInButtonCommand;
@property (strong, nonatomic, readonly) RACSignal *authenticationProcessSignal;

- (void)closeAuthentication;

@end