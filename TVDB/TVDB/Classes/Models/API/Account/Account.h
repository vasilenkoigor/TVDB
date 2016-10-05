//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface Account : MTLModel <MTLJSONSerializing>

@property (assign, nonatomic) NSUInteger uid;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *username;

@end