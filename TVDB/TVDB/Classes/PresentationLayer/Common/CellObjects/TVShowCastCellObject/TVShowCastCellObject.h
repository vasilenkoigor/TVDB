//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NICellFactory.h"

@class Cast;

@interface TVShowCastCellObject : NSObject <NICellObject>

@property (copy, nonatomic) NSURL *posterURL;
@property (copy, nonatomic) NSString *castName;
@property (copy, nonatomic) NSString *castCharacterName;

- (instancetype)initWithCast:(Cast *)cast;

@end