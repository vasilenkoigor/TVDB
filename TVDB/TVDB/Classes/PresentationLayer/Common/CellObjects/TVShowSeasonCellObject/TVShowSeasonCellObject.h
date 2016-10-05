//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Nimbus/NICellFactory.h>

@class TVSeason;


@interface TVShowSeasonCellObject : NSObject <NICellObject>

@property (strong, nonatomic) TVSeason *tvSeason;

@property (copy, nonatomic) NSURL *posterURL;
@property (copy, nonatomic) NSString *seasonName;
@property (copy, nonatomic) NSString *seasonOverview;
@property (copy, nonatomic) NSString *numberOfEpisodes;

- (instancetype)initWithSeason:(TVSeason *)season;

@end