//
// Created by Igor Vasilenko on 02/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Typhoon/TyphoonAssembly.h>
#import <RamblerTyphoonUtils/RamblerInitialAssembly.h>
#import "ServiceComponentsFactory.h"

@protocol CoreComponentsFactory;

@interface ServiceComponentsAssembly : TyphoonAssembly <ServiceComponentsFactory, RamblerInitialAssembly>

@property (strong, nonatomic, readonly) TyphoonAssembly <CoreComponentsFactory> *coreComponents;

@end