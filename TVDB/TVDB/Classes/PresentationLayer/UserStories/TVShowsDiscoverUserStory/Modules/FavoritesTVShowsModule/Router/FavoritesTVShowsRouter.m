//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <ViperMcFlurry/RamblerViperModuleOutput.h>
#import "FavoritesTVShowsRouter.h"
#import "RamblerViperModuleTransitionHandlerProtocol.h"
#import "SegueIdentifiersConstants.h"
#import "DiscoverTVShowModuleInput.h"


@implementation FavoritesTVShowsRouter

- (void)openDiscoverTVShowWithTVShow:(TVShow *)tvShow
{
    [[self.transitionHandler openModuleUsingSegue:kDiscoverTVShowSegueID] thenChainUsingBlock:^id <RamblerViperModuleOutput>(id <DiscoverTVShowModuleInput> moduleInput) {
        [moduleInput configureDiscoverTVShowModuleWithTVShow:tvShow];
        return nil;
    }];
}

@end