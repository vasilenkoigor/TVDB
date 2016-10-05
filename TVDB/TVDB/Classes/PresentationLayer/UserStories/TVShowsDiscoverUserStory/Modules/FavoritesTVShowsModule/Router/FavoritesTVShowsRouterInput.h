//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TVShow;

@protocol FavoritesTVShowsRouterInput <NSObject>

- (void)openDiscoverTVShowWithTVShow:(TVShow *)tvShow;

@end