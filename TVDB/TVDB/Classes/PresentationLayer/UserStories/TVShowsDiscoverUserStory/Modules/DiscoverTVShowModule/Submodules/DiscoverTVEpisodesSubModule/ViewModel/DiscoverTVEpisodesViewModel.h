//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DiscoverTVEpisodesModuleInput.h"
#import "DiscoverTVEpisodesViewModelInput.h"

@protocol DiscoverTVEpisodesRouterInput;


@interface DiscoverTVEpisodesViewModel : NSObject <DiscoverTVEpisodesViewModelInput, DiscoverTVEpisodesModuleInput>

@property (strong, nonatomic, readonly) id <DiscoverTVEpisodesRouterInput> router;

@end