//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Mantle/MTLValueTransformer.h>
#import "TVShow.h"
#import "TVSeason.h"
#import "ProductionCompany.h"
#import "Network.h"
#import "Genre.h"
#import "Creator.h"
#import "Cast.h"
#import "СoreLayerConstants.h"

@implementation TVShow

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return
            @{
                    NSStringFromSelector(@selector(createdBy)) : @"created_by",
                    NSStringFromSelector(@selector(genres)) : @"genres",
                    NSStringFromSelector(@selector(homepage)) : @"homepage",
                    NSStringFromSelector(@selector(uid)) : @"id",
                    NSStringFromSelector(@selector(name)) : @"name",
                    NSStringFromSelector(@selector(networks)) : @"networks",
                    NSStringFromSelector(@selector(numberOfSeasons)) : @"number_of_seasons",
                    NSStringFromSelector(@selector(numberOfEpisodes)) : @"number_of_episodes",
                    NSStringFromSelector(@selector(originalName)) : @"original_name",
                    NSStringFromSelector(@selector(overview)) : @"overview",
                    NSStringFromSelector(@selector(smallPosterImageURL)) : @"poster_path",
                    NSStringFromSelector(@selector(mediumPosterImageURL)) : @"poster_path",
                    NSStringFromSelector(@selector(productionCompanies)) : @"production_companies",
                    NSStringFromSelector(@selector(seasons)) : @"seasons"
            };
}

+ (NSValueTransformer *)createdByJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[Creator class]];
}

+ (NSValueTransformer *)genresJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[Genre class]];
}

+ (NSValueTransformer *)networksJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[Network class]];
}

+ (NSValueTransformer *)posterSmallImageURLJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *path, BOOL *success, NSError **error) {
        return [[NSURL alloc] initWithString:path relativeToURL:kTheMovieDBSmallImageBasePath];
    }];
}

+ (NSValueTransformer *)posterMediumImageURLJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *path, BOOL *success, NSError **error) {
        return [[NSURL alloc] initWithString:path relativeToURL:kTheMovieDBMediumImageBasePath];
    }];
}

+ (NSValueTransformer *)seasonsJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[TVSeason class]];
}

@end