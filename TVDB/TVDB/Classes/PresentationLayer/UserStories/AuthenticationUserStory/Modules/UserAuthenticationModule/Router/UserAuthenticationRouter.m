//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "UserAuthenticationRouter.h"
#import "SegueIdentifiersConstants.h"

#import <ViperMcFlurry/RamblerViperModuleTransitionHandlerProtocol.h>

@implementation UserAuthenticationRouter

- (void)openDiscoverSerialsUserStory
{
    [self.transitionHandler openModuleUsingSegue:kTVShowsDiscoverUserStorySegueID];
}

@end