//
// Created by Igor Vasilenko on 04/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "FavoritesTVShowsServiceImpl.h"
#import "NetworkClient.h"
#import "CoreDataStack.h"
#import "KeychainService.h"
#import "TVShow.h"
#import "RACSignal.h"
#import "Account.h"
#import "СoreLayerConstants.h"
#import "SessionModel.h"
#import "TVDiscoverResult.h"
#import "RACSignal+Operations.h"

static NSString *const kGetFavoriteTVShowsURL = @"account/%d/favorite/tv";
static NSString *const kMarkAsFavoriteTVShowURL = @"account/%d/favorite?api_key=%@&session_id=%@";

@interface FavoritesTVShowsServiceImpl ()

@property (strong, nonatomic, readwrite) id <NetworkClient> networkClient;
@property (strong, nonatomic, readwrite) id <CoreDataStack> coreDataStack;
@property (strong, nonatomic, readwrite) id <KeychainService> keychainService;

@property (strong, nonatomic) Account *account;
@property (strong, nonatomic) SessionModel *sessionModel;

@end

@implementation FavoritesTVShowsServiceImpl

- (instancetype)initWithNetworkClient:(id <NetworkClient>)networkClient
                        coreDataStack:(id <CoreDataStack>)coreDataStack
                      keychainService:(id <KeychainService>)keychainService
{
    self = [super init];
    if (self) {
        self.networkClient = networkClient;
        self.coreDataStack = coreDataStack;
        self.keychainService = keychainService;

        self.account = [self.keychainService requestAccount];
        self.sessionModel = [self.keychainService requestSession];
    }
    return self;
}

- (RACSignal *)getAllFavoritesTVShows
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([TVShow class])];
    return [[self.coreDataStack fetchAllObjectsWithFetchRequest:fetchRequest] flattenMap:^RACStream *(NSArray *array) {
        if (array.count) {
            return [RACSignal return:array];
        } else {
            return [[self getFavoritesTVShowsFromServer] map:^id(TVDiscoverResult *discoverResult) {
                NSArray *results = discoverResult.results;
                [self.coreDataStack saveObjects:results];
                return results;
            }];
        }
    }];
}

- (RACSignal *)updateFavoritesTVShowsInCache
{
    return [[self getFavoritesTVShowsFromServer] flattenMap:^RACStream *(TVDiscoverResult *discoverResult) {
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([TVShow class])];
        return [[[self.coreDataStack fetchAllObjectsWithFetchRequest:fetchRequest] flattenMap:^RACStream *(NSArray *array) {
            return [self.coreDataStack deleteObjects:array];
        }] flattenMap:^RACStream *(id value) {
            return [self getAllFavoritesTVShows];
        }];
    }];
}


- (RACSignal *)makeTVShowAsFavorite:(TVShow *)tvShow favorite:(BOOL)favorite
{
    return [[self.networkClient rac_method:HTTPMethodPOST
                                URLString:[NSString stringWithFormat:kMarkAsFavoriteTVShowURL, self.account.uid, kTheMovieDBAPIKey, self.sessionModel.uid]
                               parameters:
                                       @{
                                               @"media_type" : @"tv",
                                               @"media_id" : @(tvShow.uid),
                                               @"favorite" : @(favorite)
                                       }] doNext:^(id x) {
        if (!favorite) {
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([TVShow class])];
            fetchRequest.predicate = [NSPredicate predicateWithFormat:@"self.uid == %d", tvShow.uid];
            [[self.coreDataStack fetchAllObjectsWithFetchRequest:fetchRequest] subscribeNext:^(NSArray *results) {
                [self.coreDataStack deleteObjects:results];
            }];
        } else {
            [self.coreDataStack saveObject:tvShow];
        }
    }];
}

- (RACSignal *)getFavoritesTVShowsFromServer
{
    return [self.networkClient rac_method:HTTPMethodGET
                                URLString:[NSString stringWithFormat:kGetFavoriteTVShowsURL, self.account.uid]
                               parameters:
                                       @{
                                               @"api_key" : kTheMovieDBAPIKey,
                                               @"language" : @"en-US",
                                               @"session_id" : self.sessionModel.uid,
                                               @"sort_by" : @"popularity.desc"
                                       }
                              resultClass:[TVDiscoverResult class]
                                   forKey:nil];
}

@end