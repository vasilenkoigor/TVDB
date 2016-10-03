//
// Created by Igor Vasilenko on 02/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Typhoon/TyphoonDefinition+Config.h>
#import <Typhoon/TyphoonConfigPostProcessor.h>
#import "CoreComponentsAssembly.h"
#import "NetworkClientImpl.h"
#import "NetworkClientResponseSerializerImpl.h"
#import "CoreDataStack.h"
#import "CoreDataStackImpl.h"

static NSString *const kCoreComponentsResourceFile = @"CoreComponentsResource.plist";
static NSString *const kCoreComponentsRootURL = @"RootURL";

@implementation CoreComponentsAssembly

#pragma mark - CoreComponentsFactory

- (id <NetworkClient>)networkClient
{
    return [TyphoonDefinition withClass:[NetworkClientImpl class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithBaseURL:sessionConfiguration:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:TyphoonConfig(kCoreComponentsRootURL)];
            [initializer injectParameterWith:[self defaultSessionConfiguration]];
        }];
        [definition injectProperty:@selector(networkClientResponseSerializer) with:[self networkClientResponseSerializer]];
    }];
}

- (id <CoreDataStack>)coreDataStack
{
    return [TyphoonDefinition withClass:[CoreDataStackImpl class] configuration:^(TyphoonDefinition *definition) {
        definition.scope = TyphoonScopeSingleton;
    }];
}

#pragma mark - Private

- (id <NetworkClientResponseSerializer>)networkClientResponseSerializer
{
    return [TyphoonDefinition withClass:[NetworkClientResponseSerializerImpl class]];
}

- (NSURLSessionConfiguration *)defaultSessionConfiguration
{
    return [TyphoonDefinition withClass:[NSURLSessionConfiguration class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(defaultSessionConfiguration)];
    }];
}

#pragma mark - Config

- (id)config
{
    return [TyphoonDefinition withConfigName:kCoreComponentsResourceFile];
}

@end