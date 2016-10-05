//
// Created by Igor Vasilenko on 04/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "CellObjectsBuildersAssembly.h"
#import "TVShowCellObjectsBuilder.h"
#import "DiscoverTVShowCellObjectsBuilder.h"
#import "TVEpisodeCellObjectsBuilder.h"

@implementation CellObjectsBuildersAssembly

- (TVShowCellObjectsBuilder *)tVShowCellObjectsBuilder
{
    return [TyphoonDefinition withClass:[TVShowCellObjectsBuilder class]];
}

- (DiscoverTVShowCellObjectsBuilder *)discoverTVShowCellObjectsBuilder
{
    return [TyphoonDefinition withClass:[DiscoverTVShowCellObjectsBuilder class]];
}

- (TVEpisodeCellObjectsBuilder *)tvEpisodeCellObjectsBuilder
{
    return [TyphoonDefinition withClass:[TVEpisodeCellObjectsBuilder class]];
}


@end