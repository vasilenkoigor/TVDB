//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Typhoon/TyphoonAssembly.h>
#import <RamblerTyphoonUtils/RamblerInitialAssembly.h>

@class TyphoonStoryboard;

@interface StoryboardAssembly : TyphoonAssembly <RamblerInitialAssembly>

- (TyphoonStoryboard *)authenticationUserStoryStoryboard;
- (TyphoonStoryboard *)tvShowsDiscoverUserStoryStoryboard;

@end