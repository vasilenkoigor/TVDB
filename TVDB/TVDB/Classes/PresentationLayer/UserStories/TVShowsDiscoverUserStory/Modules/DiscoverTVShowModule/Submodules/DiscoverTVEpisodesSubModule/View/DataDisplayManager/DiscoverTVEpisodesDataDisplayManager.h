//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataDisplayManager.h"

@class TVEpisodeCellObjectsBuilder;


@interface DiscoverTVEpisodesDataDisplayManager : NSObject <DataDisplayManager>

@property (strong, nonatomic) TVEpisodeCellObjectsBuilder *tvEpisodeCellObjectsBuilder;

- (void)configureDataDisplayManagerWithTVEpisodes:(NSArray *)tvEpisodes;

@end