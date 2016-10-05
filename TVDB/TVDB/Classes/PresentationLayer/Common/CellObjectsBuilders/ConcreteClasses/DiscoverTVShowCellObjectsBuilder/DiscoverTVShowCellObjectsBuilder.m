//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "DiscoverTVShowCellObjectsBuilder.h"
#import "TVShow.h"
#import "TVShowCellSummaryObject.h"
#import "TVShowGenresCellObject.h"
#import "TVShowCastCellObject.h"
#import "TVShowSeasonCellObject.h"


@implementation DiscoverTVShowCellObjectsBuilder

- (NSArray *)sectionedCellObjectsWithTVShow:(TVShow *)tvShow
{
    __block NSMutableArray *mutableArray = [NSMutableArray array];

    TVShowCellSummaryObject *tvShowCellSummaryObject = [[TVShowCellSummaryObject alloc] initWithTVShow:tvShow];
    [mutableArray addObject:@"Summary"];
    [mutableArray addObject:tvShowCellSummaryObject];

    if (tvShow.genres.count) {
        TVShowGenresCellObject *tvShowGenresCellObject = [[TVShowGenresCellObject alloc] initWithGenres:tvShow.genres];
        [mutableArray addObject:@"Genres"];
        [mutableArray addObject:tvShowGenresCellObject];
    }

    if (tvShow.casts.count) {
        [mutableArray addObject:@"Casts"];
        [tvShow.casts enumerateObjectsUsingBlock:^(Cast *obj, NSUInteger idx, BOOL *stop) {
            TVShowCastCellObject *tvShowCastCellObject = [[TVShowCastCellObject alloc] initWithCast:obj];
            [mutableArray addObject:tvShowCastCellObject];
        }];
    }

    if (tvShow.seasons.count) {
        [mutableArray addObject:@"Seasons"];
        [tvShow.seasons enumerateObjectsUsingBlock:^(TVSeason *obj, NSUInteger idx, BOOL *stop) {
            TVShowSeasonCellObject *tvShowSeasonCellObject = [[TVShowSeasonCellObject alloc] initWithSeason:obj];
            [mutableArray addObject:tvShowSeasonCellObject];
        }];
    }

    return [mutableArray copy];
}

@end