//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "UserAuthenticationViewModel.h"
#import "UserAuthenticationRouterInput.h"
#import "AuthenticationService.h"

@interface UserAuthenticationViewModel ()

@property (strong, nonatomic, readwrite) id <UserAuthenticationRouterInput> router;
@property (strong, nonatomic, readwrite) id <AuthenticationService> authenticationService;

@end

@implementation UserAuthenticationViewModel


@end