//
// Created by Igor Vasilenko on 04/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "DiscoverTVShowRouterInput.h"

@protocol RamblerViperModuleTransitionHandlerProtocol;

@interface DiscoverTVShowRouter : NSObject <DiscoverTVShowRouterInput>

@property (weak, nonatomic) id <RamblerViperModuleTransitionHandlerProtocol> transitionHandler;

@end