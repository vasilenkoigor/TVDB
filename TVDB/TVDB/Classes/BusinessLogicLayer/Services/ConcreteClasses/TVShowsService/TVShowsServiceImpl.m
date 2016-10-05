//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "TVShowsServiceImpl.h"
#import "NetworkClient.h"
#import "KeychainService.h"
#import "СoreLayerConstants.h"
#import "TVDiscoverResult.h"
#import "TVShow.h"
#import "SessionModel.h"
#import "TVShowCredits.h"
#import "TVShowAccountStates.h"
#import "RACSignal+Operations.h"
#import "TVSeason.h"
#import "RACTuple.h"
#import "CoreDataStack.h"

static NSString *const kDiscoverTVShowsTheMovieDBURL = @"discover/tv";

static NSString *const kDetailTVShowTheMovieDBURL = @"tv/%d";
static NSString *const kCreditsTVShowTheMovieDBURL = @"tv/%d/credits";
static NSString *const kAccountStatesTVShowTheMovieDBURL = @"tv/%d/account_states";
static NSString *const kSeasonsTVShowTheMovieDBURL = @"tv/%d/season/%d";

@interface TVShowsServiceImpl ()

@property (strong, nonatomic, readwrite) id <NetworkClient> networkClient;
@property (strong, nonatomic, readwrite) id <KeychainService> keychainService;
@property (strong, nonatomic, readwrite) id <CoreDataStack> coreDataStack;
@property (strong, nonatomic) SessionModel *sessionModel;

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
        self.sessionModel = [self.keychainService requestSession];
    }
    return self;
}

#pragma mark - TVShowsService protocol

- (RACSignal *)popularTVShows
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

- (RACSignal *)getFullTVShow:(TVShow *)tvShow
{
    return [[RACSignal combineLatest:@[[self getDetailTVShow:tvShow], [self getCreditsTVShow:tvShow], [self getAccountStatesTVShow:tvShow]]
                             reduce:^id(TVShow *fullTVShow, TVShowCredits *tvShowCredits, TVShowAccountStates *tvShowAccountStates) {
                                 fullTVShow.casts = tvShowCredits.cast;
                                 fullTVShow.isFavorite = tvShowAccountStates.favorite;
                                 return fullTVShow;
                             }] flattenMap:^RACStream *(TVShow *show) {
        return [RACSignal combineLatest:@[[self getSeasonsTVShow:show]] reduce:^id(RACTuple *tuple) {
            show.seasons = [tuple allObjects];
            return show;
        }];
    }];
}

#pragma mark - Private

- (RACSignal *)getDetailTVShow:(TVShow *)tvShow
{
    return [self.networkClient rac_method:HTTPMethodGET
                                URLString:[NSString stringWithFormat:kDetailTVShowTheMovieDBURL, tvShow.uid]
                               parameters:
                                       @{
                                               @"api_key" : kTheMovieDBAPIKey,
                                               @"language" : @"en-US"
                                       }
                              resultClass:[TVShow class]
                                   forKey:nil];
}

- (RACSignal *)getCreditsTVShow:(TVShow *)tvShow
{
    return [self.networkClient rac_method:HTTPMethodGET
                                URLString:[NSString stringWithFormat:kCreditsTVShowTheMovieDBURL, tvShow.uid]
                               parameters:
                                       @{
                                               @"api_key" : kTheMovieDBAPIKey,
                                               @"language" : @"en-US"
                                       }
                              resultClass:[TVShowCredits class]
                                   forKey:nil];
}

- (RACSignal *)getAccountStatesTVShow:(TVShow *)tvShow
{
    return [self.networkClient rac_method:HTTPMethodGET
                                URLString:[NSString stringWithFormat:kAccountStatesTVShowTheMovieDBURL, tvShow.uid]
                               parameters:
                                       @{
                                               @"api_key" : kTheMovieDBAPIKey,
                                               @"language" : @"en-US",
                                               @"session_id" : self.sessionModel.uid
                                       }
                              resultClass:[TVShowAccountStates class]
                                   forKey:nil];
}

- (RACSignal *)getSeasonsTVShow:(TVShow *)tvShow
{
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (TVSeason *tvSeason in tvShow.seasons) {
        RACSignal *signal = [self.networkClient rac_method:HTTPMethodGET
                                                 URLString:[NSString stringWithFormat:kSeasonsTVShowTheMovieDBURL, tvShow.uid, tvSeason.seasonNumber]
                                                parameters:
                                                        @{
                                                                @"api_key": kTheMovieDBAPIKey,
                                                                @"language": @"en-US"
                                                        }
                                               resultClass:[TVSeason class]
                                                    forKey:nil];
        [mutableArray addObject:signal];
    }

    return [RACSignal combineLatest:[mutableArray copy]];
}

@end