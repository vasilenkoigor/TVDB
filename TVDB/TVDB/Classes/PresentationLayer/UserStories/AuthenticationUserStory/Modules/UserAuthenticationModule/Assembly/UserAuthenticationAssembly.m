//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "UserAuthenticationAssembly.h"
#import "UserAuthenticationViewController.h"
#import "UserAuthenticationViewModelInput.h"
#import "UserAuthenticationRouterInput.h"
#import "UserAuthenticationViewModel.h"
#import "ServiceComponentsFactory.h"
#import "UserAuthenticationRouter.h"

@implementation UserAuthenticationAssembly

- (UserAuthenticationViewController *)userAuthenticationView
{
    return [TyphoonDefinition withClass:[UserAuthenticationViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(viewModel) with:[self userAuthenticationViewModel]];
    }];
}

- (id <UserAuthenticationViewModelInput>)userAuthenticationViewModel
{
    return [TyphoonDefinition withClass:[UserAuthenticationViewModel class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(authenticationService) with:[self.serviceComponents authenticationService]];
        [definition injectProperty:@selector(router) with:[self userAuthenticationRouter]];
        [definition injectProperty:@selector(keychainService) with:[self.serviceComponents keychainService]];
    }];
}

- (id <UserAuthenticationRouterInput>)userAuthenticationRouter
{
    return [TyphoonDefinition withClass:[UserAuthenticationRouter class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(transitionHandler) with:[self userAuthenticationView]];
    }];
}

@end