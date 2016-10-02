//
// Created by Igor Vasilenko on 02/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface SessionModel : MTLModel <MTLJSONSerializing>

@property (assign, nonatomic) BOOL success;
@property (copy, nonatomic) NSString *uid;

@end