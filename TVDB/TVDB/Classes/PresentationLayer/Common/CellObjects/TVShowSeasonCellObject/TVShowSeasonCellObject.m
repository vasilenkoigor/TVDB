//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "TVShowSeasonCellObject.h"
#import "TVShowSeasonCell.h"
#import "TVSeason.h"


@implementation TVShowSeasonCellObject

- (instancetype)initWithSeason:(TVSeason *)season
{
    self = [super init];
    if (self) {
        self.tvSeason = season;
        self.posterURL = season.posterSmallImageURL;
        self.seasonName = season.name;
        self.seasonOverview = season.overview;
        self.numberOfEpisodes = [NSString stringWithFormat:@"Number of episodes: %@", @(season.episodes.count).stringValue];
    }
    return self;
}

- (Class)cellClass
{
    return [TVShowSeasonCell class];
}

- (UINib *)cellNib
{
    return [UINib nibWithNibName:NSStringFromClass([TVShowSeasonCell class]) bundle:[NSBundle mainBundle]];
}

@end