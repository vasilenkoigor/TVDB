//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "TVShowEpisodeCellObject.h"
#import "TVShowEpisodeCell.h"
#import "TVEpisode.h"


@implementation TVShowEpisodeCellObject

- (instancetype)initWithEpisode:(TVEpisode *)episode
{
    self = [super init];
    if (self) {
        self.posterURL = episode.stillSmallImageURL;
        self.episodeName = episode.name;
        self.episodeOverview = episode.overview;
    }
    return self;
}

- (Class)cellClass
{
    return [TVShowEpisodeCell class];
}

- (UINib *)cellNib
{
    return [UINib nibWithNibName:NSStringFromClass([TVShowEpisodeCell class]) bundle:[NSBundle mainBundle]];
}

@end