//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "PopularTVShowsViewModel.h"
#import "TVShowsService.h"
#import "PopularTVShowsRouterInput.h"
#import "KeychainService.h"
#import "RACSignal.h"
#import "TVDiscoverResult.h"
#import "TVShowCellObject.h"
#import "MTLManagedObjectAdapter.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface PopularTVShowsViewModel ()

@property (strong, nonatomic, readwrite) id <TVShowsService> tvShowsService;
@property (strong, nonatomic, readwrite) id <KeychainService> keychainService;
@property (strong, nonatomic, readwrite) id <PopularTVShowsRouterInput> router;

@property (strong, nonatomic) NSArray *tvShows;
@property (strong, nonatomic) RACSignal *loadTVShowsErrorSignal;
@property (strong, nonatomic) RACSubject *loadTVShowsErrorSubject;

@end

@implementation PopularTVShowsViewModel

- (void)typhoonDidInject
{
    self.loadTVShowsErrorSubject = [RACSubject subject];
    [self loadTVShows];
}

#pragma mark - Load content

- (void)loadTVShows
{
    [[self.tvShowsService popularTVShows] subscribeNext:^(TVDiscoverResult *discoverResult) {
        self.tvShows = [discoverResult.results copy];
    } error:^(NSError *error) {
        [self.loadTVShowsErrorSubject sendError:error];
    }];
}

- (void)reloadTVShows
{
    [self loadTVShows];
}

#pragma mark - Navigation

- (void)logOutFromAccount
{
    [self.keychainService deleteAuthenticationData];
    [self.router closeCurrentModule];
}

- (void)discoverTVShow:(TVShowCellObject *)tvShowCellObject
{
    [self.router openDiscoverTVShowWithTVShow:tvShowCellObject.tvShow];
}

#pragma mark - Getters

- (RACSignal *)loadTVShowsErrorSignal
{
    if (!_loadTVShowsErrorSignal) {
        _loadTVShowsErrorSignal = self.loadTVShowsErrorSubject;
    }
    return _loadTVShowsErrorSignal;
}

@end