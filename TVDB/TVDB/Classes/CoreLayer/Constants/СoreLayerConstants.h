//
// Created by Igor Vasilenko on 28/09/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kTheMovieDBAPIKey;
extern NSString *const kTheMovieDBSmallImageBasePath;
extern NSString *const kTheMovieDBMediumImageBasePath;

NSURL *theMovieDBSmallImageBaseURL();
NSURL *theMovieDBMediumImageBaseURL();