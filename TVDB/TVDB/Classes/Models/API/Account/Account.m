//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "Account.h"


@implementation Account

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return
            @{
                    NSStringFromSelector(@selector(uid)) : @"id",
                    NSStringFromSelector(@selector(name)) : @"name",
                    NSStringFromSelector(@selector(username)) : @"username"
            };
}

@end