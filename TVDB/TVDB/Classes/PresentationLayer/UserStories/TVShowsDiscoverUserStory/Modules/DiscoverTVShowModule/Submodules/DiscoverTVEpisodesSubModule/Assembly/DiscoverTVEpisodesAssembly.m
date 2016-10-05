//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "DiscoverTVEpisodesAssembly.h"
#import "DiscoverTVEpisodesViewController.h"
#import "DiscoverTVEpisodesDataDisplayManager.h"
#import "DiscoverTVEpisodesViewModel.h"
#import "DiscoverTVEpisodesRouterInput.h"
#import "CellObjectsBuildersAssembly.h"
#import "DiscoverTVEpisodesRouter.h"


@implementation DiscoverTVEpisodesAssembly

- (DiscoverTVEpisodesViewController *)discoverTVEpisodesView
{
    return [TyphoonDefinition withClass:[DiscoverTVEpisodesViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(output) with:[self discoverTVEpisodesViewModel]];
        [definition injectProperty:@selector(discoverTVEpisodesDataDisplayManager) with:[self discoverTVEpisodesDataDisplayManager]];
    }];
}

- (DiscoverTVEpisodesDataDisplayManager *)discoverTVEpisodesDataDisplayManager
{
    return [TyphoonDefinition withClass:[DiscoverTVEpisodesDataDisplayManager class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(tvEpisodeCellObjectsBuilder) with:[self.cellObjectsBuildersAssembly tvEpisodeCellObjectsBuilder]];
    }];
}

- (id <DiscoverTVEpisodesViewModelInput>)discoverTVEpisodesViewModel
{
    return [TyphoonDefinition withClass:[DiscoverTVEpisodesViewModel class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(router) with:[self discoverTVEpisodesShowRouter]];
    }];
}

- (id <DiscoverTVEpisodesRouterInput>)discoverTVEpisodesShowRouter
{
    return [TyphoonDefinition withClass:[DiscoverTVEpisodesRouter class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(transitionHandler) with:[self discoverTVEpisodesView]];
    }];
}

@end