//
// Created by Igor Vasilenko on 02/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <UICKeyChainStore/UICKeyChainStore.h>
#import "AuthenticationServiceImpl.h"
#import "NetworkClient.h"
#import "TokenModel.h"
#import "SessionModel.h"
#import "StringConstants.h"

static NSString *const kRequestTokenURLAPIPath = @"authentication/token/new";
static NSString *const kValidateRequestTokenURLAPIPath = @"authentication/token/validate_with_login";
static NSString *const kCreateSessionURLAPIPath = @"authentication/session/new";

@interface AuthenticationServiceImpl ()

@property (strong, nonatomic, readwrite) id <NetworkClient> networkClient;
@property (strong, nonatomic, readwrite) UICKeyChainStore *keyChainStore;

@end

@implementation AuthenticationServiceImpl

- (instancetype)initWithNetworkClient:(id <NetworkClient>)networkClient
                        keychainStore:(UICKeyChainStore *)keyChainStore
{
    self = [super init];
    if (self) {
        self.networkClient = networkClient;
        self.keyChainStore = keyChainStore;
    }
    return self;
}

#pragma mark - AuthenticationService protocol

- (RACSignal *)rac_startAuthenticationWithUserName:(NSString *)userName
                                          password:(NSString *)password
{
    return [[self rac_createRequestToken] flattenMap:^RACStream *(TokenModel *tokenModel) {
        return [[[self rac_validateRequestToken:tokenModel
                                       userName:userName
                                       password:password] flattenMap:^RACStream *(TokenModel *validatedToken) {
            return [self rac_createSessionWithValidatedToken:validatedToken];
        }] flattenMap:^RACStream *(SessionModel *sessionModel) {
            if (sessionModel.success) {
                [self saveAuthenticationToKeychainServiceWithToken:tokenModel session:sessionModel];
                return [RACSignal return:@(YES)];
            } else {
                return [RACSignal return:@(NO)];
            }
        }];
    }];
}

#pragma mark - Private

- (void)saveAuthenticationToKeychainServiceWithToken:(TokenModel *)tokenModel session:(SessionModel *)sessionModel
{
    NSData *tokenData = [NSKeyedArchiver archivedDataWithRootObject:tokenModel];
    [self.keyChainStore setData:tokenData forKey:kTokenKeychainKey];

    NSData *sessionData = [NSKeyedArchiver archivedDataWithRootObject:sessionModel];
    [self.keyChainStore setData:sessionData forKey:kSessionKeychainKey];
}

- (RACSignal *)rac_createRequestToken
{
    return [self.networkClient rac_method:VASHTTPMethodGET
                                URLString:kRequestTokenURLAPIPath
                               parameters:
                                       @{
                                               @"api_key" : kTheMovieDBAPIKey
                                       }
                              resultClass:[TokenModel class]
                                   forKey:nil];
}

- (RACSignal *)rac_validateRequestToken:(TokenModel *)tokenModel
                               userName:(NSString *)userName
                               password:(NSString *)password
{
    return [self.networkClient rac_method:VASHTTPMethodGET
                                URLString:kValidateRequestTokenURLAPIPath
                               parameters:
                                       @{
                                               @"api_key" : kTheMovieDBAPIKey,
                                               @"username" : userName,
                                               @"password" : password,
                                               @"request_token" : tokenModel.requestToken,
                                       }
                              resultClass:[TokenModel class]
                                   forKey:nil];
}

- (RACSignal *)rac_createSessionWithValidatedToken:(TokenModel *)tokenModel
{
    return [self.networkClient rac_method:VASHTTPMethodGET
                                URLString:kCreateSessionURLAPIPath
                               parameters:
                                       @{
                                               @"api_key" : kTheMovieDBAPIKey,
                                               @"request_token" : tokenModel.requestToken
                                       }
                              resultClass:[SessionModel class]
                                   forKey:nil];
}

@end