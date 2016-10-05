//
// Created by Igor Vasilenko on 04/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "TVShowCellObject.h"
#import "TVShowCell.h"
#import "TVShow.h"

@interface TVShowCellObject ()

@property (strong, nonatomic, readwrite) TVShow *tvShow;

@end

@implementation TVShowCellObject

- (instancetype)initWithTVShow:(TVShow *)tvShow
{
    self = [super init];
    if (self) {
        self.posterURL = tvShow.smallPosterImageURL;
        self.name = tvShow.name;
        self.overview = tvShow.overview;
        self.tvShow = tvShow;
    }
    return self;
}

- (Class)cellClass
{
    return [TVShowCell class];
}

- (UINib *)cellNib
{
    return [UINib nibWithNibName:NSStringFromClass([TVShowCell class]) bundle:[NSBundle mainBundle]];
}

@end