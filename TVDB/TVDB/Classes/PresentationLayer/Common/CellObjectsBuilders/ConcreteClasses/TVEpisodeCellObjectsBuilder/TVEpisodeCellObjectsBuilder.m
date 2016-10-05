//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "TVEpisodeCellObjectsBuilder.h"
#import "TVEpisode.h"
#import "TVShowEpisodeCellObject.h"


@implementation TVEpisodeCellObjectsBuilder

- (NSArray *)cellObjectsWithEpisodes:(NSArray *)episodes
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:episodes.count];
    for (TVEpisode *episode in episodes) {
        TVShowEpisodeCellObject *tvShowEpisodeCellObject = [[TVShowEpisodeCellObject alloc] initWithEpisode:episode];
        [array addObject:tvShowEpisodeCellObject];
    }
    return [array copy];
}

@end