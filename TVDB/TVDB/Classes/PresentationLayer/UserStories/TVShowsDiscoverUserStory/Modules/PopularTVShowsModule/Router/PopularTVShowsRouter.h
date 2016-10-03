//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "PopularTVShowsRouterInput.h"

@protocol RamblerViperModuleTransitionHandlerProtocol;

@interface PopularTVShowsRouter : NSObject <PopularTVShowsRouterInput>

@property (weak, nonatomic) id <RamblerViperModuleTransitionHandlerProtocol> transitionHandler;

@end