//
// Created by Igor Vasilenko on 04/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;
@class TVShow;
@class TVSeason;
@class RACCommand;

@protocol DiscoverTVShowViewModelInput <NSObject>

@property (strong, nonatomic, readonly) TVShow *tvShow;
@property (copy, nonatomic, readonly) NSString *favoriteButtonTitle;

@property (strong, nonatomic, readonly) RACCommand *favoriteButtonCommand;
@property (strong, nonatomic, readonly) RACSignal *loadTVShowsErrorSignal;

- (void)makeTVShowAsFavorite;
- (void)openEpisodesForSeason:(TVSeason *)season;

@end