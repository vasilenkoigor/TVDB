//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "ModuleAssemblyBase.h"
#import "RamblerInitialAssembly.h"

@class CellObjectsBuildersAssembly;

@interface PopularTVShowsAssembly : ModuleAssemblyBase <RamblerInitialAssembly>

@property (strong, nonatomic, readonly) CellObjectsBuildersAssembly *cellObjectsBuildersAssembly;

@end