//
// Created by Igor Vasilenko on 02/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "SessionModel.h"


@implementation SessionModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return
            @{
                    NSStringFromSelector(@selector(success)) : @"success",
                    NSStringFromSelector(@selector(uid)) : @"session_id"
            };
}

@end