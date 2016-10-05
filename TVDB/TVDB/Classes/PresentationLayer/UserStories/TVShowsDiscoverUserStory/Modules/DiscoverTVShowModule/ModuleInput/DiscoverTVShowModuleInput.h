//
// Created by Igor Vasilenko on 04/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <ViperMcFlurry/ViperMcFlurry.h>

@class TVShow;
@class TVShowCellObject;

@protocol DiscoverTVShowModuleInput <RamblerViperModuleInput>

- (void)configureDiscoverTVShowModuleWithTVShow:(TVShow *)tvShow;

@end