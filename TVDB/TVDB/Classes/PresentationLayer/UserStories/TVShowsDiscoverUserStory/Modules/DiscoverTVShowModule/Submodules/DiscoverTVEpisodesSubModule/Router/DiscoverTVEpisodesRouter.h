//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "DiscoverTVEpisodesRouterInput.h"

@protocol RamblerViperModuleTransitionHandlerProtocol;


@interface DiscoverTVEpisodesRouter : NSObject <DiscoverTVEpisodesRouterInput>

@property (weak, nonatomic) id <RamblerViperModuleTransitionHandlerProtocol> transitionHandler;

@end