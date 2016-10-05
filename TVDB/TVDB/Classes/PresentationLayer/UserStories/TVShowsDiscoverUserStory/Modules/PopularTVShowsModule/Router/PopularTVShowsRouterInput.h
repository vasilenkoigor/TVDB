//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TVShow;

@protocol PopularTVShowsRouterInput <NSObject>

- (void)openDiscoverTVShowWithTVShow:(TVShow *)tvShow;
- (void)closeCurrentModule;

@end