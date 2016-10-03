//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@class TVShow;

@interface TVDiscoverResult : MTLModel <MTLJSONSerializing>

@property (assign, nonatomic) NSUInteger page;
@property (strong, nonatomic) NSArray <TVShow *> *results;
@property (assign, nonatomic) NSUInteger totalPages;

@end