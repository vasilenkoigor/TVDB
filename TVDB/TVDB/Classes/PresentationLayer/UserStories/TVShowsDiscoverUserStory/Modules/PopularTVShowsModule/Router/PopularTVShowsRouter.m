//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "PopularTVShowsRouter.h"
#import "RamblerViperModuleTransitionHandlerProtocol.h"
#import "SegueIdentifiersConstants.h"
#import "RamblerViperOpenModulePromise.h"
#import "DiscoverTVShowModuleInput.h"

@implementation PopularTVShowsRouter

- (void)openDiscoverTVShowWithTVShow:(TVShow *)tvShow
{
    [[self.transitionHandler openModuleUsingSegue:kDiscoverTVShowSegueID] thenChainUsingBlock:^id <RamblerViperModuleOutput>(id <DiscoverTVShowModuleInput> moduleInput) {
        [moduleInput configureDiscoverTVShowModuleWithTVShow:tvShow];
        return nil;
    }];
}

- (void)closeCurrentModule
{
    [self.transitionHandler closeCurrentModule:YES];
}

@end