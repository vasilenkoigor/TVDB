//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TokenModel;
@class SessionModel;
@class Account;

@protocol KeychainService <NSObject>

@property (assign, nonatomic, getter=isAuthenticated) BOOL authenticated;

- (void)saveToken:(TokenModel *)tokenModel session:(SessionModel *)sessionModel;
- (void)saveAccount:(Account *)account;
- (void)deleteAuthenticationData;

- (Account *)requestAccount;
- (TokenModel *)requestToken;
- (SessionModel *)requestSession;

@end