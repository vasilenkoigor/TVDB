//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface TVEpisode : MTLModel <MTLJSONSerializing>

@property (strong, nonatomic) NSDate *airDate;
@property (assign, nonatomic) NSUInteger episodeNumber;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *overview;
@property (assign, nonatomic) NSUInteger uid;
@property (copy, nonatomic) NSURL *stillSmallImageURL;
@property (copy, nonatomic) NSURL *stillMediumImageURL;

@end