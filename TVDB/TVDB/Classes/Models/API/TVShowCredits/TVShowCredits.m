//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "TVShowCredits.h"
#import "Cast.h"


@implementation TVShowCredits

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return
            @{
                    NSStringFromSelector(@selector(cast)) : @"cast"
            };
}

+ (NSValueTransformer *)castJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[Cast class]];
}

@end