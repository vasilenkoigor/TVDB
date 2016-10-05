//
// Created by Igor Vasilenko on 04/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "TVShowCellObjectsBuilder.h"
#import "TVShow.h"
#import "TVShowCellObject.h"


@implementation TVShowCellObjectsBuilder

- (NSArray *)cellObjectsForTVShows:(NSArray *)tvShows
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:tvShows.count];
    for (TVShow *tvShow in tvShows) {
        TVShowCellObject *tvShowCellObject = [[TVShowCellObject alloc] initWithTVShow:tvShow];
        [array addObject:tvShowCellObject];
    }
    return [array copy];
}

@end