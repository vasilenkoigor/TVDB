//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "DiscoverTVEpisodesViewModel.h"
#import "TVSeason.h"
#import "DiscoverTVEpisodesRouterInput.h"

@interface DiscoverTVEpisodesViewModel ()

@property (strong, nonatomic, readwrite) id <DiscoverTVEpisodesRouterInput> router;
@property (strong, nonatomic) NSArray *episodes;

@end

@implementation DiscoverTVEpisodesViewModel

- (void)configureModuleWithTVSeason:(TVSeason *)tvSeason
{
    self.episodes = tvSeason.episodes;
}

@end