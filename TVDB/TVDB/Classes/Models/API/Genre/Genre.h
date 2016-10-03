//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface Genre : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic) NSString *uid;
@property (copy, nonatomic) NSString *name;

@end