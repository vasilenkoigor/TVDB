//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "TVShowGenresCell.h"
#import "TVShowGenresCellObject.h"

@interface TVShowGenresCell ()

@end

@implementation TVShowGenresCell

- (BOOL)shouldUpdateCellWithObject:(TVShowGenresCellObject *)object
{
    self.textLabel.text = object.genresList;
    return YES;
}

@end