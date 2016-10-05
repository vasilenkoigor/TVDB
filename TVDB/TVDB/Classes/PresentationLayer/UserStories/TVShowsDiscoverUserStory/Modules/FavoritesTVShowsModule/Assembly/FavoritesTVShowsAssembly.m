//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "FavoritesTVShowsAssembly.h"
#import "CellObjectsBuildersAssembly.h"
#import "FavoritesTVShowsViewModelInput.h"
#import "FavoritesTVShowsRouterInput.h"
#import "TVShowsDataDisplayManager.h"
#import "FavoritesTVShowsViewController.h"
#import "FavoritesTVShowsViewModel.h"
#import "ServiceComponentsFactory.h"
#import "FavoritesTVShowsRouter.h"

@implementation FavoritesTVShowsAssembly

- (FavoritesTVShowsViewController *)favoritesTVShowsView
{
    return [TyphoonDefinition withClass:[FavoritesTVShowsViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(output) with:[self favoritesTVShowsViewModel]];
        [definition injectProperty:@selector(dataDisplayManager) with:[self favoritesTVShowsDataDisplayManager]];
    }];
}

- (TVShowsDataDisplayManager *)favoritesTVShowsDataDisplayManager
{
    return [TyphoonDefinition withClass:[TVShowsDataDisplayManager class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(cellObjectsBuilder) with:[self.cellObjectsBuildersAssembly tVShowCellObjectsBuilder]];
    }];
}

- (id <FavoritesTVShowsViewModelInput>)favoritesTVShowsViewModel
{
    return [TyphoonDefinition withClass:[FavoritesTVShowsViewModel class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(router) with:[self favoritesTVShowsRouter]];
        [definition injectProperty:@selector(favoritesTVShowsService) with:[self.serviceComponents favoritesTVShowsService]];
    }];
}

- (id <FavoritesTVShowsRouterInput>)favoritesTVShowsRouter
{
    return [TyphoonDefinition withClass:[FavoritesTVShowsRouter class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(transitionHandler) with:[self favoritesTVShowsView]];
    }];
}

@end