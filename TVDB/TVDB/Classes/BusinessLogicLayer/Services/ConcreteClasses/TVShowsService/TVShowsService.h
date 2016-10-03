//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSFetchedResultsController;
@class RACSignal;
@class TVShow;

@protocol TVShowsService <NSObject>

@property (strong, nonatomic, readonly) NSFetchedResultsController *fetchedResultsController;

#pragma mark - Recents TV Shows

- (RACSignal *)recentsTVShows;

#pragma mark - Manage Favorites TV Shows

- (RACSignal *)setFavoriteTVShow:(TVShow *)tvShow;

@end