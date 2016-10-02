//
// Created by Igor Vasilenko on 02/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;

@protocol AuthenticationService <NSObject>

- (RACSignal *)rac_startAuthenticationWithUserName:(NSString *)userName
                                          password:(NSString *)password;

@end