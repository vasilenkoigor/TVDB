//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Mantle/MTLValueTransformer.h>
#import "TVEpisode.h"
#import "СoreLayerConstants.h"


@implementation TVEpisode

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return
            @{
                    NSStringFromSelector(@selector(airDate)) : @"air_date",
                    NSStringFromSelector(@selector(episodeNumber)) : @"episode_number",
                    NSStringFromSelector(@selector(name)) : @"name",
                    NSStringFromSelector(@selector(overview)) : @"overview",
                    NSStringFromSelector(@selector(uid)) : @"id",
                    NSStringFromSelector(@selector(stillSmallImageURL)) : @"profile_path",
                    NSStringFromSelector(@selector(stillMediumImageURL)) : @"profile_path",
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

+ (NSValueTransformer *)stillSmallImageURLJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *path, BOOL *success, NSError **error) {
        return [[NSURL alloc] initWithString:path relativeToURL:kTheMovieDBSmallImageBasePath];
    }];
}

+ (NSValueTransformer *)stillMediumImageURLJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *path, BOOL *success, NSError **error) {
        return [[NSURL alloc] initWithString:path relativeToURL:kTheMovieDBMediumImageBasePath];
    }];
}

@end