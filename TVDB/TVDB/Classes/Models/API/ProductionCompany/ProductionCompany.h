//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface ProductionCompany : MTLModel <MTLJSONSerializing>

@property (assign, nonatomic) NSUInteger uid;
@property (copy, nonatomic) NSString *name;

@end