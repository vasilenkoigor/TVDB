//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "UserAuthenticationViewModel.h"
#import "UserAuthenticationRouterInput.h"
#import "AuthenticationService.h"
#import "KeychainService.h"

@interface UserAuthenticationViewModel ()

@property (strong, nonatomic, readwrite) id <UserAuthenticationRouterInput> router;
@property (strong, nonatomic, readwrite) id <AuthenticationService> authenticationService;
@property (strong, nonatomic, readwrite) id <KeychainService> keychainService;

@property (copy, nonatomic) NSString *loginTextFieldText;
@property (copy, nonatomic) NSString *passwordTextFieldText;

@property (assign, nonatomic) BOOL isAuthenticated;
@property (strong, nonatomic) RACCommand *signInButtonCommand;
@property (strong, nonatomic) RACSignal *signInButtonEnabledSignal;
@property (strong, nonatomic) RACSignal *authenticationProcessSignal;
@property (strong, nonatomic) RACSubject *authenticationProcessSubject;

@end

@implementation UserAuthenticationViewModel

- (void)typhoonDidInject
{
    [self.keychainService deleteAuthenticationData];

    self.authenticationProcessSubject = [RACSubject subject];
    self.isAuthenticated = self.keychainService.isAuthenticated;
    self.signInButtonEnabledSignal = [RACSignal combineLatest:@[RACObserve(self, loginTextFieldText), RACObserve(self, passwordTextFieldText)] reduce:^id(NSString *login, NSString *password) {
        return @((login.length > 0) & (password.length > 0));
    }];
}

#pragma mark - Getters

- (RACCommand *)signInButtonCommand
{
    if (!_signInButtonCommand) {
        _signInButtonCommand = [[RACCommand alloc] initWithEnabled:self.signInButtonEnabledSignal signalBlock:^RACSignal *(id input) {
            return [[[[self.authenticationService rac_startAuthenticationWithUserName:self.loginTextFieldText
                                                                            password:self.passwordTextFieldText] initially:^{
                [self.authenticationProcessSubject sendNext:@(YES)];
            }] doNext:^(id x) {
                [self.authenticationProcessSubject sendNext:@(NO)];
                [self.router openDiscoverSerialsUserStory];
            }] doError:^(NSError *error) {
                [self.authenticationProcessSubject sendError:error];
            }];
        }];
    }
    return _signInButtonCommand;
}

- (RACSignal *)authenticationProcessSignal
{
    if (!_authenticationProcessSignal) {
        _authenticationProcessSignal = self.authenticationProcessSubject;
    }
    return _authenticationProcessSignal;
}

#pragma mark - Navigation

- (void)closeAuthentication
{
    [self.router openDiscoverSerialsUserStory];
}

@end