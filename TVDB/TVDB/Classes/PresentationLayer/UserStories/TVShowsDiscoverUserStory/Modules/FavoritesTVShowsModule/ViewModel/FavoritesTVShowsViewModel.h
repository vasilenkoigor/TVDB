//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "FavoritesTVShowsViewModelInput.h"

@protocol FavoritesTVShowsService;
@protocol FavoritesTVShowsRouterInput;

@interface FavoritesTVShowsViewModel : NSObject <FavoritesTVShowsViewModelInput>

@property (strong, nonatomic, readonly) id <FavoritesTVShowsRouterInput> router;
@property (strong, nonatomic, readonly) id <FavoritesTVShowsService> favoritesTVShowsService;

@end