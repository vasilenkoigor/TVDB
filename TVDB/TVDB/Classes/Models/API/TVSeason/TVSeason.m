//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Mantle/MTLValueTransformer.h>
#import "TVSeason.h"
#import "TVEpisode.h"
#import "СoreLayerConstants.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"


@implementation TVSeason

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return
            @{
                    NSStringFromSelector(@selector(uid)) : @"id",
                    NSStringFromSelector(@selector(airDate)) : @"air_date",
                    NSStringFromSelector(@selector(episodes)) : @"episodes",
                    NSStringFromSelector(@selector(name)) : @"name",
                    NSStringFromSelector(@selector(overview)) : @"overview",
                    NSStringFromSelector(@selector(posterSmallImageURL)) : @"poster_path",
                    NSStringFromSelector(@selector(posterMediumImageURL)) : @"poster_path",
                    NSStringFromSelector(@selector(seasonNumber)) : @"season_number"
            };
}

+ (NSValueTransformer *)airDateJSONTransformer
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MM-DD";
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
        return [dateFormatter dateFromString:dateString];
    }];
}

+ (NSValueTransformer *)episodesJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[TVEpisode class]];
}

+ (NSValueTransformer *)posterSmallImageURLJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *path, BOOL *success, NSError **error) {
        if (!path) return nil;
        return [[NSURL alloc] initWithString:[kTheMovieDBSmallImageBasePath stringByAppendingString:path]];
    }];
}

+ (NSValueTransformer *)posterMediumImageURLJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *path, BOOL *success, NSError **error) {
        if (!path) return nil;
        return [[NSURL alloc] initWithString:[kTheMovieDBMediumImageBasePath stringByAppendingString:path]];
    }];
}
@end