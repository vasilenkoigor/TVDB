//
// Created by Igor Vasilenko on 02/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "AuthenticationServiceImpl.h"
#import "NetworkClient.h"
#import "TokenModel.h"
#import "SessionModel.h"
#import "СoreLayerConstants.h"
#import "KeychainService.h"
#import "Account.h"

static NSString *const kRequestTokenURLAPIPath = @"authentication/token/new";
static NSString *const kValidateRequestTokenURLAPIPath = @"authentication/token/validate_with_login";
static NSString *const kCreateSessionURLAPIPath = @"authentication/session/new";
static NSString *const kAccountURLAPIPath = @"account";

@interface AuthenticationServiceImpl ()

@property (strong, nonatomic, readwrite) id <NetworkClient> networkClient;
@property (strong, nonatomic, readwrite) id <KeychainService> keychainService;

@end

@implementation AuthenticationServiceImpl

- (instancetype)initWithNetworkClient:(id <NetworkClient>)networkClient
                      keychainService:(id <KeychainService>)keychainService
{
    self = [super init];
    if (self) {
        self.networkClient = networkClient;
        self.keychainService = keychainService;
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
            return [[self rac_requestAccountDetailsWithSession:sessionModel] flattenMap:^RACStream *(Account *account) {
                if (sessionModel.success) {
                    [self.keychainService saveToken:tokenModel session:sessionModel];
                    [self.keychainService saveAccount:account];
                    [self.keychainService setAuthenticated:YES];
                    return [RACSignal return:@(YES)];
                } else {
                    return [RACSignal return:@(NO)];
                }
            }];
        }];
    }];
}

#pragma mark - Private

- (RACSignal *)rac_createRequestToken
{
    return [self.networkClient rac_method:HTTPMethodGET
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
    return [self.networkClient rac_method:HTTPMethodGET
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
    return [self.networkClient rac_method:HTTPMethodGET
                                URLString:kCreateSessionURLAPIPath
                               parameters:
                                       @{
                                               @"api_key" : kTheMovieDBAPIKey,
                                               @"request_token" : tokenModel.requestToken
                                       }
                              resultClass:[SessionModel class]
                                   forKey:nil];
}

- (RACSignal *)rac_requestAccountDetailsWithSession:(SessionModel *)sessionModel
{
    return [self.networkClient rac_method:HTTPMethodGET
                                URLString:kAccountURLAPIPath
                               parameters:
                                       @{
                                               @"api_key" : kTheMovieDBAPIKey,
                                               @"session_id" : sessionModel.uid
                                       }
                              resultClass:[Account class]
                                   forKey:nil];
}

@end