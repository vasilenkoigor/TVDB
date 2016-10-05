//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Nimbus/NICellFactory.h>

@class TVEpisode;


@interface TVShowEpisodeCellObject : NSObject <NICellObject>

@property (copy, nonatomic) NSURL *posterURL;
@property (copy, nonatomic) NSString *episodeName;
@property (copy, nonatomic) NSString *episodeOverview;

- (instancetype)initWithEpisode:(TVEpisode *)episode;

@end