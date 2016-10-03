//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <UICKeyChainStore/UICKeyChainStore.h>
#import "KeychainServiceImpl.h"

NSString *const kTokenKeychainServiceKey = @"keychain_token_the_movie_db";
NSString *const kSessionKeychainServiceKey = @"keychain_session_the_movie_db";
NSString *const kIsAuthenticatedKeychainServiceKey = @"is_authenticated_the_movie_db";

@interface KeychainServiceImpl ()

@property (strong, nonatomic, readwrite) UICKeyChainStore *keyChainStore;

@end

@implementation KeychainServiceImpl

- (instancetype)initWithKeychainStore:(UICKeyChainStore *)keyChainStore
{
    self = [super init];
    if (self) {
        self.keyChainStore = keyChainStore;
    }
    return self;
}

- (void)saveToken:(TokenModel *)tokenModel session:(SessionModel *)sessionModel
{
    NSData *tokenData = [NSKeyedArchiver archivedDataWithRootObject:tokenModel];
    [self.keyChainStore setData:tokenData forKey:kTokenKeychainServiceKey];

    NSData *sessionData = [NSKeyedArchiver archivedDataWithRootObject:sessionModel];
    [self.keyChainStore setData:sessionData forKey:kSessionKeychainServiceKey];
}

- (BOOL)isAuthenticated
{
    NSData *authenticatedData = [self.keyChainStore dataForKey:kIsAuthenticatedKeychainServiceKey];
    if (authenticatedData) {
        NSNumber *authenticated = [NSKeyedUnarchiver unarchiveObjectWithData:authenticatedData];
        return authenticated.boolValue;
    }

    return NO;
}

- (void)setAuthenticated:(BOOL)authenticated
{
    NSData *authenticatedData = [NSKeyedArchiver archivedDataWithRootObject:@(authenticated)];
    [self.keyChainStore setData:authenticatedData forKey:kIsAuthenticatedKeychainServiceKey];
}

- (TokenModel *)requestToken
{
    NSData *tokenData = [self.keyChainStore dataForKey:kTokenKeychainServiceKey];
    if (tokenData) {
        TokenModel *tokenModel = [NSKeyedUnarchiver unarchiveObjectWithData:tokenData];
        return tokenModel;
    } else {
        return nil;
    }
}

- (SessionModel *)requestSession
{
    NSData *sessionData = [self.keyChainStore dataForKey:kSessionKeychainServiceKey];
    if (sessionData) {
        SessionModel *sessionModel = [NSKeyedUnarchiver unarchiveObjectWithData:sessionData];
        return sessionModel;
    } else {
        return nil;
    }
}

@end