//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Typhoon/TyphoonDefinition.h>
#import "PopularTVShowsAssembly.h"
#import "PopularTVShowsViewController.h"
#import "PopularTVShowsViewModel.h"
#import "PopularTVShowsRouter.h"
#import "ServiceComponentsFactory.h"
#import "CellObjectsBuildersAssembly.h"

@implementation PopularTVShowsAssembly

- (PopularTVShowsViewController *)popularTVShowsView
{
    return [TyphoonDefinition withClass:[PopularTVShowsViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(output) with:[self popularTVShowsViewModel]];
        [definition injectProperty:@selector(dataDisplayManager) with:[self dataDisplayManager]];
    }];
}

- (TVShowsDataDisplayManager *)dataDisplayManager
{
    return [TyphoonDefinition withClass:[TVShowsDataDisplayManager class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(cellObjectsBuilder) with:[self.cellObjectsBuildersAssembly tVShowCellObjectsBuilder]];
    }];
}

- (id <PopularTVShowsViewModelInput>)popularTVShowsViewModel
{
    return [TyphoonDefinition withClass:[PopularTVShowsViewModel class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(router) with:[self popularTVShowsRouter]];
        [definition injectProperty:@selector(keychainService) with:[self.serviceComponents keychainService]];
        [definition injectProperty:@selector(tvShowsService) with:[self.serviceComponents tvShowsService]];
    }];
}

- (id <PopularTVShowsRouterInput>)popularTVShowsRouter
{
    return [TyphoonDefinition withClass:[PopularTVShowsRouter class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(transitionHandler) with:[self popularTVShowsView]];
    }];
}

@end