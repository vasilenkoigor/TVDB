//
// Created by Igor Vasilenko on 02/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "TokenModel.h"
#import "SessionModel.h"

@implementation TokenModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return
            @{
                    NSStringFromSelector(@selector(success)) : @"success",
                    NSStringFromSelector(@selector(expiresAt)) : @"expires_at",
                    NSStringFromSelector(@selector(requestToken)) : @"request_token"
            };
}

+ (NSValueTransformer *)expiresAtJSONTransformer
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MM-DD HH:MM:SS";
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
        return [dateFormatter dateFromString:dateString];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        return [dateFormatter stringFromDate:date];
    }];
}

@end