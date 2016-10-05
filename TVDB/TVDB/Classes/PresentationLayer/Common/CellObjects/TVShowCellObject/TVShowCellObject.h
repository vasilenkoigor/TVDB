//
// Created by Igor Vasilenko on 04/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "NICellFactory.h"

@class TVShow;

@interface TVShowCellObject : NSObject <NICellObject>

@property (strong, nonatomic, readonly) TVShow *tvShow;

@property (strong, nonatomic) NSURL *posterURL;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *overview;

- (instancetype)initWithTVShow:(TVShow *)tvShow;

@end