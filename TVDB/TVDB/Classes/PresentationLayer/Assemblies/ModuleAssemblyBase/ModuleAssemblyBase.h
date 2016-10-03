//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Typhoon/TyphoonAssembly.h>

@protocol ServiceComponentsFactory;

@interface ModuleAssemblyBase : TyphoonAssembly

@property (strong, nonatomic, readonly) TyphoonAssembly <ServiceComponentsFactory> *serviceComponents;

@end