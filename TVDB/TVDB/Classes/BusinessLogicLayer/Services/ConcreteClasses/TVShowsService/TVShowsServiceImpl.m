//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "TVShowsServiceImpl.h"
#import "NetworkClient.h"
#import "KeychainService.h"
#import "СoreLayerConstants.h"
#import "TVDiscoverResult.h"

static NSString *const kDiscoverTVShowsTheMovieDBURL = @"discover/tv";

@interface TVShowsServiceImpl ()

@property (strong, nonatomic, readwrite) id <NetworkClient> networkClient;
@property (strong, nonatomic, readwrite) id <KeychainService> keychainService;
@property (strong, nonatomic, readwrite) id <CoreDataStack> coreDataStack;

@end

@implementation TVShowsServiceImpl

- (instancetype)initWithNetworkClient:(id <NetworkClient>)networkClient
                      keychainService:(id <KeychainService>)keychainService
                        coreDataStack:(id <CoreDataStack>)coreDataStack
{
    self = [super init];
    if (self) {
        self.networkClient = networkClient;
        self.keychainService = keychainService;
        self.coreDataStack = coreDataStack;
    }
    return self;
}

#pragma mark - TVShowsService protocol

- (RACSignal *)recentsTVShows
{
    return [self.networkClient rac_method:HTTPMethodGET
                                URLString:kDiscoverTVShowsTheMovieDBURL
                               parameters:
                                       @{
                                               @"api_key" : kTheMovieDBAPIKey,
                                               @"language" : @"en-US",
                                               @"sort_by" : @"popularity.desc",
                                               @"first_air_date_year" : @"2015"

                                       }
                              resultClass:[TVDiscoverResult class]
                                   forKey:nil];
}

@end