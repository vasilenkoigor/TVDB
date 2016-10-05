//
// Created by Igor Vasilenko on 04/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TVSeason;

@protocol DiscoverTVShowRouterInput <NSObject>

- (void)openDiscoverEpisodesModuleWithTVSeason:(TVSeason *)tvSeason;

@end