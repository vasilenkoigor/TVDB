//
// Created by Igor Vasilenko on 04/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "TyphoonAssembly.h"
#import "RamblerInitialAssembly.h"

@class TVShowCellObjectsBuilder;
@class DiscoverTVShowCellObjectsBuilder;
@class TVEpisodeCellObjectsBuilder;

@interface CellObjectsBuildersAssembly : TyphoonAssembly <RamblerInitialAssembly>

- (TVShowCellObjectsBuilder *)tVShowCellObjectsBuilder;
- (DiscoverTVShowCellObjectsBuilder *)discoverTVShowCellObjectsBuilder;
- (TVEpisodeCellObjectsBuilder *)tvEpisodeCellObjectsBuilder;

@end