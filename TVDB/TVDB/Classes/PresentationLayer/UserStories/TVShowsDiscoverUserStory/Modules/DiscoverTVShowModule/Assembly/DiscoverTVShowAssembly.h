//
// Created by Igor Vasilenko on 04/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "RamblerInitialAssembly.h"
#import "ModuleAssemblyBase.h"

@class CellObjectsBuildersAssembly;

@interface DiscoverTVShowAssembly : ModuleAssemblyBase <RamblerInitialAssembly>

@property (strong, nonatomic, readonly) CellObjectsBuildersAssembly *cellObjectsBuildersAssembly;

@end