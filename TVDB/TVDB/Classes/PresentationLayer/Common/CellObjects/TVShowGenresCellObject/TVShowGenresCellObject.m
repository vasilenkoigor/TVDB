//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "TVShowGenresCellObject.h"
#import "TVShowGenresCell.h"


@implementation TVShowGenresCellObject

- (instancetype)initWithGenres:(NSArray *)genres
{
    self = [super init];
    if (self) {
        NSMutableString *string = [NSMutableString string];
        NSArray *array = [genres valueForKey:@"name"];
        for (NSString *genre in array) {
            if (genre) {
                [string appendFormat:@"%@ ", genre];
            }
        }
        self.genresList = string;
    }
    return self;
}

- (Class)cellClass
{
    return [TVShowGenresCell class];
}

@end