//
// Created by Igor Vasilenko on 04/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <ViperMcFlurry/RamblerViperOpenModulePromise.h>
#import "DiscoverTVShowRouter.h"
#import "RamblerViperModuleTransitionHandlerProtocol.h"
#import "SegueIdentifiersConstants.h"
#import "DiscoverTVEpisodesModuleInput.h"


@implementation DiscoverTVShowRouter

- (void)openDiscoverEpisodesModuleWithTVSeason:(TVSeason *)tvSeason
{
    [[self.transitionHandler openModuleUsingSegue:kDicoverEpisodesSegueID] thenChainUsingBlock:^id <RamblerViperModuleOutput>(id <DiscoverTVEpisodesModuleInput> moduleInput) {
        [moduleInput configureModuleWithTVSeason:tvSeason];
        return nil;
    }];
}

@end