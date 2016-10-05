//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;
@class TVShowCellObject;

@protocol FavoritesTVShowsViewModelInput <NSObject>

@property (strong, nonatomic, readonly) NSArray *tvShows;
@property (strong, nonatomic, readonly) RACSignal *loadTVShowsErrorSignal;

- (void)reloadTVShows;
- (void)discoverTVShow:(TVShowCellObject *)tvShowCellObject;

@end