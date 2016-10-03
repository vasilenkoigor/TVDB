//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "TVDiscoverResult.h"
#import "TVShow.h"


@implementation TVDiscoverResult

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return
            @{
                    NSStringFromSelector(@selector(page)) : @"page",
                    NSStringFromSelector(@selector(results)) : @"results",
                    NSStringFromSelector(@selector(totalPages)) : @"total_pages"
            };
}

+ (NSValueTransformer *)resultsJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[TVShow class]];
}

@end