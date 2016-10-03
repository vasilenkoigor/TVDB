//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "KeychainService.h"

@class UICKeyChainStore;

@interface KeychainServiceImpl : NSObject <KeychainService>

@property (strong, nonatomic, readonly) UICKeyChainStore *keyChainStore;

- (instancetype)initWithKeychainStore:(UICKeyChainStore *)keyChainStore;

@end