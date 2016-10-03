//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "PopularTVShowsViewModelInput.h"

@protocol TVShowsService;

@interface PopularTVShowsViewModel : NSObject <PopularTVShowsViewModelInput>

@property (strong, nonatomic, readonly) id <TVShowsService>

@end