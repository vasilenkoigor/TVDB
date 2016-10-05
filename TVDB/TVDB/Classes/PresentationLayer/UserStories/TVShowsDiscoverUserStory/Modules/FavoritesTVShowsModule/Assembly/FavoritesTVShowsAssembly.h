//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModuleAssemblyBase.h"
#import "RamblerInitialAssembly.h"

@class CellObjectsBuildersAssembly;


@interface FavoritesTVShowsAssembly : ModuleAssemblyBase <RamblerInitialAssembly>

@property (strong, nonatomic, readonly) CellObjectsBuildersAssembly *cellObjectsBuildersAssembly;

@end