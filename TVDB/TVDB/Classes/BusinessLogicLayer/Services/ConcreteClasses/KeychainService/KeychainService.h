//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TokenModel;
@class SessionModel;

@protocol KeychainService <NSObject>

@property (assign, nonatomic, getter=isAuthenticated) BOOL authenticated;

- (void)saveToken:(TokenModel *)tokenModel session:(SessionModel *)sessionModel;
- (TokenModel *)requestToken;
- (SessionModel *)requestSession;

@end