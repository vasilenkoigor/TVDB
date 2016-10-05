//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TVShow;


@interface DiscoverTVShowCellObjectsBuilder : NSObject

- (NSArray *)sectionedCellObjectsWithTVShow:(TVShow *)tvShow;

@end