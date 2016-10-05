//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "TVShowCastCellObject.h"
#import "TVShowCastCell.h"
#import "Cast.h"


@implementation TVShowCastCellObject

- (instancetype)initWithCast:(Cast *)cast
{
    self = [super init];
    if (self) {
        self.posterURL = cast.profileSmallImageURL;
        self.castName = cast.name;
        self.castCharacterName = cast.character;
    }
    return self;
}


- (Class)cellClass
{
    return [TVShowCastCell class];
}

- (UINib *)cellNib
{
    return [UINib nibWithNibName:NSStringFromClass([TVShowCastCell class]) bundle:[NSBundle mainBundle]];
}

@end