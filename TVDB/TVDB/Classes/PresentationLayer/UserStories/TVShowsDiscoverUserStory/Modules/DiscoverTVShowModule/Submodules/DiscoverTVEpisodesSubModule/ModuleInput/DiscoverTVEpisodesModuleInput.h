//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RamblerViperModuleInput.h"

@class TVSeason;

@protocol DiscoverTVEpisodesModuleInput <RamblerViperModuleInput>

- (void)configureModuleWithTVSeason:(TVSeason *)tvSeason;

@end