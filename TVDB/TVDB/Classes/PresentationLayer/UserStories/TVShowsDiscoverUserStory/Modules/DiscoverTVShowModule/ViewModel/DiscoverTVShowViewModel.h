//
// Created by Igor Vasilenko on 04/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "DiscoverTVShowModuleInput.h"
#import "DiscoverTVShowViewModelInput.h"

@protocol DiscoverTVShowRouterInput;
@protocol TVShowsService;
@protocol CoreDataStack;
@protocol FavoritesTVShowsService;

@interface DiscoverTVShowViewModel : NSObject <DiscoverTVShowModuleInput, DiscoverTVShowViewModelInput>

@property (strong, nonatomic, readonly) id <DiscoverTVShowRouterInput> router;
@property (strong, nonatomic, readonly) id <TVShowsService> tvShowsService;
@property (strong, nonatomic, readonly) id <FavoritesTVShowsService> favoritesTVShowsService;

@end