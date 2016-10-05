//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;
@class TVShow;

@protocol TVShowsService <NSObject>

- (RACSignal *)popularTVShows;

- (RACSignal *)getFullTVShow:(TVShow *)tvShow;

@end