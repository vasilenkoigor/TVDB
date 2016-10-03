//
// Created by Igor Vasilenko on 02/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AuthenticationService;
@protocol KeychainService;

@protocol ServiceComponentsFactory <NSObject>

- (id <KeychainService>)keychainService;

- (id <AuthenticationService>)authenticationService;

@end