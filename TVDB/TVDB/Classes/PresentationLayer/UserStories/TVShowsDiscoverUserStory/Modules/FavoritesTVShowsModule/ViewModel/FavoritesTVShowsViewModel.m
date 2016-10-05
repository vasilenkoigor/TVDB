//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "FavoritesTVShowsViewModel.h"
#import "FavoritesTVShowsService.h"
#import "FavoritesTVShowsRouterInput.h"
#import "RACSubject.h"
#import "TVShowCellObject.h"
#import "NSNotificationCenter+RACSupport.h"
#import "CoreDataStack.h"
#import "RACSignal+Operations.h"
#import "NSObject+RACDeallocating.h"

@interface FavoritesTVShowsViewModel ()

@property (strong, nonatomic, readwrite) id <FavoritesTVShowsRouterInput> router;
@property (strong, nonatomic, readwrite) id <FavoritesTVShowsService> favoritesTVShowsService;

@property (strong, nonatomic) NSArray *tvShows;
@property (strong, nonatomic) RACSignal *loadTVShowsErrorSignal;
@property (strong, nonatomic) RACSubject *loadTVShowsErrorSubject;

@end

@implementation FavoritesTVShowsViewModel

- (void)typhoonDidInject
{
    self.loadTVShowsErrorSubject = [RACSubject subject];
    [self loadTVShows];

    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:CoreDataStackWasUpdatedNotification object:nil] takeUntil:[self rac_willDeallocSignal]] subscribeNext:^(id x) {
        [self loadTVShows];
    }];
}

#pragma mark - Load content

- (void)loadTVShows
{
    [[self.favoritesTVShowsService getAllFavoritesTVShows] subscribeNext:^(NSArray *results) {
        self.tvShows = [results copy];
    } error:^(NSError *error) {
        [self.loadTVShowsErrorSubject sendError:error];
    }];
}

- (void)reloadTVShows
{
    [[self.favoritesTVShowsService updateFavoritesTVShowsInCache] subscribeNext:^(NSArray *results) {
        self.tvShows = [results copy];
    } error:^(NSError *error) {
        [self.loadTVShowsErrorSubject sendError:error];
    }];
}

#pragma mark - Navigation

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