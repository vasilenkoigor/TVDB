//
// Created by Igor Vasilenko on 04/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "DiscoverTVShowAssembly.h"
#import "DiscoverTVShowViewController.h"
#import "DiscoverTVShowRouterInput.h"
#import "ServiceComponentsFactory.h"
#import "DiscoverTVShowViewModel.h"
#import "CellObjectsBuildersAssembly.h"
#import "DiscoverTVShowRouter.h"
#import "DiscoverTVShowDataDisplayManager.h"

@implementation DiscoverTVShowAssembly

- (DiscoverTVShowViewController *)discoverTVShowView
{
    return [TyphoonDefinition withClass:[DiscoverTVShowViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(output) with:[self discoverTVShowViewModel]];
        [definition injectProperty:@selector(discoverTVShowDataDisplayManager) with:[self discoverTVShowDataDisplayManager]];
    }];
}

- (DiscoverTVShowDataDisplayManager *)discoverTVShowDataDisplayManager
{
    return [TyphoonDefinition withClass:[DiscoverTVShowDataDisplayManager class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(discoverTVShowCellObjectsBuilder) with:[self.cellObjectsBuildersAssembly discoverTVShowCellObjectsBuilder]];
    }];
}

- (id <DiscoverTVShowViewModelInput>)discoverTVShowViewModel
{
    return [TyphoonDefinition withClass:[DiscoverTVShowViewModel class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(tvShowsService) with:[self.serviceComponents tvShowsService]];
        [definition injectProperty:@selector(favoritesTVShowsService) with:[self.serviceComponents favoritesTVShowsService]];
        [definition injectProperty:@selector(router) with:[self discoverTVShowRouter]];
    }];
}

- (id <DiscoverTVShowRouterInput>)discoverTVShowRouter
{
    return [TyphoonDefinition withClass:[DiscoverTVShowRouter class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(transitionHandler) with:[self discoverTVShowView]];
    }];
}

@end