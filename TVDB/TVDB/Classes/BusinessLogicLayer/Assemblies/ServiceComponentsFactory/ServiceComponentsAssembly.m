//
// Created by Igor Vasilenko on 02/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Typhoon/TyphoonDefinition+Config.h>
#import <UICKeyChainStore/UICKeyChainStore.h>
#import <Typhoon/TyphoonConfigPostProcessor.h>
#import "ServiceComponentsAssembly.h"
#import "CoreComponentsFactory.h"
#import "AuthenticationServiceImpl.h"

static NSString *const kServiceComponentsResourceFile = @"ServiceComponentsResource.plist";
static NSString *const kServiceComponentsKeychainService = @"TheMovieDB";

@implementation ServiceComponentsAssembly

- (id <AuthenticationService>)authenticationService
{
    return [TyphoonDefinition withClass:[AuthenticationServiceImpl class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithNetworkClient:keychainStore:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self.coreComponents networkClient]];
            [initializer injectParameterWith:[self keychainStore]];
        }];
    }];
}

#pragma mark - Private services

- (UICKeyChainStore *)keychainStore
{
    return [TyphoonDefinition withClass:[UICKeyChainStore class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(keyChainStoreWithService:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:TyphoonConfig(kServiceComponentsKeychainService)];
        }];
    }];
}

#pragma mark - Config

- (id)config
{
    return [TyphoonDefinition withConfigName:kServiceComponentsResourceFile];
}

@end