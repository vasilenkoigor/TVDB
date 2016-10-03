//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "Genre.h"


@implementation Genre

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return
            @{
                    NSStringFromSelector(@selector(uid)) : @"id",
                    NSStringFromSelector(@selector(name)) : @"name"
            };
}

@end