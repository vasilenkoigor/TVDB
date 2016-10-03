//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Typhoon/TyphoonStoryboard.h>
#import "StoryboardAssembly.h"

static NSString *const kAuthenticationUserStoryStoryboardName = @"AuthenticationUserStoryStoryboard";

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


@end