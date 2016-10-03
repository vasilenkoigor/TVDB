//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "UserAuthenticationRouterInput.h"

@protocol RamblerViperModuleTransitionHandlerProtocol;

@interface UserAuthenticationRouter : NSObject <UserAuthenticationRouterInput>

@property (weak, nonatomic) id <RamblerViperModuleTransitionHandlerProtocol> transitionHandler;

@end