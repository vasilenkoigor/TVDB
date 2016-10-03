//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@class TVSeason;
@class ProductionCompany;
@class Network;
@class Genre;
@class Creator;
@class Cast;

@interface TVShow : MTLModel <MTLJSONSerializing>

@property (strong, nonatomic) NSArray <Creator *> *createdBy;
@property (strong, nonatomic) NSArray <Genre *> *genres;
@property (strong, nonatomic) NSArray <Cast *> *casts;
@property (copy, nonatomic) NSString *homepage;
@property (copy, nonatomic) NSString *uid;
@property (copy, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray <Network *> *networks;
@property (assign, nonatomic) NSUInteger numberOfSeasons;
@property (assign, nonatomic) NSUInteger numberOfEpisodes;
@property (copy, nonatomic) NSString *originalName;
@property (copy, nonatomic) NSString *overview;
@property (copy, nonatomic) NSURL *smallPosterImageURL;
@property (copy, nonatomic) NSURL *mediumPosterImageURL;
@property (strong, nonatomic) NSArray <ProductionCompany *> *productionCompanies;
@property (strong, nonatomic) NSArray <TVSeason *> *seasons;

@end