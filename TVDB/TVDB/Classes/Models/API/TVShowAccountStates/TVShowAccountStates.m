//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "TVShowAccountStates.h"
#import <Mantle/Mantle.h>

@implementation TVShowAccountStates

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return
            @{
                    NSStringFromSelector(@selector(favorite)) : @"favorite"
            };
}

@end