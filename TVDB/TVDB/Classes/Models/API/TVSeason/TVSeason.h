//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@class TVEpisode;

@interface TVSeason : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic) NSString *uid;
@property (strong, nonatomic) NSDate *airDate;
@property (strong, nonatomic) NSArray <TVEpisode *> *episodes;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *overview;
@property (copy, nonatomic) NSString *posterSmallImageURL;
@property (copy, nonatomic) NSString *posterMediumImageURL;
@property (assign, nonatomic) NSInteger seasonNumber;

@end