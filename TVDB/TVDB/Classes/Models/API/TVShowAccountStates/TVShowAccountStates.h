//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface TVShowAccountStates : MTLModel <MTLJSONSerializing>

@property (assign, nonatomic) BOOL favorite;

@end