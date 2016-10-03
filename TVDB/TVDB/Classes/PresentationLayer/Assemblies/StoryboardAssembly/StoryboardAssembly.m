//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "StoryboardAssembly.h"
#import "TyphoonStoryboard.h"

static NSString *const kAuthenticationUserStoryStoryboardName = @"AuthenticationUserStoryStoryboard";
static NSString *const kSerialsDiscoverUserStoryStoryboardName = @"TVShowsDiscoverUserStoryStoryboard";

@implementation StoryboardAssembly

- (TyphoonStoryboard *)authenticationUserStoryStoryboard
{
    return [TyphoonDefinition withClass:[TyphoonStoryboard class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(storyboardWithName:factory:bundle:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:kAuthenticationUserStoryStoryboardName];
                                                  [initializer injectParameterWith:self];
                                                  [initializer injectParameterWith:[NSBundle mainBundle]];
                                              }];
                          }];
}

- (TyphoonStoryboard *)tvShowsDiscoverUserStoryStoryboard
{
    return [TyphoonDefinition withClass:[TyphoonStoryboard class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition useInitializer:@selector(storyboardWithName:factory:bundle:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:kSerialsDiscoverUserStoryStoryboardName];
                                                  [initializer injectParameterWith:self];
                                                  [initializer injectParameterWith:[NSBundle mainBundle]];
                                              }];
                          }];
}


@end