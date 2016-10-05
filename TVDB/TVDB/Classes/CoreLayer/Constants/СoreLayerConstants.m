//
// Created by Igor Vasilenko on 28/09/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "СoreLayerConstants.h"

NSString *const kTheMovieDBAPIKey = @"0315406fedcffb650f19ffe870ccb71c";
NSString *const kTheMovieDBSmallImageBasePath = @"https://image.tmdb.org/t/p/w92";
NSString *const kTheMovieDBMediumImageBasePath = @"https://image.tmdb.org/t/p/w185";

NSURL *theMovieDBSmallImageBaseURL() {
    return [[NSURL alloc] initWithString:@"https://image.tmdb.org/t/p/w92/"];
}

NSURL *theMovieDBMediumImageBaseURL() {
    return [[NSURL alloc] initWithString:@"https://image.tmdb.org/t/p/w185/"];
}
