//
// Created by Igor Vasilenko on 04/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;
@class TVShow;

@protocol FavoritesTVShowsService <NSObject>

- (RACSignal *)getAllFavoritesTVShows;
- (RACSignal *)updateFavoritesTVShowsInCache;
- (RACSignal *)makeTVShowAsFavorite:(TVShow *)tvShow
                           favorite:(BOOL)favorite;

@end