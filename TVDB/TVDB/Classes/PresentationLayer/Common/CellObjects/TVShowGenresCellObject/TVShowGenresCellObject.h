//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Nimbus/NICellFactory.h>


@interface TVShowGenresCellObject : NSObject <NICellObject>

@property (copy, nonatomic) NSString *genresList;

- (instancetype)initWithGenres:(NSArray *)genres;

@end