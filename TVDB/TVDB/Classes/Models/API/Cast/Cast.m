//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "Cast.h"
#import "MTLValueTransformer.h"
#import "СoreLayerConstants.h"


@implementation Cast

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return
            @{
                    NSStringFromSelector(@selector(character)) : @"character",
                    NSStringFromSelector(@selector(uid)) : @"id",
                    NSStringFromSelector(@selector(name)) : @"name",
                    NSStringFromSelector(@selector(profileSmallImageURL)) : @"profile_path",
                    NSStringFromSelector(@selector(profileMediumImageURL)) : @"profile_path"
            };
}

+ (NSValueTransformer *)profileSmallImageURLJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *path, BOOL *success, NSError **error) {
        return [[NSURL alloc] initWithString:path relativeToURL:kTheMovieDBSmallImageBasePath];
    }];
}

+ (NSValueTransformer *)profileMediumImageURLJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *path, BOOL *success, NSError **error) {
        return [[NSURL alloc] initWithString:path relativeToURL:kTheMovieDBMediumImageBasePath];
    }];
}

@end