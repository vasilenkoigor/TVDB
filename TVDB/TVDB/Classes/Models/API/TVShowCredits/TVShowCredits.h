//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@class Cast;

@interface TVShowCredits : MTLModel <MTLJSONSerializing>

@property (strong, nonatomic) NSArray <Cast *> *cast;

@end