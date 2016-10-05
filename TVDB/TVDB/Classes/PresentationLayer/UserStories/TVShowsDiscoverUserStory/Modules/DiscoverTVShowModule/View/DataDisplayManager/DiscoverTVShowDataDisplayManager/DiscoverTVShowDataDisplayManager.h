//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataDisplayManager.h"

@class TVShow;
@class DiscoverTVShowCellObjectsBuilder;
@class TVShowSeasonCellObject;
@class DiscoverTVShowDataDisplayManager;

@protocol DiscoverTVShowDataDisplayManagerDelegate <NSObject>

- (void)dataDisplayManager:(DiscoverTVShowDataDisplayManager *)dataDisplayManager didSelectTVSeason:(TVShowSeasonCellObject *)tvSeasonCellObject;

@end

@interface DiscoverTVShowDataDisplayManager : NSObject <DataDisplayManager>

@property (weak, nonatomic) id <DiscoverTVShowDataDisplayManagerDelegate> delegate;
@property (strong, nonatomic) DiscoverTVShowCellObjectsBuilder *discoverTVShowCellObjectsBuilder;

- (void)configureDataDisplayManagerWithTVShow:(TVShow *)tvShow;

@end