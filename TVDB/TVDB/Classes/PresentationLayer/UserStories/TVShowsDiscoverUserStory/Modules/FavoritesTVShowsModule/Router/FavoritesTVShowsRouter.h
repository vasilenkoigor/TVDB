//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FavoritesTVShowsRouterInput.h"

@protocol RamblerViperModuleTransitionHandlerProtocol;


@interface FavoritesTVShowsRouter : NSObject <FavoritesTVShowsRouterInput>

@property (weak, nonatomic) id <RamblerViperModuleTransitionHandlerProtocol> transitionHandler;

@end